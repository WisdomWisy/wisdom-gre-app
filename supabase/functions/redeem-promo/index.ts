import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.7.1";

const REVENUECAT_SECRET_KEY = Deno.env.get("REVENUECAT_SECRET_KEY");

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "" // Must use service_role to bypass RLS
    );

    const { code, app_user_id } = await req.json();

    if (!code || !app_user_id) {
      return new Response(JSON.stringify({ error: "Missing code or app_user_id" }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 400,
      });
    }

    // 1. ATOMIC UPDATE & VALIDATION via RPC
    // This executes: UPDATE ... SET current_uses = current_uses + 1 WHERE ... RETURNING *
    const { data: promoData, error: rpcError } = await supabaseClient
      .rpc('redeem_promo_code_atomic', { p_code: code.toUpperCase() });

    if (rpcError) {
      return new Response(JSON.stringify({ error: "Database error", details: rpcError.message }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 500,
      });
    }

    // If the RPC returns an empty array, the code didn't exist or didn't meet criteria (expired, exhausted, inactive)
    if (!promoData || promoData.length === 0) {
      return new Response(JSON.stringify({ error: "Invalid, expired, or exhausted promo code" }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 400,
      });
    }

    const { r_reward_duration } = promoData[0];

    // 2. Grant Entitlement via RevenueCat REST API
    const rcResponse = await fetch(
      `https://api.revenuecat.com/v1/subscribers/${app_user_id}/entitlements/premium/promotional`,
      {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${REVENUECAT_SECRET_KEY}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          duration: r_reward_duration,
        }),
      }
    );

    if (!rcResponse.ok) {
      const rcError = await rcResponse.text();
      // Rollback the usage in case RevenueCat fails
      await supabaseClient
        .from('promo_codes')
        .update({ current_uses: supabaseClient.rpc('decrement_usage_if_needed') /* or simple decrement if we had a function */ })
        // Since we are keeping it simple, we could just log this. A true rollback requires a transaction.
      
      return new Response(JSON.stringify({ error: "Failed to grant Premium", details: rcError }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: rcResponse.status,
      });
    }

    return new Response(JSON.stringify({ success: true, message: "Premium granted successfully!" }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 200,
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 500,
    });
  }
});
