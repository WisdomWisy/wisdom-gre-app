// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Duel {

 String get id;@JsonKey(name: 'room_code') String get roomCode;@JsonKey(name: 'host_id') String get hostId;@JsonKey(name: 'max_players') int get maxPlayers; String get status;@JsonKey(name: 'created_at') DateTime get createdAt;// Relational join data
@JsonKey(name: 'duel_participants') List<DuelParticipant> get participants;
/// Create a copy of Duel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DuelCopyWith<Duel> get copyWith => _$DuelCopyWithImpl<Duel>(this as Duel, _$identity);

  /// Serializes this Duel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Duel&&(identical(other.id, id) || other.id == id)&&(identical(other.roomCode, roomCode) || other.roomCode == roomCode)&&(identical(other.hostId, hostId) || other.hostId == hostId)&&(identical(other.maxPlayers, maxPlayers) || other.maxPlayers == maxPlayers)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.participants, participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,roomCode,hostId,maxPlayers,status,createdAt,const DeepCollectionEquality().hash(participants));

@override
String toString() {
  return 'Duel(id: $id, roomCode: $roomCode, hostId: $hostId, maxPlayers: $maxPlayers, status: $status, createdAt: $createdAt, participants: $participants)';
}


}

/// @nodoc
abstract mixin class $DuelCopyWith<$Res>  {
  factory $DuelCopyWith(Duel value, $Res Function(Duel) _then) = _$DuelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'room_code') String roomCode,@JsonKey(name: 'host_id') String hostId,@JsonKey(name: 'max_players') int maxPlayers, String status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'duel_participants') List<DuelParticipant> participants
});




}
/// @nodoc
class _$DuelCopyWithImpl<$Res>
    implements $DuelCopyWith<$Res> {
  _$DuelCopyWithImpl(this._self, this._then);

  final Duel _self;
  final $Res Function(Duel) _then;

/// Create a copy of Duel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomCode = null,Object? hostId = null,Object? maxPlayers = null,Object? status = null,Object? createdAt = null,Object? participants = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomCode: null == roomCode ? _self.roomCode : roomCode // ignore: cast_nullable_to_non_nullable
as String,hostId: null == hostId ? _self.hostId : hostId // ignore: cast_nullable_to_non_nullable
as String,maxPlayers: null == maxPlayers ? _self.maxPlayers : maxPlayers // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<DuelParticipant>,
  ));
}

}


/// Adds pattern-matching-related methods to [Duel].
extension DuelPatterns on Duel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Duel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Duel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Duel value)  $default,){
final _that = this;
switch (_that) {
case _Duel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Duel value)?  $default,){
final _that = this;
switch (_that) {
case _Duel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'room_code')  String roomCode, @JsonKey(name: 'host_id')  String hostId, @JsonKey(name: 'max_players')  int maxPlayers,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'duel_participants')  List<DuelParticipant> participants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Duel() when $default != null:
return $default(_that.id,_that.roomCode,_that.hostId,_that.maxPlayers,_that.status,_that.createdAt,_that.participants);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'room_code')  String roomCode, @JsonKey(name: 'host_id')  String hostId, @JsonKey(name: 'max_players')  int maxPlayers,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'duel_participants')  List<DuelParticipant> participants)  $default,) {final _that = this;
switch (_that) {
case _Duel():
return $default(_that.id,_that.roomCode,_that.hostId,_that.maxPlayers,_that.status,_that.createdAt,_that.participants);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'room_code')  String roomCode, @JsonKey(name: 'host_id')  String hostId, @JsonKey(name: 'max_players')  int maxPlayers,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'duel_participants')  List<DuelParticipant> participants)?  $default,) {final _that = this;
switch (_that) {
case _Duel() when $default != null:
return $default(_that.id,_that.roomCode,_that.hostId,_that.maxPlayers,_that.status,_that.createdAt,_that.participants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Duel implements Duel {
  const _Duel({required this.id, @JsonKey(name: 'room_code') required this.roomCode, @JsonKey(name: 'host_id') required this.hostId, @JsonKey(name: 'max_players') this.maxPlayers = 10, this.status = 'waiting', @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'duel_participants') final  List<DuelParticipant> participants = const []}): _participants = participants;
  factory _Duel.fromJson(Map<String, dynamic> json) => _$DuelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'room_code') final  String roomCode;
@override@JsonKey(name: 'host_id') final  String hostId;
@override@JsonKey(name: 'max_players') final  int maxPlayers;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
// Relational join data
 final  List<DuelParticipant> _participants;
// Relational join data
@override@JsonKey(name: 'duel_participants') List<DuelParticipant> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}


/// Create a copy of Duel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DuelCopyWith<_Duel> get copyWith => __$DuelCopyWithImpl<_Duel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DuelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Duel&&(identical(other.id, id) || other.id == id)&&(identical(other.roomCode, roomCode) || other.roomCode == roomCode)&&(identical(other.hostId, hostId) || other.hostId == hostId)&&(identical(other.maxPlayers, maxPlayers) || other.maxPlayers == maxPlayers)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._participants, _participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,roomCode,hostId,maxPlayers,status,createdAt,const DeepCollectionEquality().hash(_participants));

@override
String toString() {
  return 'Duel(id: $id, roomCode: $roomCode, hostId: $hostId, maxPlayers: $maxPlayers, status: $status, createdAt: $createdAt, participants: $participants)';
}


}

/// @nodoc
abstract mixin class _$DuelCopyWith<$Res> implements $DuelCopyWith<$Res> {
  factory _$DuelCopyWith(_Duel value, $Res Function(_Duel) _then) = __$DuelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'room_code') String roomCode,@JsonKey(name: 'host_id') String hostId,@JsonKey(name: 'max_players') int maxPlayers, String status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'duel_participants') List<DuelParticipant> participants
});




}
/// @nodoc
class __$DuelCopyWithImpl<$Res>
    implements _$DuelCopyWith<$Res> {
  __$DuelCopyWithImpl(this._self, this._then);

  final _Duel _self;
  final $Res Function(_Duel) _then;

/// Create a copy of Duel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomCode = null,Object? hostId = null,Object? maxPlayers = null,Object? status = null,Object? createdAt = null,Object? participants = null,}) {
  return _then(_Duel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomCode: null == roomCode ? _self.roomCode : roomCode // ignore: cast_nullable_to_non_nullable
as String,hostId: null == hostId ? _self.hostId : hostId // ignore: cast_nullable_to_non_nullable
as String,maxPlayers: null == maxPlayers ? _self.maxPlayers : maxPlayers // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<DuelParticipant>,
  ));
}


}

// dart format on
