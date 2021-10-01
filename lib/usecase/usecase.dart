import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lastfm/utils/error/failures.dart';
abstract class UseCase <Args, Ret> {
    Future<Either<Failure,Ret>> call(Args args);
}

abstract class UseCaseArgs extends Equatable{

}
