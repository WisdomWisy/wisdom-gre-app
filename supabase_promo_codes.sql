-- Run this script in your Supabase SQL Editor

CREATE TABLE public.promo_codes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code TEXT UNIQUE NOT NULL,
    reward_duration TEXT NOT NULL, -- Format expected by RevenueCat, e.g., '1_month', '1_week'
    max_uses INT NOT NULL DEFAULT 1,
    current_uses INT NOT NULL DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT true,
    expires_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE public.promo_codes ENABLE ROW LEVEL SECURITY;

-- Block ALL access from authenticated and anonymous users
-- Since there are no policies created for 'authenticated' or 'anon', 
-- default-deny will block them entirely.

-- Insert a test code
INSERT INTO public.promo_codes (code, reward_duration, max_uses, expires_at)
VALUES ('GRE2026', '1_month', 100, NOW() + INTERVAL '1 year');

-- Create RPC for atomic update and validation
CREATE OR REPLACE FUNCTION redeem_promo_code_atomic(p_code TEXT)
RETURNS TABLE (
    r_id UUID,
    r_reward_duration TEXT
) AS $$
BEGIN
    RETURN QUERY
    UPDATE public.promo_codes
    SET current_uses = current_uses + 1
    WHERE code = p_code
      AND is_active = true
      AND current_uses < max_uses
      AND (expires_at IS NULL OR expires_at > NOW())
    RETURNING id, reward_duration;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
