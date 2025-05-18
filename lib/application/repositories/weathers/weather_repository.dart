import 'package:weather/application/repositories/weathers/responses/forecast_response.dart';
import 'package:weather/application/repositories/weathers/responses/weather_response.dart';

import '../../application.dart';
import 'models/weather.dart';
import 'responses/geo_coding_response.dart';

import '../apis/api_manager.dart';
import 'models/geocoding_result.dart';
/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

class WeatherRequestFailure implements Exception {}
class WeatherRepository {
  final api = ApiManager();

  void dispose() => api.close();

  Future<Location> locationSearch(String cityName) async {
    try {
      final response = await api.getGeocodingByCityName(cityName);
      if (response.statusCode == 200) {
        final geoResponse = GeoCodingResponse.fromMap(response.data );
        if (geoResponse.results.isNotEmpty) {
          return geoResponse.results.first.location;
        } else {
          throw LocationNotFoundFailure();
        }
      }
      throw LocationRequestFailure();
    } on Exception catch (e) {
      if (e is LocationNotFoundFailure) {
        rethrow;
      }
      throw LocationRequestFailure();
    }
  }

  Future<Weather> getWeatherByCityName(String city) async {
    try {
      final location = await locationSearch(city);
      return getWeatherByLocation(location);
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<Forecast> getForecastByCityName(String city) async {
    try {
      final location = await locationSearch(city);
      return getForecastByLocation(location);
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<Weather> getWeatherByLocation(Location location) async {
    try {
      final response = await api.getWeather(location);
      if (response.statusCode == 200) {
        final weatherResponse = WeatherResponse.fromMap( response.data );
        return Weather(location: location.name, weatherInfo: weatherResponse.weatherInformation);
      }
      throw WeatherRequestFailure();
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<Forecast> getForecastByLocation(Location location) async {
    try {
      final response = await api.getForecast(location);
      if (response.statusCode == 200) {
        final forecastResponse = ForecastResponse.fromMap( response.data );
        return Forecast(location: location.name, weatherInfos: forecastResponse.weatherInformationList);
      }
      throw WeatherRequestFailure();
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}