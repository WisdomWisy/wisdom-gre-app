import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> with SingleTickerProviderStateMixin {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    ));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutQuart),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final username = _usernameController.text;

    if (email.isEmpty || password.isEmpty) return;
    if (_isSignUp && (firstName.isEmpty || lastName.isEmpty || username.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all profile fields to continue.'), backgroundColor: Colors.redAccent)
      );
      return;
    }

    try {
      if (_isSignUp) {
        await ref.read(authControllerProvider.notifier).signUpWithEmail(email, password, firstName, lastName, username);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account deployed! Check your email to verify.'),
              backgroundColor: Colors.green,
            ),
          );
          // Auto switch to login mode to make UX smoother
          setState(() {
            _isSignUp = false;
          });
        }
      } else {
        await ref.read(authControllerProvider.notifier).signInWithEmail(email, password);
      }
    } catch (e) {
      // The `ref.listen` in build() will also capture AsyncErrors from the provider,
      // but catching here ensures we don't crash from unhandled exceptions.
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeControllerProvider);
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    ref.listen(authControllerProvider, (prev, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: MeshBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo/Hero Area
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.surfaceColor.withValues(alpha: 0.3),
                          border: Border.all(color: theme.textColor.withValues(alpha: 0.1)),
                        ),
                        child: Icon(Icons.bolt, size: 80, color: const Color(0xFFED8F03)),
                      ),
                      const SizedBox(height: 48),
                      Text(
                        'Wisdom GRE',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: theme.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Access the Multiplayer Arena',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: theme.textColor.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Glassmorphic Form
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
                            child: Column(
                              children: [
                                // Custom Segmented Tab for Login/Signup
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: theme.textColor.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => setState(() => _isSignUp = false),
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 200),
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            decoration: BoxDecoration(
                                              color: !_isSignUp ? theme.surfaceColor : Colors.transparent,
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: !_isSignUp ? [BoxShadow(color: theme.textColor.withValues(alpha: 0.1), blurRadius: 8)] : [],
                                            ),
                                            child: Text(
                                              'Log In',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                color: !_isSignUp ? theme.textColor : theme.textColor.withValues(alpha: 0.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => setState(() => _isSignUp = true),
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 200),
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            decoration: BoxDecoration(
                                              color: _isSignUp ? theme.surfaceColor : Colors.transparent,
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: _isSignUp ? [BoxShadow(color: theme.textColor.withValues(alpha: 0.1), blurRadius: 8)] : [],
                                            ),
                                            child: Text(
                                              'Create Profile',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                color: _isSignUp ? theme.textColor : theme.textColor.withValues(alpha: 0.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                if (_isSignUp) ...[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildTextField(
                                          controller: _firstNameController,
                                          theme: theme,
                                          icon: Icons.person_outline,
                                          hint: 'First Name',
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: _buildTextField(
                                          controller: _lastNameController,
                                          theme: theme,
                                          icon: Icons.person_outline,
                                          hint: 'Last Name',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _usernameController,
                                    theme: theme,
                                    icon: Icons.alternate_email,
                                    hint: 'Gamer Pseudo',
                                  ),
                                  const SizedBox(height: 16),
                                ],
                                _buildTextField(
                                  controller: _emailController,
                                  theme: theme,
                                  icon: Icons.email_outlined,
                                  hint: 'Email Address',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  controller: _passwordController,
                                  theme: theme,
                                  icon: Icons.lock_outline,
                                  hint: 'Password',
                                  obscureText: true,
                                ),
                                const SizedBox(height: 32),
                                ElevatedButton(
                                  onPressed: isLoading ? null : _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFED8F03),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    elevation: 8,
                                    shadowColor: const Color(0xFFED8F03).withValues(alpha: 0.5),
                                    minimumSize: const Size.fromHeight(60),
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                        )
                                      : Text(
                                          _isSignUp ? 'Deploy Profile' : 'Authenticate',
                                          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                ),
                              ],
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
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required AppThemeData theme,
    required IconData icon,
    required String hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surfaceColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(color: theme.textColor),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: theme.textColor.withValues(alpha: 0.5)),
          hintText: hint,
          hintStyle: TextStyle(color: theme.textColor.withValues(alpha: 0.3)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
      ),
    );
  }
}
