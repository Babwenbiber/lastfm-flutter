import 'package:equatable/equatable.dart';
import 'package:lastfm/utils/error/exceptions.dart';

abstract class Failure extends Equatable {
  final String msg;

  const Failure(this.msg);

  @override
  List<Object?> get props => [msg];
}

class ServerTimeoutFailure extends Failure {
  ServerTimeoutFailure(String msg) : super(msg);
}

class ServerUnknownStatusFailure extends Failure {
  ServerUnknownStatusFailure(String msg) : super(msg);
}

class ServerFailure extends Failure {
  ServerFailure(String msg) : super(msg);
}

class UnknownFailure extends Failure {
  UnknownFailure(String msg) : super(msg);
}

Failure getFailureFromException(Exception e) {
  if (e is ServerTimeoutException) {
    return ServerTimeoutFailure(e.msg);
  } else if (e is ServerUnknownStatusException) {
    return ServerUnknownStatusFailure(e.msg);
  } else if (e is ServerException) {
    String errorMsg = "unknown error-code";
    switch (e.code) {
      case 2:
        errorMsg = "Invalid service - This service does not exist";
        break;
      case 3:
        errorMsg = "Invalid Method - No method with that name in this package";
        break;
      case 4:
        errorMsg =
            "Authentication Failed - You do not have permissions to access the service";
        break;
      case 5:
        errorMsg = "Invalid format - This service doesn't exist in that format";
        break;
      case 6:
        errorMsg =
            "Invalid parameters - Your request is missing a required parameter";
        break;
      case 7:
        errorMsg = "Invalid resource specified";
        break;
      case 8:
        errorMsg = "Operation failed - Something else went wrong";
        break;
      case 9:
        errorMsg = "Invalid session key - Please re-authenticate";
        break;
      //...
    }
    return ServerFailure(errorMsg);
  } else {
    return UnknownFailure("An unknown error occured");
  }
}
