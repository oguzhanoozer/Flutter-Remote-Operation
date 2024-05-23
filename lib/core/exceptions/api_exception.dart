import 'base_exception.dart';

abstract base class ApiException extends BaseException {
  const ApiException({
    super.message,
  }) : super();

  factory ApiException.from(dynamic e) {
    return ExceptionHandle(message: e);
  }
}

final class ExceptionHandle extends ApiException {
  ExceptionHandle({super.message}) : super();
}
