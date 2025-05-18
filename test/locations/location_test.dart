import 'package:test/test.dart';
import 'package:weather/application/repositories/weathers/models/models.dart';
import 'package:weather/application/repositories/weathers/responses/geo_coding_response.dart';

void main() {
  group('Location', () {
    group('fromJson', () {
      test('returns correct Location object', () {
        expect(
          GeoCodingResponse.fromJson('''
          {
            "results": [
                {
                    "id": 1153671,
                    "name": "Chiang Mai",
                    "latitude": 18.79038,
                    "longitude": 98.98468,
                    "elevation": 313.0,
                    "feature_code": "PPLA",
                    "country_code": "TH",
                    "admin1_id": 1153670,
                    "admin2_id": 1152000,
                    "timezone": "Asia/Bangkok",
                    "population": 127240,
                    "country_id": 1605651,
                    "country": "Thailand",
                    "admin1": "Chiang Mai",
                    "admin2": "Mueang Chiang Mai"
                }
            ],
            "generationtime_ms": 0.5339384
          }'''
          ),
          isA<GeoCodingResponse>()
              .having((w) => w.results.length, 'results', 1)
        );
      });
      test('returns correct Location object', () {
        expect(
          GeocodingResult.fromJson('''
          {
              "id": 1153671,
              "name": "Chiang Mai",
              "latitude": 18.79038,
              "longitude": 98.98468,
              "elevation": 313.0,
              "feature_code": "PPLA",
              "country_code": "TH",
              "admin1_id": 1153670,
              "admin2_id": 1152000,
              "timezone": "Asia/Bangkok",
              "population": 127240,
              "country_id": 1605651,
              "country": "Thailand",
              "admin1": "Chiang Mai"
          }
          '''
          ),
          isA<GeocodingResult>()
              .having((w) => w.id, 'id', 1153671)
              .having((w) => w.name, 'name', 'Chiang Mai')
              .having((w) => w.latitude, 'latitude', 18.79038)
              .having((w) => w.longitude, 'longitude', 98.98468),
        );
      });
    });
  });
}
