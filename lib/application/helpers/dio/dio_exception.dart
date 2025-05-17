import 'package:dio/dio.dart';
import 'dio_header.dart';

class DioExceptionError implements Exception {
  late String errorMessage;

  DioExceptionError.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Bad certificate.';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'checkInternetConnection';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(dioError.response?.statusCode, dioError);
        break;
      case DioExceptionType.unknown:
        errorMessage = 'unknown';
        break;
      // default:
      //   errorMessage = dioError.message.toString();
      //   break;
    }
  }

  String _handleStatusCode(int? statusCode, dioError) {
    if (dioError.response?.data is String) return dioError.response?.data;
    switch (statusCode) {
      case 400:
        return DioHelper.errorTextApi(dioError.response?.data['message'] ?? 'Bad request.');
      case 401:
        return DioHelper.errorTextApi(dioError.response?.data['message'] ?? 'Authentication failed.');
      case 403:
        return DioHelper.errorTextApi(dioError.response?.data['message'] ?? 'The authenticated user is not allowed to access the specified API endpoint.');
      case 404:
        return DioHelper.errorTextApi(dioError.response?.data['message'] ?? 'The requested resource does not exist.');
      case 405:
        return DioHelper.errorTextApi(dioError.response?.data['message'] ?? 'Method not allowed. Please check the Allow header for the allowed HTTP methods.');
      case 415:
        return DioHelper.errorTextApi(dioError.response?.data['message'] ?? 'Unsupported media type. The requested content type or version number is invalid.');
      case 422:
        return DioHelper.errorTextApi(dioError.response?.data['message'] ?? 'Data validation failed.');
      case 429:
        return DioHelper.errorTextApi(dioError.response?.data['message'] ?? 'Too many requests.');
      case 500:
        return DioHelper.errorTextApi(dioError.response?.data['message'] ?? 'Internal server error.');
      default:
        return  DioHelper.errorTextApi(dioError.response?.data['message'] ?? 'API errors');
    }
  }

  @override
  String toString() => errorMessage;
}
