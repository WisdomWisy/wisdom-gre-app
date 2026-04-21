import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';

class InvalidProfileScreen extends ConsumerWidget {
  const InvalidProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeControllerProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: MeshBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.surfaceColor.withValues(alpha: 0.3),
                      border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5), width: 2),
                    ),
                    child: const Icon(Icons.security_rounded, size: 80, color: Colors.redAccent),
                  ),
                  const SizedBox(height: 48),
                  Text(
                    'Access Restricted',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: theme.textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your account profile could not be found or has been revoked. Please sign out and create a new profile to continue using the Premium Arena.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      height: 1.5,
                      color: theme.textColor.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 48),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.surfaceColor.withValues(alpha: 0.7),
                          border: Border.all(color: theme.textColor.withValues(alpha: 0.1)),
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ref.read(authControllerProvider.notifier).signOut();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 8,
                            shadowColor: Colors.redAccent.withValues(alpha: 0.5),
                            minimumSize: const Size.fromHeight(60),
                          ),
                          icon: const Icon(Icons.logout_rounded, size: 24),
                          label: Text(
                            'Sign Out Securely',
                            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
