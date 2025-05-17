import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'dio_exception.dart';

class DioHelper {


  static var headers = {
    'X-Requested-With': 'XMLHttpRequest',
    'Accept': 'application/json',
  };



  static String errorTextApi(value) {
    try {
      String errorValue = '';
      for (String v in value) {
        errorValue += '- $v\n';
      }
      return errorValue;
    } catch (e) {
      return value;
    }
  }

  static void dialogError(String message) async {
    EasyLoading.showError(message.toString(), dismissOnTap: false, duration: const Duration(seconds: 3));
  }

  static void dioErrorStatusCode(e) async {
    dialogError(DioExceptionError.fromDioError(e).toString());
  }

  static void dioAuthErrorStatusCode(e) async {
    dialogError(DioExceptionError.fromDioError(e).toString());
    // if (e.response?.statusCode == 401) {
    //   dialogError(DioExceptionError.fromDioError(e).toString());
    // } else {
    //   dialogError(DioExceptionError.fromDioError(e).toString());
    // }
  }
}
