// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Profile {

 String get id; String get username;@JsonKey(name: 'first_name') String? get firstName;@JsonKey(name: 'last_name') String? get lastName; String? get email;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'arena_wins') int? get arenaWins;@JsonKey(name: 'arena_losses') int? get arenaLosses;@JsonKey(name: 'current_streak') int? get currentStreak;@JsonKey(name: 'daily_duels_count') int get dailyDuelsCount;@JsonKey(name: 'last_duel_date') DateTime? get lastDuelDate;@JsonKey(name: 'difficulty_preference') String get difficultyPreference;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.arenaWins, arenaWins) || other.arenaWins == arenaWins)&&(identical(other.arenaLosses, arenaLosses) || other.arenaLosses == arenaLosses)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.dailyDuelsCount, dailyDuelsCount) || other.dailyDuelsCount == dailyDuelsCount)&&(identical(other.lastDuelDate, lastDuelDate) || other.lastDuelDate == lastDuelDate)&&(identical(other.difficultyPreference, difficultyPreference) || other.difficultyPreference == difficultyPreference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,firstName,lastName,email,avatarUrl,arenaWins,arenaLosses,currentStreak,dailyDuelsCount,lastDuelDate,difficultyPreference);

@override
String toString() {
  return 'Profile(id: $id, username: $username, firstName: $firstName, lastName: $lastName, email: $email, avatarUrl: $avatarUrl, arenaWins: $arenaWins, arenaLosses: $arenaLosses, currentStreak: $currentStreak, dailyDuelsCount: $dailyDuelsCount, lastDuelDate: $lastDuelDate, difficultyPreference: $difficultyPreference)';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 String id, String username,@JsonKey(name: 'first_name') String? firstName,@JsonKey(name: 'last_name') String? lastName, String? email,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'arena_wins') int? arenaWins,@JsonKey(name: 'arena_losses') int? arenaLosses,@JsonKey(name: 'current_streak') int? currentStreak,@JsonKey(name: 'daily_duels_count') int dailyDuelsCount,@JsonKey(name: 'last_duel_date') DateTime? lastDuelDate,@JsonKey(name: 'difficulty_preference') String difficultyPreference
});




}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? firstName = freezed,Object? lastName = freezed,Object? email = freezed,Object? avatarUrl = freezed,Object? arenaWins = freezed,Object? arenaLosses = freezed,Object? currentStreak = freezed,Object? dailyDuelsCount = null,Object? lastDuelDate = freezed,Object? difficultyPreference = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,arenaWins: freezed == arenaWins ? _self.arenaWins : arenaWins // ignore: cast_nullable_to_non_nullable
as int?,arenaLosses: freezed == arenaLosses ? _self.arenaLosses : arenaLosses // ignore: cast_nullable_to_non_nullable
as int?,currentStreak: freezed == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int?,dailyDuelsCount: null == dailyDuelsCount ? _self.dailyDuelsCount : dailyDuelsCount // ignore: cast_nullable_to_non_nullable
as int,lastDuelDate: freezed == lastDuelDate ? _self.lastDuelDate : lastDuelDate // ignore: cast_nullable_to_non_nullable
as DateTime?,difficultyPreference: null == difficultyPreference ? _self.difficultyPreference : difficultyPreference // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Profile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Profile value)  $default,){
final _that = this;
switch (_that) {
case _Profile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Profile value)?  $default,){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName,  String? email, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'arena_wins')  int? arenaWins, @JsonKey(name: 'arena_losses')  int? arenaLosses, @JsonKey(name: 'current_streak')  int? currentStreak, @JsonKey(name: 'daily_duels_count')  int dailyDuelsCount, @JsonKey(name: 'last_duel_date')  DateTime? lastDuelDate, @JsonKey(name: 'difficulty_preference')  String difficultyPreference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.username,_that.firstName,_that.lastName,_that.email,_that.avatarUrl,_that.arenaWins,_that.arenaLosses,_that.currentStreak,_that.dailyDuelsCount,_that.lastDuelDate,_that.difficultyPreference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName,  String? email, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'arena_wins')  int? arenaWins, @JsonKey(name: 'arena_losses')  int? arenaLosses, @JsonKey(name: 'current_streak')  int? currentStreak, @JsonKey(name: 'daily_duels_count')  int dailyDuelsCount, @JsonKey(name: 'last_duel_date')  DateTime? lastDuelDate, @JsonKey(name: 'difficulty_preference')  String difficultyPreference)  $default,) {final _that = this;
switch (_that) {
case _Profile():
return $default(_that.id,_that.username,_that.firstName,_that.lastName,_that.email,_that.avatarUrl,_that.arenaWins,_that.arenaLosses,_that.currentStreak,_that.dailyDuelsCount,_that.lastDuelDate,_that.difficultyPreference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName,  String? email, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'arena_wins')  int? arenaWins, @JsonKey(name: 'arena_losses')  int? arenaLosses, @JsonKey(name: 'current_streak')  int? currentStreak, @JsonKey(name: 'daily_duels_count')  int dailyDuelsCount, @JsonKey(name: 'last_duel_date')  DateTime? lastDuelDate, @JsonKey(name: 'difficulty_preference')  String difficultyPreference)?  $default,) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.username,_that.firstName,_that.lastName,_that.email,_that.avatarUrl,_that.arenaWins,_that.arenaLosses,_that.currentStreak,_that.dailyDuelsCount,_that.lastDuelDate,_that.difficultyPreference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Profile implements Profile {
  const _Profile({required this.id, required this.username, @JsonKey(name: 'first_name') this.firstName, @JsonKey(name: 'last_name') this.lastName, this.email, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'arena_wins') this.arenaWins, @JsonKey(name: 'arena_losses') this.arenaLosses, @JsonKey(name: 'current_streak') this.currentStreak, @JsonKey(name: 'daily_duels_count') this.dailyDuelsCount = 0, @JsonKey(name: 'last_duel_date') this.lastDuelDate, @JsonKey(name: 'difficulty_preference') this.difficultyPreference = 'all'});
  factory _Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

