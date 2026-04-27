import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wisdom_gre_app/features/subscriptions/domain/subscription_provider.dart';

part 'promo_code_service.g.dart';

class PromoCodeException implements Exception {
  final String message;
  PromoCodeException(this.message);
  @override
  String toString() => message;
}

@riverpod
class PromoCodeService extends _$PromoCodeService {
  @override
  void build() {}

  /// Redeems a promo code by calling the Supabase Edge Function 'redeem-promo'.
  /// If successful, forces RevenueCat to sync purchases and invalidates the subscriptionStatusProvider.
  Future<void> redeemCode(String codeText) async {
    final code = codeText.trim().toUpperCase();
    if (code.isEmpty) {
      throw PromoCodeException("Please enter a code.");
    }

    try {
      final appUserId = await Purchases.appUserID;
      
      // Invoke the Edge Function
      final response = await Supabase.instance.client.functions.invoke(
        'redeem-promo',
        body: {
          'code': code,
          'app_user_id': appUserId,
        },
      );

      if (response.status == 200) {
        // Success! The Edge Function granted the promotional entitlement.
        // We must sync purchases locally so RevenueCat SDK fetches the new entitlement.
        await Purchases.syncPurchases();
        
        // Force Riverpod to refresh the subscription status
        ref.invalidate(subscriptionStatusProvider);
      } else {
        // Edge Function returned an error (e.g., 400 for invalid/expired code)
        final errorMsg = response.data['error'] ?? "An unknown error occurred.";
        throw PromoCodeException(errorMsg);
      }
    } on FunctionException catch (e) {
      // Supabase Function invocation failed (e.g. 500 error)
      String errorMsg = "Could not validate code.";
      try {
         // Attempt to parse JSON error message if possible
         if (e.details != null && e.details is Map && e.details['error'] != null) {
           errorMsg = e.details['error'];
         }
      } catch (_) {}
      throw PromoCodeException(errorMsg);
    } catch (e) {
      if (e is PromoCodeException) rethrow;
      throw PromoCodeException("Failed to redeem code: $e");
    }
  }
}
