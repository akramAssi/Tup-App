import 'package:dio/dio.dart';
import 'package:test_app/data/network/failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultErorr
}

class ErrorHandler implements Exception {
  late Faliure faliure;

  ErrorHandler.handel(dynamic error) {
    if (error is DioError) {
      // dio error its from resonse
      faliure = _handelDioError(error);
    } else {
      faliure = DataSource.defaultErorr.getFaliuer();
    }
  }

  Faliure _handelDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeout.getFaliuer();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFaliuer();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFaliuer();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponsesCode.badRequest:
            return DataSource.badRequest.getFaliuer();
          case ResponsesCode.forbidden:
            return DataSource.forbidden.getFaliuer();
          case ResponsesCode.unauthorised:
            return DataSource.unauthorised.getFaliuer();
          case ResponsesCode.internalServerError:
            return DataSource.internalServerError.getFaliuer();
          default:
            return DataSource.defaultErorr.getFaliuer();
        }
      case DioErrorType.cancel:
        return DataSource.cancel.getFaliuer();
      case DioErrorType.other:
        return DataSource.defaultErorr.getFaliuer();
    }
  }
}

extension DataSourceExtension on DataSource {
  Faliure getFaliuer() {
    switch (this) {
      case DataSource.success:
        return Faliure(ResponsesCode.success, ResponsesMessage.success);

      case DataSource.noContent:
        return Faliure(ResponsesCode.noContent, ResponsesMessage.noContent);
      case DataSource.badRequest:
        return Faliure(ResponsesCode.badRequest, ResponsesMessage.badRequest);
      case DataSource.forbidden:
        return Faliure(ResponsesCode.forbidden, ResponsesMessage.forbidden);

      case DataSource.unauthorised:
        return Faliure(
            ResponsesCode.unauthorised, ResponsesMessage.unauthorised);
      case DataSource.notFound:
        return Faliure(ResponsesCode.notFound, ResponsesMessage.notFound);
      case DataSource.internalServerError:
        return Faliure(ResponsesCode.internalServerError,
            ResponsesMessage.internalServerError);
      case DataSource.connectTimeout:
        return Faliure(
            ResponsesCode.connectTimeout, ResponsesMessage.connectTimeout);
      case DataSource.cancel:
        return Faliure(ResponsesCode.cancel, ResponsesMessage.cancel);
      case DataSource.receiveTimeout:
        return Faliure(
            ResponsesCode.receiveTimeout, ResponsesMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Faliure(ResponsesCode.sendTimeout, ResponsesMessage.sendTimeout);
      case DataSource.cacheError:
        return Faliure(ResponsesCode.cacheError, ResponsesMessage.cacheError);
      case DataSource.noInternetConnection:
        return Faliure(ResponsesCode.noInternetConnection,
            ResponsesMessage.noInternetConnection);
      case DataSource.defaultErorr:
        return Faliure(
            ResponsesCode.defaultErorr, ResponsesMessage.defaultErorr);
      default:
        return Faliure(
            ResponsesCode.defaultErorr, ResponsesMessage.defaultErorr);
    }
  }
}

class ResponsesCode {
  // API status code
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no contect
  static const int badRequest = 400; // failuer, api rejected the request
  static const int forbidden = 403; // failuer, api rejected the request
  static const int unauthorised = 401; // faliuer, user is not authorised
  static const int notFound = 404; //faliuer, api is not corrrect and not found
  static const int internalServerError =
      500; // faliuer, crash happened in  server side
  // local status code
  static const int defaultErorr = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponsesMessage {
  // API status code
  static const String success = "Success"; // success with data
  static const String noContent =
      "Success with no contect"; // success with no contect
  static const String badRequest =
      "Bad request,try again later"; // failuer, api rejected the request
  static const String forbidden =
      "Forbidden, try again later"; // failuer, api rejected the request
  static const String unauthorised =
      "user is not authorised, try again later"; // faliuer, user is not authorised
  static const String notFound =
      "Url in not found, try again later"; //faliuer, api is not corrrect and not found
  static const String internalServerError =
      "Some thing went wrong, try again later"; // faliuer, crash happened in  server side
  // local status code
  static const String defaultErorr = "Some thing went wrong, try again later";
  static const String connectTimeout = "Time out error, try again later";
  static const String cancel = "Request was canncelled, try again later";
  static const String receiveTimeout = "Time out error, try again later";
  static const String sendTimeout = "Time out error, try again later";
  static const String cacheError = "Cache error, try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
}
class ApiInternalStatus{
  static const int success=0;
  static const int faliuer=1;
}