// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WordProgress {

 String get wordId; double get easinessFactor; int get interval; int get repetitions; DateTime get nextReviewDate; DateTime? get lastReviewDate;
/// Create a copy of WordProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordProgressCopyWith<WordProgress> get copyWith => _$WordProgressCopyWithImpl<WordProgress>(this as WordProgress, _$identity);

  /// Serializes this WordProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordProgress&&(identical(other.wordId, wordId) || other.wordId == wordId)&&(identical(other.easinessFactor, easinessFactor) || other.easinessFactor == easinessFactor)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.repetitions, repetitions) || other.repetitions == repetitions)&&(identical(other.nextReviewDate, nextReviewDate) || other.nextReviewDate == nextReviewDate)&&(identical(other.lastReviewDate, lastReviewDate) || other.lastReviewDate == lastReviewDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wordId,easinessFactor,interval,repetitions,nextReviewDate,lastReviewDate);

@override
String toString() {
  return 'WordProgress(wordId: $wordId, easinessFactor: $easinessFactor, interval: $interval, repetitions: $repetitions, nextReviewDate: $nextReviewDate, lastReviewDate: $lastReviewDate)';
}


}

/// @nodoc
abstract mixin class $WordProgressCopyWith<$Res>  {
  factory $WordProgressCopyWith(WordProgress value, $Res Function(WordProgress) _then) = _$WordProgressCopyWithImpl;
@useResult
$Res call({
 String wordId, double easinessFactor, int interval, int repetitions, DateTime nextReviewDate, DateTime? lastReviewDate
});




}
/// @nodoc
class _$WordProgressCopyWithImpl<$Res>
    implements $WordProgressCopyWith<$Res> {
  _$WordProgressCopyWithImpl(this._self, this._then);

  final WordProgress _self;
  final $Res Function(WordProgress) _then;

/// Create a copy of WordProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wordId = null,Object? easinessFactor = null,Object? interval = null,Object? repetitions = null,Object? nextReviewDate = null,Object? lastReviewDate = freezed,}) {
  return _then(_self.copyWith(
wordId: null == wordId ? _self.wordId : wordId // ignore: cast_nullable_to_non_nullable
as String,easinessFactor: null == easinessFactor ? _self.easinessFactor : easinessFactor // ignore: cast_nullable_to_non_nullable
as double,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,repetitions: null == repetitions ? _self.repetitions : repetitions // ignore: cast_nullable_to_non_nullable
as int,nextReviewDate: null == nextReviewDate ? _self.nextReviewDate : nextReviewDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastReviewDate: freezed == lastReviewDate ? _self.lastReviewDate : lastReviewDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WordProgress].
extension WordProgressPatterns on WordProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordProgress value)  $default,){
final _that = this;
switch (_that) {
case _WordProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordProgress value)?  $default,){
final _that = this;
switch (_that) {
case _WordProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String wordId,  double easinessFactor,  int interval,  int repetitions,  DateTime nextReviewDate,  DateTime? lastReviewDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordProgress() when $default != null:
return $default(_that.wordId,_that.easinessFactor,_that.interval,_that.repetitions,_that.nextReviewDate,_that.lastReviewDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String wordId,  double easinessFactor,  int interval,  int repetitions,  DateTime nextReviewDate,  DateTime? lastReviewDate)  $default,) {final _that = this;
switch (_that) {
case _WordProgress():
return $default(_that.wordId,_that.easinessFactor,_that.interval,_that.repetitions,_that.nextReviewDate,_that.lastReviewDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String wordId,  double easinessFactor,  int interval,  int repetitions,  DateTime nextReviewDate,  DateTime? lastReviewDate)?  $default,) {final _that = this;
switch (_that) {
case _WordProgress() when $default != null:
return $default(_that.wordId,_that.easinessFactor,_that.interval,_that.repetitions,_that.nextReviewDate,_that.lastReviewDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordProgress implements WordProgress {
  const _WordProgress({required this.wordId, this.easinessFactor = 2.5, this.interval = 0, this.repetitions = 0, required this.nextReviewDate, this.lastReviewDate});
  factory _WordProgress.fromJson(Map<String, dynamic> json) => _$WordProgressFromJson(json);

@override final  String wordId;
@override@JsonKey() final  double easinessFactor;
@override@JsonKey() final  int interval;
@override@JsonKey() final  int repetitions;
@override final  DateTime nextReviewDate;
@override final  DateTime? lastReviewDate;

/// Create a copy of WordProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordProgressCopyWith<_WordProgress> get copyWith => __$WordProgressCopyWithImpl<_WordProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordProgress&&(identical(other.wordId, wordId) || other.wordId == wordId)&&(identical(other.easinessFactor, easinessFactor) || other.easinessFactor == easinessFactor)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.repetitions, repetitions) || other.repetitions == repetitions)&&(identical(other.nextReviewDate, nextReviewDate) || other.nextReviewDate == nextReviewDate)&&(identical(other.lastReviewDate, lastReviewDate) || other.lastReviewDate == lastReviewDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wordId,easinessFactor,interval,repetitions,nextReviewDate,lastReviewDate);

@override
String toString() {
  return 'WordProgress(wordId: $wordId, easinessFactor: $easinessFactor, interval: $interval, repetitions: $repetitions, nextReviewDate: $nextReviewDate, lastReviewDate: $lastReviewDate)';
}


}

/// @nodoc
abstract mixin class _$WordProgressCopyWith<$Res> implements $WordProgressCopyWith<$Res> {
  factory _$WordProgressCopyWith(_WordProgress value, $Res Function(_WordProgress) _then) = __$WordProgressCopyWithImpl;
@override @useResult
$Res call({
 String wordId, double easinessFactor, int interval, int repetitions, DateTime nextReviewDate, DateTime? lastReviewDate
});




}
/// @nodoc
class __$WordProgressCopyWithImpl<$Res>
    implements _$WordProgressCopyWith<$Res> {
  __$WordProgressCopyWithImpl(this._self, this._then);

  final _WordProgress _self;
  final $Res Function(_WordProgress) _then;

/// Create a copy of WordProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wordId = null,Object? easinessFactor = null,Object? interval = null,Object? repetitions = null,Object? nextReviewDate = null,Object? lastReviewDate = freezed,}) {
  return _then(_WordProgress(
wordId: null == wordId ? _self.wordId : wordId // ignore: cast_nullable_to_non_nullable
as String,easinessFactor: null == easinessFactor ? _self.easinessFactor : easinessFactor // ignore: cast_nullable_to_non_nullable
as double,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,repetitions: null == repetitions ? _self.repetitions : repetitions // ignore: cast_nullable_to_non_nullable
as int,nextReviewDate: null == nextReviewDate ? _self.nextReviewDate : nextReviewDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastReviewDate: freezed == lastReviewDate ? _self.lastReviewDate : lastReviewDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
