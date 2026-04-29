import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';

part 'difficulty_filter_provider.g.dart';

@riverpod
class DifficultyFilterController extends _$DifficultyFilterController {
  @override
  String build() {
    // Read the initial value from the profile stream synchronously if possible,
    // otherwise default to 'all'. The provider will auto-update if we watch userProfileProvider.
    final profile = ref.watch(userProfileProvider).valueOrNull;
    return profile?.difficultyPreference ?? 'all';
  }

  Future<void> setDifficulty(String difficulty) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    // Optimistic update
    state = difficulty;

    try {
      await Supabase.instance.client
          .from('profiles')
          .update({'difficulty_preference': difficulty})
          .eq('id', user.id);
    } catch (e) {
      // Revert on error
      final profile = ref.read(userProfileProvider).valueOrNull;
      state = profile?.difficultyPreference ?? 'all';
      rethrow;
    }
  }
}
