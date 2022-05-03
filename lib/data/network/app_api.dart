import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:test_app/app/constants.dart';
import 'package:test_app/data/responses/responses.dart';

part 'generated/app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String baseUrl}) = _AppServicesClient;

  @POST("customers/login")
  Future<AuthenticationResponse> login();
}
