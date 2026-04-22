// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flashcard_session_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FlashcardSessionState {

 List<GreWord> get queue; FlashcardSessionMode get mode; int get initialQueueLength;
/// Create a copy of FlashcardSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashcardSessionStateCopyWith<FlashcardSessionState> get copyWith => _$FlashcardSessionStateCopyWithImpl<FlashcardSessionState>(this as FlashcardSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashcardSessionState&&const DeepCollectionEquality().equals(other.queue, queue)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.initialQueueLength, initialQueueLength) || other.initialQueueLength == initialQueueLength));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(queue),mode,initialQueueLength);

@override
String toString() {
  return 'FlashcardSessionState(queue: $queue, mode: $mode, initialQueueLength: $initialQueueLength)';
}


}

/// @nodoc
abstract mixin class $FlashcardSessionStateCopyWith<$Res>  {
  factory $FlashcardSessionStateCopyWith(FlashcardSessionState value, $Res Function(FlashcardSessionState) _then) = _$FlashcardSessionStateCopyWithImpl;
@useResult
$Res call({
 List<GreWord> queue, FlashcardSessionMode mode, int initialQueueLength
});




}
/// @nodoc
class _$FlashcardSessionStateCopyWithImpl<$Res>
    implements $FlashcardSessionStateCopyWith<$Res> {
  _$FlashcardSessionStateCopyWithImpl(this._self, this._then);

  final FlashcardSessionState _self;
  final $Res Function(FlashcardSessionState) _then;

/// Create a copy of FlashcardSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? queue = null,Object? mode = null,Object? initialQueueLength = null,}) {
  return _then(_self.copyWith(
queue: null == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as List<GreWord>,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as FlashcardSessionMode,initialQueueLength: null == initialQueueLength ? _self.initialQueueLength : initialQueueLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FlashcardSessionState].
extension FlashcardSessionStatePatterns on FlashcardSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashcardSessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashcardSessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashcardSessionState value)  $default,){
final _that = this;
switch (_that) {
case _FlashcardSessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashcardSessionState value)?  $default,){
final _that = this;
switch (_that) {
case _FlashcardSessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GreWord> queue,  FlashcardSessionMode mode,  int initialQueueLength)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashcardSessionState() when $default != null:
return $default(_that.queue,_that.mode,_that.initialQueueLength);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GreWord> queue,  FlashcardSessionMode mode,  int initialQueueLength)  $default,) {final _that = this;
switch (_that) {
case _FlashcardSessionState():
return $default(_that.queue,_that.mode,_that.initialQueueLength);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GreWord> queue,  FlashcardSessionMode mode,  int initialQueueLength)?  $default,) {final _that = this;
switch (_that) {
case _FlashcardSessionState() when $default != null:
return $default(_that.queue,_that.mode,_that.initialQueueLength);case _:
  return null;

}
}

}

/// @nodoc


class _FlashcardSessionState implements FlashcardSessionState {
  const _FlashcardSessionState({required final  List<GreWord> queue, required this.mode, required this.initialQueueLength}): _queue = queue;
  

 final  List<GreWord> _queue;
@override List<GreWord> get queue {
  if (_queue is EqualUnmodifiableListView) return _queue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_queue);
}

@override final  FlashcardSessionMode mode;
@override final  int initialQueueLength;

/// Create a copy of FlashcardSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashcardSessionStateCopyWith<_FlashcardSessionState> get copyWith => __$FlashcardSessionStateCopyWithImpl<_FlashcardSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashcardSessionState&&const DeepCollectionEquality().equals(other._queue, _queue)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.initialQueueLength, initialQueueLength) || other.initialQueueLength == initialQueueLength));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_queue),mode,initialQueueLength);

@override
String toString() {
  return 'FlashcardSessionState(queue: $queue, mode: $mode, initialQueueLength: $initialQueueLength)';
}


}

/// @nodoc
abstract mixin class _$FlashcardSessionStateCopyWith<$Res> implements $FlashcardSessionStateCopyWith<$Res> {
  factory _$FlashcardSessionStateCopyWith(_FlashcardSessionState value, $Res Function(_FlashcardSessionState) _then) = __$FlashcardSessionStateCopyWithImpl;
@override @useResult
$Res call({
 List<GreWord> queue, FlashcardSessionMode mode, int initialQueueLength
});




}
/// @nodoc
class __$FlashcardSessionStateCopyWithImpl<$Res>
    implements _$FlashcardSessionStateCopyWith<$Res> {
  __$FlashcardSessionStateCopyWithImpl(this._self, this._then);

  final _FlashcardSessionState _self;
  final $Res Function(_FlashcardSessionState) _then;

/// Create a copy of FlashcardSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? queue = null,Object? mode = null,Object? initialQueueLength = null,}) {
  return _then(_FlashcardSessionState(
queue: null == queue ? _self._queue : queue // ignore: cast_nullable_to_non_nullable
as List<GreWord>,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as FlashcardSessionMode,initialQueueLength: null == initialQueueLength ? _self.initialQueueLength : initialQueueLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
