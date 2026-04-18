// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'podcast_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PodcastState {

 PodcastSourceMode get sourceMode; List<GreWord> get queue; int get currentIndex; bool get isPlaying; bool get isLoading; String get error;// The currently active visible text (synced with TTS)
 String get currentlySpeakingText; String get currentlySpeakingTitle;
/// Create a copy of PodcastState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PodcastStateCopyWith<PodcastState> get copyWith => _$PodcastStateCopyWithImpl<PodcastState>(this as PodcastState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PodcastState&&(identical(other.sourceMode, sourceMode) || other.sourceMode == sourceMode)&&const DeepCollectionEquality().equals(other.queue, queue)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.currentlySpeakingText, currentlySpeakingText) || other.currentlySpeakingText == currentlySpeakingText)&&(identical(other.currentlySpeakingTitle, currentlySpeakingTitle) || other.currentlySpeakingTitle == currentlySpeakingTitle));
}


@override
int get hashCode => Object.hash(runtimeType,sourceMode,const DeepCollectionEquality().hash(queue),currentIndex,isPlaying,isLoading,error,currentlySpeakingText,currentlySpeakingTitle);

@override
String toString() {
  return 'PodcastState(sourceMode: $sourceMode, queue: $queue, currentIndex: $currentIndex, isPlaying: $isPlaying, isLoading: $isLoading, error: $error, currentlySpeakingText: $currentlySpeakingText, currentlySpeakingTitle: $currentlySpeakingTitle)';
}


}

/// @nodoc
abstract mixin class $PodcastStateCopyWith<$Res>  {
  factory $PodcastStateCopyWith(PodcastState value, $Res Function(PodcastState) _then) = _$PodcastStateCopyWithImpl;
@useResult
$Res call({
 PodcastSourceMode sourceMode, List<GreWord> queue, int currentIndex, bool isPlaying, bool isLoading, String error, String currentlySpeakingText, String currentlySpeakingTitle
});




}
/// @nodoc
class _$PodcastStateCopyWithImpl<$Res>
    implements $PodcastStateCopyWith<$Res> {
  _$PodcastStateCopyWithImpl(this._self, this._then);

  final PodcastState _self;
  final $Res Function(PodcastState) _then;

/// Create a copy of PodcastState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceMode = null,Object? queue = null,Object? currentIndex = null,Object? isPlaying = null,Object? isLoading = null,Object? error = null,Object? currentlySpeakingText = null,Object? currentlySpeakingTitle = null,}) {
  return _then(_self.copyWith(
sourceMode: null == sourceMode ? _self.sourceMode : sourceMode // ignore: cast_nullable_to_non_nullable
as PodcastSourceMode,queue: null == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as List<GreWord>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,currentlySpeakingText: null == currentlySpeakingText ? _self.currentlySpeakingText : currentlySpeakingText // ignore: cast_nullable_to_non_nullable
as String,currentlySpeakingTitle: null == currentlySpeakingTitle ? _self.currentlySpeakingTitle : currentlySpeakingTitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PodcastState].
extension PodcastStatePatterns on PodcastState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PodcastState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PodcastState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PodcastState value)  $default,){
final _that = this;
switch (_that) {
case _PodcastState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PodcastState value)?  $default,){
final _that = this;
switch (_that) {
case _PodcastState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PodcastSourceMode sourceMode,  List<GreWord> queue,  int currentIndex,  bool isPlaying,  bool isLoading,  String error,  String currentlySpeakingText,  String currentlySpeakingTitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PodcastState() when $default != null:
return $default(_that.sourceMode,_that.queue,_that.currentIndex,_that.isPlaying,_that.isLoading,_that.error,_that.currentlySpeakingText,_that.currentlySpeakingTitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PodcastSourceMode sourceMode,  List<GreWord> queue,  int currentIndex,  bool isPlaying,  bool isLoading,  String error,  String currentlySpeakingText,  String currentlySpeakingTitle)  $default,) {final _that = this;
switch (_that) {
case _PodcastState():
return $default(_that.sourceMode,_that.queue,_that.currentIndex,_that.isPlaying,_that.isLoading,_that.error,_that.currentlySpeakingText,_that.currentlySpeakingTitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PodcastSourceMode sourceMode,  List<GreWord> queue,  int currentIndex,  bool isPlaying,  bool isLoading,  String error,  String currentlySpeakingText,  String currentlySpeakingTitle)?  $default,) {final _that = this;
switch (_that) {
case _PodcastState() when $default != null:
return $default(_that.sourceMode,_that.queue,_that.currentIndex,_that.isPlaying,_that.isLoading,_that.error,_that.currentlySpeakingText,_that.currentlySpeakingTitle);case _:
  return null;

}
}

}

/// @nodoc


class _PodcastState implements PodcastState {
  const _PodcastState({this.sourceMode = PodcastSourceMode.reviewSession, final  List<GreWord> queue = const [], this.currentIndex = 0, this.isPlaying = false, this.isLoading = false, this.error = '', this.currentlySpeakingText = '', this.currentlySpeakingTitle = ''}): _queue = queue;
  

@override@JsonKey() final  PodcastSourceMode sourceMode;
 final  List<GreWord> _queue;
@override@JsonKey() List<GreWord> get queue {
  if (_queue is EqualUnmodifiableListView) return _queue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_queue);
}

@override@JsonKey() final  int currentIndex;
@override@JsonKey() final  bool isPlaying;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  String error;
// The currently active visible text (synced with TTS)
@override@JsonKey() final  String currentlySpeakingText;
@override@JsonKey() final  String currentlySpeakingTitle;

/// Create a copy of PodcastState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PodcastStateCopyWith<_PodcastState> get copyWith => __$PodcastStateCopyWithImpl<_PodcastState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PodcastState&&(identical(other.sourceMode, sourceMode) || other.sourceMode == sourceMode)&&const DeepCollectionEquality().equals(other._queue, _queue)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.currentlySpeakingText, currentlySpeakingText) || other.currentlySpeakingText == currentlySpeakingText)&&(identical(other.currentlySpeakingTitle, currentlySpeakingTitle) || other.currentlySpeakingTitle == currentlySpeakingTitle));
}


