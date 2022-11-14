// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'grow_ui_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GrowUiEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() levelUp,
    required TResult Function() stageUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? levelUp,
    TResult? Function()? stageUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? levelUp,
    TResult Function()? stageUp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LevelUp value) levelUp,
    required TResult Function(StageUp value) stageUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LevelUp value)? levelUp,
    TResult? Function(StageUp value)? stageUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LevelUp value)? levelUp,
    TResult Function(StageUp value)? stageUp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GrowUiEventCopyWith<$Res> {
  factory $GrowUiEventCopyWith(
          GrowUiEvent value, $Res Function(GrowUiEvent) then) =
      _$GrowUiEventCopyWithImpl<$Res, GrowUiEvent>;
}

/// @nodoc
class _$GrowUiEventCopyWithImpl<$Res, $Val extends GrowUiEvent>
    implements $GrowUiEventCopyWith<$Res> {
  _$GrowUiEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LevelUpCopyWith<$Res> {
  factory _$$LevelUpCopyWith(_$LevelUp value, $Res Function(_$LevelUp) then) =
      __$$LevelUpCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LevelUpCopyWithImpl<$Res>
    extends _$GrowUiEventCopyWithImpl<$Res, _$LevelUp>
    implements _$$LevelUpCopyWith<$Res> {
  __$$LevelUpCopyWithImpl(_$LevelUp _value, $Res Function(_$LevelUp) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LevelUp implements LevelUp {
  const _$LevelUp();

  @override
  String toString() {
    return 'GrowUiEvent.levelUp()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LevelUp);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() levelUp,
    required TResult Function() stageUp,
  }) {
    return levelUp();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? levelUp,
    TResult? Function()? stageUp,
  }) {
    return levelUp?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? levelUp,
    TResult Function()? stageUp,
    required TResult orElse(),
  }) {
    if (levelUp != null) {
      return levelUp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LevelUp value) levelUp,
    required TResult Function(StageUp value) stageUp,
  }) {
    return levelUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LevelUp value)? levelUp,
    TResult? Function(StageUp value)? stageUp,
  }) {
    return levelUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LevelUp value)? levelUp,
    TResult Function(StageUp value)? stageUp,
    required TResult orElse(),
  }) {
    if (levelUp != null) {
      return levelUp(this);
    }
    return orElse();
  }
}

abstract class LevelUp implements GrowUiEvent {
  const factory LevelUp() = _$LevelUp;
}

/// @nodoc
abstract class _$$StageUpCopyWith<$Res> {
  factory _$$StageUpCopyWith(_$StageUp value, $Res Function(_$StageUp) then) =
      __$$StageUpCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StageUpCopyWithImpl<$Res>
    extends _$GrowUiEventCopyWithImpl<$Res, _$StageUp>
    implements _$$StageUpCopyWith<$Res> {
  __$$StageUpCopyWithImpl(_$StageUp _value, $Res Function(_$StageUp) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StageUp implements StageUp {
  const _$StageUp();

  @override
  String toString() {
    return 'GrowUiEvent.stageUp()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StageUp);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() levelUp,
    required TResult Function() stageUp,
  }) {
    return stageUp();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? levelUp,
    TResult? Function()? stageUp,
  }) {
    return stageUp?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? levelUp,
    TResult Function()? stageUp,
    required TResult orElse(),
  }) {
    if (stageUp != null) {
      return stageUp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LevelUp value) levelUp,
    required TResult Function(StageUp value) stageUp,
  }) {
    return stageUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LevelUp value)? levelUp,
    TResult? Function(StageUp value)? stageUp,
  }) {
    return stageUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LevelUp value)? levelUp,
    TResult Function(StageUp value)? stageUp,
    required TResult orElse(),
  }) {
    if (stageUp != null) {
      return stageUp(this);
    }
    return orElse();
  }
}

abstract class StageUp implements GrowUiEvent {
  const factory StageUp() = _$StageUp;
}
