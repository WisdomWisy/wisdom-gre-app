import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdom_gre_app/features/multiplayer/data/models/duel.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';

part 'lobby_controller.g.dart';

@riverpod
Stream<List<Duel>> userLobbies(Ref ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);

  // Hub Realtime Blaster: Listens to any participant movement globally 
  // and invalidates this stream so the X/10 counters ALWAYS refresh!
  final channel = Supabase.instance.client.channel('global_hub_updates_${user.id}')
    .onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'duel_participants',
      callback: (payload) {
         ref.invalidateSelf();
      }
    )
    .onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'duels',
      callback: (payload) {
         ref.invalidateSelf();
      }
    )
    .subscribe();

  ref.onDispose(() {
    Supabase.instance.client.removeChannel(channel);
  });

  return Supabase.instance.client
      .from('duel_participants')
      .stream(primaryKey: ['id'])
      .eq('user_id', user.id)
      .asyncMap((participants) async {
        if (participants.isEmpty) return <Duel>[];
        
        final duelIds = participants.map((p) => p['duel_id']).toList();
        
        final response = await Supabase.instance.client
            .from('duels')
            .select('*, duel_participants(*, profiles(*))')
            .inFilter('id', duelIds)
            .eq('status', 'waiting');
            
        return response.map((data) => Duel.fromJson(data)).toList();
      });
}

final onlineUsersProvider = StateProvider<Set<String>>((ref) => {});

@Riverpod(keepAlive: true)
class LobbyController extends _$LobbyController {
  RealtimeChannel? _duelSubscription;

  @override
  FutureOr<Duel?> build() async {
    ref.onDispose(_closeSubscription);
    return null;
  }

