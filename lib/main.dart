import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wisdom_gre_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:wisdom_gre_app/features/auth/presentation/auth_screen.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';
import 'package:wisdom_gre_app/features/auth/presentation/invalid_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Background Isolation for Podcasts
  FlutterForegroundTask.initCommunicationPort();
  
  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  await _initRevenueCat();

  runApp(const ProviderScope(child: WisdomGreApp()));
}

Future<void> _initRevenueCat() async {
  await Purchases.setLogLevel(LogLevel.info);

  PurchasesConfiguration? configuration;
  if (Platform.isAndroid) {
    configuration = PurchasesConfiguration(dotenv.env['REVENUECAT_GOOGLE_API_KEY'] ?? '');
  } else if (Platform.isIOS) {
    configuration = PurchasesConfiguration(dotenv.env['REVENUECAT_APPLE_API_KEY'] ?? '');
  }
  
  if (configuration != null) {
    await Purchases.configure(configuration);
  }

  // Listen to Auth State to automatically map Supabase User ID to RevenueCat
  Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
    final session = data.session;
    if (session != null) {
      try {
        await Purchases.logIn(session.user.id);
      } catch (e) {
        debugPrint('Error logging in to RevenueCat: $e');
      }
    } else {
      try {
        await Purchases.logOut();
      } catch (e) {
        // Ignorer l'erreur si l'utilisateur est déjà anonyme
        debugPrint('RevenueCat logout info: $e');
      }
    }
  });
}

class WisdomGreApp extends ConsumerWidget {
  const WisdomGreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch AuthState to handle implicit routing
    final authStateAsync = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'Premium GRE Vocabulary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: Consumer(
        builder: (context, ref, child) {
          final authStateAsync = ref.watch(authStateProvider);
          final session = Supabase.instance.client.auth.currentSession;

          if (session != null) {
            final profileAsync = ref.watch(userProfileProvider);
            return profileAsync.when(
              skipError: true,
              data: (profile) {
                if (profile != null) {
                  return const DashboardScreen();
                } else {
                  return const InvalidProfileScreen();
                }
              },
              loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
              error: (err, stack) => Scaffold(body: Center(child: Text('Database Offline\n$err'))),
            );
          }

          return authStateAsync.when(
            data: (_) => const AuthScreen(),
            loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
            // If the user has no session AND network is offline, they stay on AuthScreen to login later.
            error: (error, stack) => const AuthScreen(),
          );
        },
      ),
    );
  }
}
