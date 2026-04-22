import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';

part 'multiplayer_arena_controller.g.dart';

class BattleLogEntry {
  final String userId;
  final String action;
  final String word;
  
  BattleLogEntry({required this.userId, required this.action, required this.word});
}

class ArenaState {
  final Map<String, int> scores;
  final List<BattleLogEntry> battleLog;
  final List<String> seed; // Word IDs or words sequence
  final int duration; // Configurable length of match 
  final String mode; // Game mode: 'def_to_word' or 'word_to_def'

  ArenaState({
    required this.scores,
    required this.battleLog,
    required this.seed,
    required this.duration,
    required this.mode,
  });

  ArenaState copyWith({
    Map<String, int>? scores,
    List<BattleLogEntry>? battleLog,
    List<String>? seed,
    int? duration,
    String? mode,
  }) {
    return ArenaState(
      scores: scores ?? this.scores,
      battleLog: battleLog ?? this.battleLog,
      seed: seed ?? this.seed,
      duration: duration ?? this.duration,
      mode: mode ?? this.mode,
    );
  }
}

@Riverpod(keepAlive: true)
class MultiplayerArenaController extends _$MultiplayerArenaController {
  RealtimeChannel? _channel;

  @override
  ArenaState build(String duelId) {
    ref.onDispose(() {
      if (_channel != null) {
        _channel!.unsubscribe();
        Supabase.instance.client.removeChannel(_channel!);
      }
    });

    _initializeBroadcast(duelId);
    return ArenaState(scores: {}, battleLog: [], seed: [], duration: 60, mode: 'def_to_word');
  }

  void _initializeBroadcast(String duelId) {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    _channel = Supabase.instance.client.channel('battle_room_$duelId');

    _channel!
        .onBroadcast(
            event: 'score_update',
            callback: (payload) {
              final String userId = payload['user_id'] as String;
              final int newScore = payload['current_score'] as int;
              final String action = payload['action'] as String;
              final String word = payload['word'] as String;

              final newState = Map<String, int>.from(state.scores);
              newState[userId] = newScore;
              
              final newLog = List<BattleLogEntry>.from(state.battleLog);
              newLog.insert(0, BattleLogEntry(userId: userId, action: action, word: word));
              if (newLog.length > 5) {
                newLog.removeLast(); // Keep only 5 last entries for UI efficiency
              }

              state = state.copyWith(scores: newState, battleLog: newLog);
            })
        .onBroadcast(
            event: 'seed_init',
            callback: (payload) {
              final List<dynamic> rawSeed = payload['seed'] as List<dynamic>;
              final List<String> loadedSeed = rawSeed.cast<String>();
              final int duration = payload['duration'] as int? ?? 60;
              final String mode = payload['mode'] as String? ?? 'def_to_word';
              
              state = state.copyWith(seed: loadedSeed, duration: duration, mode: mode);
            })
        .subscribe();
    
    Future.microtask(() {
      state = state.copyWith(scores: {user.id: 0});
    });
  }

  Future<void> broadcastSeed(List<String> seedParams, int duration, String mode) async {
    final user = ref.read(currentUserProvider);
    if (user == null || _channel == null) return;

    state = state.copyWith(seed: seedParams, duration: duration, mode: mode);

    try {
      await _channel!.sendBroadcastMessage(
        event: 'seed_init',
        payload: {
          'seed': seedParams,
          'duration': duration,
          'mode': mode,
        },
      );
    } catch (_) {}
  }

  Future<void> sendScoreAction(int newAbsoluteScore, String action, String wordDesc) async {
    final user = ref.read(currentUserProvider);
    if (user == null || _channel == null) return;

    final newState = Map<String, int>.from(state.scores);
    newState[user.id] = newAbsoluteScore;
    
    final newLog = List<BattleLogEntry>.from(state.battleLog);
    newLog.insert(0, BattleLogEntry(userId: user.id, action: action, word: wordDesc));
    if (newLog.length > 5) newLog.removeLast();

    state = state.copyWith(scores: newState, battleLog: newLog);

    try {
      await _channel!.sendBroadcastMessage(
        event: 'score_update',
        payload: {
          'user_id': user.id,
          'current_score': newAbsoluteScore,
          'action': action,
          'word': wordDesc,
        },
      );
    } catch (_) {}
  }
}
