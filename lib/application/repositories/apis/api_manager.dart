
import 'package:dio/dio.dart';
import '../weathers/models/geocoding_result.dart';

const kDefaultConnectionTimeOut = Duration(seconds: 30);
const kDefaultReceiveTimeOut = Duration(seconds: 30);
const  openWeatherApiKey = '12c1c564dde9c9af47566b8f660fc53d';
class ApiManager {

  static final ApiManager _instance = ApiManager._internal();
  factory ApiManager() => _instance;

  late Dio _dio;

  Dio get dio => _dio;

  ApiManager._internal() {
    _dio = initial();
  }
  Dio initial() {
    //return Dio();

    final options = BaseOptions(
      baseUrl: openWeatherURL,
      connectTimeout: kDefaultConnectionTimeOut,
      receiveTimeout: kDefaultReceiveTimeOut,
    );

    final dio = Dio(options)
      ..interceptors.add(ApiInterceptor(this))
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }

  void close() {
    dio.close();
  }

  final geocodingApi = 'https://geocoding-api.open-meteo.com/v1';

  final geocoding = '/search?count=1';

  String weatherByLocationUri(Location location) =>  '$weather&${location.toParams}';
  String forecastByLocationUri(Location location) =>  '$forecastWholeDay&${location.toParams}';


  final openWeatherURL = 'https://api.openweathermap.org/data/2.5';

  final weather = '/weather?appid=$openWeatherApiKey';
  final forecastWholeDay = '/forecast?appid=$openWeatherApiKey&cnt=8';


  String geoCodingByNameURI(String name) => "$geocoding&name=$name";

  Future<Response<dynamic>> getGeocodingByCityName(String name) async =>
      dio.get(geoCodingByNameURI(name));

  Future<Response<dynamic>> getWeather(Location location) async =>
      dio.get(weatherByLocationUri(location));

  Future<Response<dynamic>> getForecast(Location location) async =>
      dio.get(forecastByLocationUri(location));

}

class ApiInterceptor extends Interceptor {


  final ApiManager apiManager;

  ApiInterceptor(this.apiManager);



  // @override
  // void onError(
  //     DioException err,
  //     ErrorInterceptorHandler handler,
  //     ) async {
  //   if (err.response?.statusCode == HttpStatus.unauthorized) {
  //     handler.next(err);
  //
  //   } else if (err.response?.statusCode == HttpStatus.conflict) {
  //     handler.next(err);
  //   }
  //
  //   return handler.next(err);
  // }

  // final versionTest= [
  //   'v2/',
  // ];

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {


    if (options.path.contains(apiManager.geocoding )) {
      options.baseUrl = apiManager.geocodingApi;
    }


    super.onRequest(options, handler);
  }
}