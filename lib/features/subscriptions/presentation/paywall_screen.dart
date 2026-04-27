import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/subscriptions/domain/offerings_provider.dart';
import 'package:wisdom_gre_app/features/subscriptions/domain/subscription_provider.dart';
import 'package:wisdom_gre_app/core/components/settings_dialog.dart';

// StateProvider to handle the loading state during purchases
final paywallLoadingProvider = StateProvider<bool>((ref) => false);

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  void _showPromoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const SettingsDialog(), // Or we can extract PromoCodeSection to its own dialog later
    );
  }

  Future<void> _purchasePackage(BuildContext context, WidgetRef ref, Package package) async {
    ref.read(paywallLoadingProvider.notifier).state = true;
    try {
      final purchaseResult = await Purchases.purchasePackage(package);
      final isPro = purchaseResult.customerInfo.entitlements.active.containsKey("premium");
      if (isPro && context.mounted) {
        // The ref.listen will handle popping the screen.
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Purchase failed: ${e.message}'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    } finally {
      if (context.mounted) {
        ref.read(paywallLoadingProvider.notifier).state = false;
      }
    }
  }

  Future<void> _restorePurchases(BuildContext context, WidgetRef ref) async {
    ref.read(paywallLoadingProvider.notifier).state = true;
    try {
      final customerInfo = await Purchases.restorePurchases();
      final isPro = customerInfo.entitlements.active.containsKey("premium");
      if (isPro && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Purchases successfully restored!'),
            backgroundColor: Colors.green,
          ),
        );
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No previous purchases found.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error restoring purchases: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (context.mounted) {
        ref.read(paywallLoadingProvider.notifier).state = false;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Auto-pop when premium status becomes true
    ref.listen<AsyncValue<bool>>(subscriptionStatusProvider, (previous, next) {
      if (next.value == true && context.mounted) {
        Navigator.of(context).pop();
      }
    });

    final isLoading = ref.watch(paywallLoadingProvider);
    final offeringsAsync = ref.watch(offeringsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark Platinium background
      body: Stack(
        children: [
          // Background Gradient Orbs
          Positioned(
            top: -100,
            left: -100,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.2), // Gold
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF00FFCC).withValues(alpha: 0.1), // Cyan accent
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  // Close Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Header
                  const Text(
                    'WISDOM-x-LANE GRE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Platinium',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [Color(0xFFE5E7EB), Color(0xFF9CA3AF)],
                        ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Benefits List
                  _buildBenefitRow(Icons.all_inclusive, 'Unlimited Words', 'Master the entire premium database'),
                  const SizedBox(height: 20),
                  _buildBenefitRow(Icons.sports_esports, 'Unlimited Arena', 'Unrestricted multiplayer matchmaking'),
                  const SizedBox(height: 20),
                  _buildBenefitRow(Icons.query_stats, 'Full Analytics', 'Track your performance and weaknesses'),
                  
                  const SizedBox(height: 48),

                  // Packages Section
                  offeringsAsync.when(
                    data: (offerings) {
                      if (offerings == null || offerings.current == null || offerings.current!.availablePackages.isEmpty) {
                        return _buildGlassCard(
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'No plans available right now.\nPlease check back later.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        );
                      }

                      final packages = offerings.current!.availablePackages;
                      // Display each package as a selectable card
                      return Column(
                        children: packages.map((pkg) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _PackageCard(
                            package: pkg,
                            isLoading: isLoading,
                            onSelect: () => _purchasePackage(context, ref, pkg),
                          ),
                        )).toList(),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37))),
                    error: (error, stack) => const Center(
                      child: Text(
                        'Failed to load plans.',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Have a promo code
                  TextButton(
                    onPressed: isLoading ? null : () => _showPromoDialog(context),
                    child: const Text(
                      'Have a promo code?',
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),

                  // Restore Purchases
                  TextButton(
                    onPressed: isLoading ? null : () => _restorePurchases(context, ref),
                    child: const Text(
                      'Restore Purchases',
                      style: TextStyle(
                        color: Colors.white54,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white54,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Legal Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => debugPrint('ToS clicked'),
                        child: const Text(
                          'Terms of Service',
                          style: TextStyle(fontSize: 12, color: Colors.white38),
                        ),
                      ),
                      const Text('•', style: TextStyle(color: Colors.white38)),
                      TextButton(
                        onPressed: () => debugPrint('Privacy Policy clicked'),
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyle(fontSize: 12, color: Colors.white38),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          
          // Overall Loading Overlay
          if (isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBenefitRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFD4AF37), size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final Package package;
  final bool isLoading;
  final VoidCallback onSelect;

  const _PackageCard({
    required this.package,
    required this.isLoading,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onSelect,
      borderRadius: BorderRadius.circular(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.storeProduct.title.replaceAll(RegExp(r'\(.*\)'), '').trim(), // Cleans up standard store parenthesis
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        package.storeProduct.description,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  package.storeProduct.priceString,
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
