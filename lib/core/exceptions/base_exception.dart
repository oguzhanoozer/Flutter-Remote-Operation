import '../configs/constants/app_strings.dart';

abstract base class BaseException implements Exception {
  final dynamic _message;
  const BaseException({
    dynamic message,
  }) : _message = message;

  factory BaseException.from(dynamic e) {
    return switch (e) {
      final BaseException e => e,
      _ => const UnknownException(),
    };
  }

  String get message => _message.toString() ?? 'Error';

  @override
  String toString() {
    return <String, dynamic>{
      'e': '$_message',
    }.toString();
  }
}

final class UnknownException extends BaseException {
  const UnknownException({super.message}) : super();
}