  Future<void> connectToDuel(String duelId) async {
    state = const AsyncLoading();
    try {
      final duel = await _fetchDuel(duelId);
      state = AsyncData(duel);
      _subscribeToDuel(duelId);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  void _closeSubscription() {
    if (_duelSubscription != null) {
      _duelSubscription!.untrack();
      Supabase.instance.client.removeChannel(_duelSubscription!);
      _duelSubscription = null;
    }
  }

  Future<Duel> _fetchDuel(String duelId) async {
    final response = await Supabase.instance.client
        .from('duels')
        .select('*, duel_participants(*, profiles(*))')
        .eq('id', duelId)
        .single();
    return Duel.fromJson(response);
  }

  Future<void> _reloadDuel(String duelId) async {
    try {
      final duel = await _fetchDuel(duelId);
      // If cancelled, reset state
      if (duel.status == 'cancelled') {
        resetLobby();
      } else {
        state = AsyncData(duel);
      }
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST116') {
        // Not found, likely deleted
        resetLobby();
      }
    }
  }

  Future<void> kickParticipant(String duelId, String participantUserId) async {
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) return;

      final duelData = await Supabase.instance.client
          .from('duels')
          .select('host_id')
          .eq('id', duelId)
          .maybeSingle();

      if (duelData != null && duelData['host_id'] == user.id) {
        await Supabase.instance.client
            .from('duel_participants')
            .delete()
            .match({'duel_id': duelId, 'user_id': participantUserId});
      }
    } catch (e) {
      // Ignore errors silently for now
    }
  }

  Future<void> leaveDuel(String duelId) async {
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) return;

      // Check if user is host
      final duelData = await Supabase.instance.client
          .from('duels')
          .select('host_id')
          .eq('id', duelId)
          .maybeSingle();

      if (duelData != null && duelData['host_id'] == user.id) {
        // I am the host, destroy the room
        await Supabase.instance.client.from('duels').delete().eq('id', duelId);
      } else {
        // I am a challenger, just leave the room
        await Supabase.instance.client
            .from('duel_participants')
            .delete()
            .match({'duel_id': duelId, 'user_id': user.id});
      }
      
      // If we are currently watching this duel, reset
      if (state.valueOrNull?.id == duelId) {
        resetLobby();
      }
    } catch (e) {
      // Ignore errors for silent leaves
    }
  }

  Future<void> leaveAllOtherDuels(String keepDuelId, List<String> allDuelIds) async {
    for (final id in allDuelIds) {
      if (id != keepDuelId) {
        await leaveDuel(id);
      }
    }
  }

  Future<void> leaveAllDuels(List<String> allDuelIds) async {
    for (final id in allDuelIds) {
      await leaveDuel(id);
    }
  }

  Future<void> createDuel({int maxPlayers = 10}) async {
    state = const AsyncLoading();
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        throw Exception("You must be authenticated to create a duel.");
      }

      // Generate 6-char random code
      final random = Random();
      const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      final code = List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();

      // Insert into Supabase
      final response = await Supabase.instance.client
          .from('duels')
          .insert({
            'room_code': code,
            'host_id': user.id,
            'max_players': maxPlayers,
            'status': 'waiting',
          })
          .select()
          .single();

      final duelId = response['id'] as String;

      // Add host to participants
      await Supabase.instance.client
          .from('duel_participants')
          .insert({
            'duel_id': duelId,
            'user_id': user.id,
          });

      final duel = await _fetchDuel(duelId);
      state = AsyncData(duel);

      _subscribeToDuel(duel.id);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> startBattle(String duelId) async {
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) return;

      final currentDuel = state.valueOrNull;
      if (currentDuel != null && currentDuel.hostId == user.id) {
        await Supabase.instance.client
            .from('duels')
            .update({'status': 'playing'})
            .eq('id', duelId);
            
        // Optimistically update the state so the UI listener fires immediately 
        // without waiting for Postgres replication lag.
        final updatedDuel = currentDuel.copyWith(status: 'playing');
        state = AsyncData(updatedDuel);
      }
    } catch (e, stack) {
      print("START BATTLE ERROR: $e");
      state = AsyncError(e, stack);
    }
  }

  Future<void> joinDuel(String code) async {
    state = const AsyncLoading();
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        throw Exception("You must be authenticated to join a duel.");
      }

      final normalizedCode = code.toUpperCase().trim();

      // Find the duel
      final response = await Supabase.instance.client
          .from('duels')
          .select('*, duel_participants(*)')
          .eq('room_code', normalizedCode)
          .eq('status', 'waiting')
          .maybeSingle();

      if (response == null) {
        throw Exception("Room not found or game already started.");
      }

      final duelId = response['id'] as String;
      final maxPlayers = response['max_players'] as int;
      final participants = response['duel_participants'] as List;

      if (participants.length >= maxPlayers) {
         throw Exception("Room is already full! ($maxPlayers/$maxPlayers)");
      }
      
      // Check if already joined
      final alreadyJoined = participants.any((p) => p['user_id'] == user.id);
      
      if (!alreadyJoined) {
        // Insert participant
        await Supabase.instance.client
            .from('duel_participants')
            .insert({
              'duel_id': duelId,
              'user_id': user.id,
            });
      }

      final duel = await _fetchDuel(duelId);
      state = AsyncData(duel);

      _subscribeToDuel(duel.id);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  void _subscribeToDuel(String duelId) {
    _closeSubscription();
    final user = ref.read(currentUserProvider);

    final channel = Supabase.instance.client.channel('public:lobby:$duelId');
    _duelSubscription = channel;

    channel
        .onPresenceSync((payload) {
          final presenceStates = channel.presenceState();
          final activeIds = <String>{};
          for (final state in presenceStates) {
            for (final status in state.presences) {
              final id = status.payload['user_id'] as String?;
              if (id != null) activeIds.add(id);
            }
          }
          ref.read(onlineUsersProvider.notifier).state = activeIds;
        })
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'duels',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'id',
              value: duelId,
            ),
            callback: (payload) {
               _reloadDuel(duelId);
            })
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'duel_participants',
            callback: (payload) {
               _reloadDuel(duelId);
            })
        .subscribe((status, [err]) {
          if (status == RealtimeSubscribeStatus.subscribed && user != null) {
            channel.track({'user_id': user.id});
          }
        });
  }

  void resetLobby() {
    _closeSubscription();
    state = const AsyncData(null);
  }
}
