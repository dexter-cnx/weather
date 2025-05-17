import 'responses/geo_coding_response.dart';

import '../apis/api_manager.dart';
import 'models/geocoding_result.dart';
/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}
class LocationRepository {
  final api = ApiManager();
  Future<GeocodingResult> locationSearch(String cityName) async {
    final response = await api.getGeocodingByCityName(cityName);
    if (response.statusCode == 200) {
      final geoResponse = GeoCodingResponse.fromMap(response.data );
      if (geoResponse.results.isNotEmpty) {
        return geoResponse.results.first;
      } else {
        throw LocationNotFoundFailure();
      }
    }
    throw LocationRequestFailure();
  }
}