import 'package:dartz/dartz.dart';
import 'package:test_app/data/network/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Faliure, Out>> execute(In input);
}