@override
int get hashCode => Object.hash(runtimeType,sourceMode,const DeepCollectionEquality().hash(_queue),currentIndex,isPlaying,isLoading,error,currentlySpeakingText,currentlySpeakingTitle);

@override
String toString() {
  return 'PodcastState(sourceMode: $sourceMode, queue: $queue, currentIndex: $currentIndex, isPlaying: $isPlaying, isLoading: $isLoading, error: $error, currentlySpeakingText: $currentlySpeakingText, currentlySpeakingTitle: $currentlySpeakingTitle)';
}


}

/// @nodoc
abstract mixin class _$PodcastStateCopyWith<$Res> implements $PodcastStateCopyWith<$Res> {
  factory _$PodcastStateCopyWith(_PodcastState value, $Res Function(_PodcastState) _then) = __$PodcastStateCopyWithImpl;
@override @useResult
$Res call({
 PodcastSourceMode sourceMode, List<GreWord> queue, int currentIndex, bool isPlaying, bool isLoading, String error, String currentlySpeakingText, String currentlySpeakingTitle
});




}
/// @nodoc
class __$PodcastStateCopyWithImpl<$Res>
    implements _$PodcastStateCopyWith<$Res> {
  __$PodcastStateCopyWithImpl(this._self, this._then);

  final _PodcastState _self;
  final $Res Function(_PodcastState) _then;

/// Create a copy of PodcastState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceMode = null,Object? queue = null,Object? currentIndex = null,Object? isPlaying = null,Object? isLoading = null,Object? error = null,Object? currentlySpeakingText = null,Object? currentlySpeakingTitle = null,}) {
  return _then(_PodcastState(
sourceMode: null == sourceMode ? _self.sourceMode : sourceMode // ignore: cast_nullable_to_non_nullable
as PodcastSourceMode,queue: null == queue ? _self._queue : queue // ignore: cast_nullable_to_non_nullable
as List<GreWord>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,currentlySpeakingText: null == currentlySpeakingText ? _self.currentlySpeakingText : currentlySpeakingText // ignore: cast_nullable_to_non_nullable
as String,currentlySpeakingTitle: null == currentlySpeakingTitle ? _self.currentlySpeakingTitle : currentlySpeakingTitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
