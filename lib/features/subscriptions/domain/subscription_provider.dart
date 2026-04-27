import 'dart:async';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_provider.g.dart';

@riverpod
Stream<bool> subscriptionStatus(SubscriptionStatusRef ref) {
  final controller = StreamController<bool>();

  void checkPremium(CustomerInfo info) {
    controller.add(info.entitlements.active.containsKey('premium'));
  }

  // Initial fetch
  Purchases.getCustomerInfo().then((info) {
    checkPremium(info);
  }).catchError((_) {
    controller.add(false);
  });

  // Listen to updates
  Purchases.addCustomerInfoUpdateListener(checkPremium);

  ref.onDispose(() {
    Purchases.removeCustomerInfoUpdateListener(checkPremium);
    controller.close();
  });

  return controller.stream;
}
