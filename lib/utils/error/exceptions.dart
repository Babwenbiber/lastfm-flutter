import 'package:equatable/equatable.dart';
import 'package:lastfm/utils/language/strings.dart';

class ServerTimeoutException extends Equatable implements Exception {
  final String msg = SERVER_TIMEOUT_EXCEPTION_MSG;
  @override
  List<Object?> get props => [msg];
}

class ServerUnknownStatusException extends Equatable implements Exception {
  final String msg = SERVER_UNKNOWN_STATUS_EXCEPTION_MSG;
  @override
  List<Object?> get props => [msg];
}

class ServerException extends Equatable implements Exception {
  final int code;

  const ServerException(this.code);
  @override
  List<Object?> get props => [code];
}

class UnknownException extends Equatable implements Exception {
  const UnknownException();

  @override
  List<Object?> get props => [];
}
