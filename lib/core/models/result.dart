import 'package:flutter/foundation.dart';

typedef SuccessCallback<W, S> = W Function(S success);
typedef FailureCallback<W, E> = W Function(E e);

/// Base Result.
///
/// Receives two values [E] and [S] as [E] is an error and [S] is a success.
sealed class Result<S, E> {
  const Result();

  /// Returns true if the current result is an [Failure].
  bool isFailure();

  /// Returns true if the current result is a [Success].
  bool isSuccess();

  /// Returns the value of [S] if any.
  S? tryGetSuccess();

  /// Returns the value of [E] if any.
  E? tryGetFailure();

  /// Handle the result when success or error.
  ///
  /// if the result is an error, it will be returned in [onFailure].
  /// if it is a success it will be returned in [onSuccess].
  W on<W>({
    required SuccessCallback<W, S> success,
    required FailureCallback<W, E> failure,
  });

  /// Execute [onSuccess] if the [Result] is a success.
  R? onSuccess<R>(R Function(S success) onSuccess);

  /// Execute [onFailure] if the [Result] is an error.
  R? onFailure<R>(R Function(E e) onFailure);
}

/// Success Result.
///
/// return it when the result of a [Result] is the expected value.
@optionalTypeArgs
final class Success<S, E> extends Result<S, E> {
  final S success;

  const Success(this.success);

  /// Build a `Success` with `Nothing` value.
  static Success<Nothing, E> nothing<E>() => Success<Nothing, E>(const Nothing._());

  @override
  bool isFailure() => false;

  @override
  bool isSuccess() => true;

  @override
  S tryGetSuccess() => success;

  @override
  E? tryGetFailure() => null;

  @override
  W on<W>({required SuccessCallback<W, S> success, FailureCallback<W, E>? failure}) => onSuccess(success);

  @override
  R onSuccess<R>(R Function(S success) onSuccess) => onSuccess(success);

  @override
  R? onFailure<R>(R Function(E e) onFailure) => null;

  @override
  int get hashCode => success.hashCode;

  @override
  bool operator ==(Object other) => other is Success && other.success == success;
}

/// Error Result.
///
/// return it when the result of a [Result] is not the expected value.
@optionalTypeArgs
final class Failure<S, E> extends Result<S, E> {
  final E error;

  const Failure(this.error);

  /// Build a `Error` with `Nothing` value.
  static Failure<S, Nothing> nothing<S>() => Failure<S, Nothing>(const Nothing._());

  @override
  bool isFailure() => true;

  @override
  bool isSuccess() => false;

  @override
  S? tryGetSuccess() => null;

  @override
  E tryGetFailure() => error;

  @override
  W on<W>({SuccessCallback<W, S>? success, required FailureCallback<W, E> failure}) => onFailure(failure);

  @override
  R? onSuccess<R>(R Function(S success) onSuccess) => null;

  @override
  R onFailure<R>(R Function(E e) onFailure) => onFailure(error);

  @override
  int get hashCode => error.hashCode;

  @override
  bool operator ==(Object other) => other is Failure && other.error == error;
}

/// Used instead of `void` as a return statement for a function when no value is to be returned.
///
/// There is only one value of type [Nothing].
final class Nothing {
  const Nothing._();
}
