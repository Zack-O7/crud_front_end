class CustomException implements Exception {
  final String? _prefix;
  CustomException([this._prefix]);

  @override
  String toString() {
    return _prefix.toString();
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
   : super(message ?? "No Internet Found");
}

class BadRequestException extends CustomException {
  BadRequestException([String? message])
      : super(message ?? "No Internet Found");
}

class DeleteConflictException extends CustomException {
  DeleteConflictException([String? message])
      : super(message ?? "No Internet Found");
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([String? message])
      : super(message ?? "No Internet Found");
}

class NotFoundException extends CustomException {
  NotFoundException([String? message])
   : super(message ?? "No Internet Found");
}

class ServerException extends CustomException {
  ServerException([String? message])
   : super(message ?? "Server error");
}

class TimeoutException extends CustomException {
  TimeoutException([String? message])
   : super(message ?? "Connection Timeout");
}

class TokenExpireException extends CustomException {
  TokenExpireException([String? message])
      : super(message ?? "No Internet Found");
}