@override final  String id;
@override final  String username;
@override@JsonKey(name: 'first_name') final  String? firstName;
@override@JsonKey(name: 'last_name') final  String? lastName;
@override final  String? email;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'arena_wins') final  int? arenaWins;
@override@JsonKey(name: 'arena_losses') final  int? arenaLosses;
@override@JsonKey(name: 'current_streak') final  int? currentStreak;
@override@JsonKey(name: 'daily_duels_count') final  int dailyDuelsCount;
@override@JsonKey(name: 'last_duel_date') final  DateTime? lastDuelDate;
@override@JsonKey(name: 'difficulty_preference') final  String difficultyPreference;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCopyWith<_Profile> get copyWith => __$ProfileCopyWithImpl<_Profile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.arenaWins, arenaWins) || other.arenaWins == arenaWins)&&(identical(other.arenaLosses, arenaLosses) || other.arenaLosses == arenaLosses)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.dailyDuelsCount, dailyDuelsCount) || other.dailyDuelsCount == dailyDuelsCount)&&(identical(other.lastDuelDate, lastDuelDate) || other.lastDuelDate == lastDuelDate)&&(identical(other.difficultyPreference, difficultyPreference) || other.difficultyPreference == difficultyPreference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,firstName,lastName,email,avatarUrl,arenaWins,arenaLosses,currentStreak,dailyDuelsCount,lastDuelDate,difficultyPreference);

@override
String toString() {
  return 'Profile(id: $id, username: $username, firstName: $firstName, lastName: $lastName, email: $email, avatarUrl: $avatarUrl, arenaWins: $arenaWins, arenaLosses: $arenaLosses, currentStreak: $currentStreak, dailyDuelsCount: $dailyDuelsCount, lastDuelDate: $lastDuelDate, difficultyPreference: $difficultyPreference)';
}


}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) = __$ProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String username,@JsonKey(name: 'first_name') String? firstName,@JsonKey(name: 'last_name') String? lastName, String? email,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'arena_wins') int? arenaWins,@JsonKey(name: 'arena_losses') int? arenaLosses,@JsonKey(name: 'current_streak') int? currentStreak,@JsonKey(name: 'daily_duels_count') int dailyDuelsCount,@JsonKey(name: 'last_duel_date') DateTime? lastDuelDate,@JsonKey(name: 'difficulty_preference') String difficultyPreference
});




}
/// @nodoc
class __$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? firstName = freezed,Object? lastName = freezed,Object? email = freezed,Object? avatarUrl = freezed,Object? arenaWins = freezed,Object? arenaLosses = freezed,Object? currentStreak = freezed,Object? dailyDuelsCount = null,Object? lastDuelDate = freezed,Object? difficultyPreference = null,}) {
  return _then(_Profile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,arenaWins: freezed == arenaWins ? _self.arenaWins : arenaWins // ignore: cast_nullable_to_non_nullable
as int?,arenaLosses: freezed == arenaLosses ? _self.arenaLosses : arenaLosses // ignore: cast_nullable_to_non_nullable
as int?,currentStreak: freezed == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int?,dailyDuelsCount: null == dailyDuelsCount ? _self.dailyDuelsCount : dailyDuelsCount // ignore: cast_nullable_to_non_nullable
as int,lastDuelDate: freezed == lastDuelDate ? _self.lastDuelDate : lastDuelDate // ignore: cast_nullable_to_non_nullable
as DateTime?,difficultyPreference: null == difficultyPreference ? _self.difficultyPreference : difficultyPreference // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
