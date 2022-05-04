import 'package:dartz/dartz.dart';
import 'package:test_app/data/network/failure.dart';
import 'package:test_app/data/request/request.dart';
import 'package:test_app/domain/model/model.dart';

abstract class Repository{
  Future<Either<Faliure,Authentication>> login(LoginRequest loginRequest);
}