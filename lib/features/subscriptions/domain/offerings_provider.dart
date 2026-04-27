import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'offerings_provider.g.dart';

@riverpod
Future<Offerings?> offerings(OfferingsRef ref) async {
  try {
    final offerings = await Purchases.getOfferings();
    return offerings;
  } catch (e) {
    // If RevenueCat is not yet fully configured or has no packages, this might throw.
    return null;
  }
}
