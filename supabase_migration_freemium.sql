-- Run this script in your Supabase SQL Editor

-- 1. Add new columns to the profiles table
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS daily_duels_count INT DEFAULT 0,
ADD COLUMN IF NOT EXISTS last_duel_date DATE;

-- 2. Create an RPC to safely increment the duel count
CREATE OR REPLACE FUNCTION increment_daily_duel(user_uuid UUID)
RETURNS void AS $$
DECLARE
  current_date DATE := CURRENT_DATE;
BEGIN
  -- If last_duel_date is not today, reset count to 1 and update date
  -- Otherwise, just increment the count
  UPDATE public.profiles
  SET 
    daily_duels_count = CASE 
      WHEN last_duel_date = current_date THEN daily_duels_count + 1 
      ELSE 1 
    END,
    last_duel_date = current_date
  WHERE id = user_uuid;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
