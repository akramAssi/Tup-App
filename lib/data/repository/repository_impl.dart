import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:test_app/data/data_source/remote_data_source.dart';
import 'package:test_app/data/mapper/mapper.dart';
import 'package:test_app/data/network/error_handler.dart';
import 'package:test_app/data/network/failure.dart';
import 'package:test_app/data/network/network_info.dart';
import 'package:test_app/data/request/request.dart';
import 'package:test_app/domain/model.dart';
import 'package:test_app/domain/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Faliure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnection) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(Faliure(ApiInternalStatus.faliuer,
              response.message ?? ResponsesMessage.defaultErorr));
        }
      } catch (error) {
        return Left(ErrorHandler.handel(error).faliure);
      }
    } else {
      //! return connection error
      return Left(DataSource.noInternetConnection.getFaliuer());
    }
  }
}
