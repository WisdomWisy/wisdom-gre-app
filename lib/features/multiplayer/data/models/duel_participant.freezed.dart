// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duel_participant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DuelParticipant {

 String get id;@JsonKey(name: 'duel_id') String get duelId;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'joined_at') DateTime get joinedAt;// Joined profile data (via Supabase relational query)
 Profile? get profiles;
/// Create a copy of DuelParticipant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DuelParticipantCopyWith<DuelParticipant> get copyWith => _$DuelParticipantCopyWithImpl<DuelParticipant>(this as DuelParticipant, _$identity);

  /// Serializes this DuelParticipant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DuelParticipant&&(identical(other.id, id) || other.id == id)&&(identical(other.duelId, duelId) || other.duelId == duelId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.profiles, profiles) || other.profiles == profiles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,duelId,userId,joinedAt,profiles);

@override
String toString() {
  return 'DuelParticipant(id: $id, duelId: $duelId, userId: $userId, joinedAt: $joinedAt, profiles: $profiles)';
}


}

/// @nodoc
abstract mixin class $DuelParticipantCopyWith<$Res>  {
  factory $DuelParticipantCopyWith(DuelParticipant value, $Res Function(DuelParticipant) _then) = _$DuelParticipantCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'duel_id') String duelId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'joined_at') DateTime joinedAt, Profile? profiles
});


$ProfileCopyWith<$Res>? get profiles;

}
/// @nodoc
class _$DuelParticipantCopyWithImpl<$Res>
    implements $DuelParticipantCopyWith<$Res> {
  _$DuelParticipantCopyWithImpl(this._self, this._then);

  final DuelParticipant _self;
  final $Res Function(DuelParticipant) _then;

/// Create a copy of DuelParticipant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? duelId = null,Object? userId = null,Object? joinedAt = null,Object? profiles = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,duelId: null == duelId ? _self.duelId : duelId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,profiles: freezed == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as Profile?,
  ));
}
/// Create a copy of DuelParticipant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res>? get profiles {
    if (_self.profiles == null) {
    return null;
  }

  return $ProfileCopyWith<$Res>(_self.profiles!, (value) {
    return _then(_self.copyWith(profiles: value));
  });
}
}


/// Adds pattern-matching-related methods to [DuelParticipant].
extension DuelParticipantPatterns on DuelParticipant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DuelParticipant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DuelParticipant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DuelParticipant value)  $default,){
final _that = this;
switch (_that) {
case _DuelParticipant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DuelParticipant value)?  $default,){
final _that = this;
switch (_that) {
case _DuelParticipant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'duel_id')  String duelId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'joined_at')  DateTime joinedAt,  Profile? profiles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DuelParticipant() when $default != null:
return $default(_that.id,_that.duelId,_that.userId,_that.joinedAt,_that.profiles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'duel_id')  String duelId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'joined_at')  DateTime joinedAt,  Profile? profiles)  $default,) {final _that = this;
switch (_that) {
case _DuelParticipant():
return $default(_that.id,_that.duelId,_that.userId,_that.joinedAt,_that.profiles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'duel_id')  String duelId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'joined_at')  DateTime joinedAt,  Profile? profiles)?  $default,) {final _that = this;
switch (_that) {
case _DuelParticipant() when $default != null:
return $default(_that.id,_that.duelId,_that.userId,_that.joinedAt,_that.profiles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DuelParticipant implements DuelParticipant {
  const _DuelParticipant({required this.id, @JsonKey(name: 'duel_id') required this.duelId, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'joined_at') required this.joinedAt, this.profiles});
  factory _DuelParticipant.fromJson(Map<String, dynamic> json) => _$DuelParticipantFromJson(json);

@override final  String id;
@override@JsonKey(name: 'duel_id') final  String duelId;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'joined_at') final  DateTime joinedAt;
// Joined profile data (via Supabase relational query)
@override final  Profile? profiles;

/// Create a copy of DuelParticipant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DuelParticipantCopyWith<_DuelParticipant> get copyWith => __$DuelParticipantCopyWithImpl<_DuelParticipant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DuelParticipantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DuelParticipant&&(identical(other.id, id) || other.id == id)&&(identical(other.duelId, duelId) || other.duelId == duelId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.profiles, profiles) || other.profiles == profiles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,duelId,userId,joinedAt,profiles);

@override
String toString() {
  return 'DuelParticipant(id: $id, duelId: $duelId, userId: $userId, joinedAt: $joinedAt, profiles: $profiles)';
}


}

/// @nodoc
abstract mixin class _$DuelParticipantCopyWith<$Res> implements $DuelParticipantCopyWith<$Res> {
  factory _$DuelParticipantCopyWith(_DuelParticipant value, $Res Function(_DuelParticipant) _then) = __$DuelParticipantCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'duel_id') String duelId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'joined_at') DateTime joinedAt, Profile? profiles
});


@override $ProfileCopyWith<$Res>? get profiles;

}
/// @nodoc
class __$DuelParticipantCopyWithImpl<$Res>
    implements _$DuelParticipantCopyWith<$Res> {
  __$DuelParticipantCopyWithImpl(this._self, this._then);

  final _DuelParticipant _self;
  final $Res Function(_DuelParticipant) _then;

/// Create a copy of DuelParticipant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? duelId = null,Object? userId = null,Object? joinedAt = null,Object? profiles = freezed,}) {
  return _then(_DuelParticipant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,duelId: null == duelId ? _self.duelId : duelId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,profiles: freezed == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as Profile?,
  ));
}

/// Create a copy of DuelParticipant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res>? get profiles {
    if (_self.profiles == null) {
    return null;
  }

  return $ProfileCopyWith<$Res>(_self.profiles!, (value) {
    return _then(_self.copyWith(profiles: value));
  });
}
}

// dart format on
