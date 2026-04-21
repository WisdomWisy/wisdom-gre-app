import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdom_gre_app/features/multiplayer/data/models/profile.dart';

part 'auth_state_provider.g.dart';

@riverpod
Stream<AuthState> authState(AuthStateRef ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
}

@riverpod
User? currentUser(Ref ref) {
  return Supabase.instance.client.auth.currentUser;
}



@riverpod
Stream<Profile?> userProfile(Ref ref) async* {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    yield null;
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  final cachedStr = prefs.getString('cached_profile_${user.id}');
  if (cachedStr != null) {
    try {
      yield Profile.fromJson(jsonDecode(cachedStr));
    } catch (_) {}
  }

  try {
    final stream = Supabase.instance.client
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', user.id);

    await for (final data in stream) {
      if (data.isNotEmpty) {
        final profile = Profile.fromJson(data.first);
        prefs.setString('cached_profile_${user.id}', jsonEncode(profile.toJson()));
        yield profile;
      } else {
        prefs.remove('cached_profile_${user.id}');
        yield null;
      }
    }
  } catch (error) {
    if (cachedStr == null) {
      rethrow;
    }
  }
}

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      state = const AsyncData(null);
    } on AuthException catch (e) {
      state = AsyncError(e.message, StackTrace.current);
      rethrow;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> signUpWithEmail(
      String email, String password, String firstName, String lastName, String username) async {
    state = const AsyncLoading();
    try {
      await Supabase.instance.client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {
          'first_name': firstName.trim(),
          'last_name': lastName.trim(),
          'username': username.trim(),
        },
      );
      state = const AsyncData(null);
    } on AuthException catch (e) {
      state = AsyncError(e.message, StackTrace.current);
      rethrow;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await Supabase.instance.client.auth.signOut();
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }
}
