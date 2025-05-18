// ignore_for_file: prefer_const_constructors


import 'dart:convert';

import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';
import 'package:weather/application/repositories/apis/api_manager.dart';
import 'package:weather/application/repositories/repositories.dart';


void main() {
  final api = ApiManager();
  late DioAdapter dioAdapter;
  late WeatherRepository locationRepository;

  setUp(() {
    dioAdapter = DioAdapter(dio: api.dio);
    api.dio.httpClientAdapter = dioAdapter;

    final result = jsonDecode('''
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
          "generationtime_ms": 0.39589405
      }
      ''');

    dioAdapter
      ..onGet(
        api.geoCodingByNameURI('Chiang Mai'),
            (server)=> server.reply(200, result )
      )..onGet(
        api.geoCodingByNameURI('Error'),
            (server)=> server.reply(400,{
          "error": true,
          "reason": "Error"
        })
      )..onGet(
        api.geoCodingByNameURI('No where'),
            (server)=> server.reply(200, {
              "generationtime_ms": 0.5034208
            } )
      );
    locationRepository = WeatherRepository();
  });

  group('OpenMeteoApiClient', () {



    test('makes correct http request', () async {
      final geoResult = await locationRepository.locationSearch('Chiang Mai');
      expect(geoResult.name, equals('Chiang Mai'));

    });

    test('throws LocationNotFoundFailure on No where', () async {
      expect( () async => await locationRepository.locationSearch('No where'), throwsA(isA<LocationNotFoundFailure>()));
    });

    test('throws LocationRequestFailure on non-200 response', () async {
      expect( () async => await locationRepository.locationSearch('Error'), throwsA(isA<LocationRequestFailure>()));
    });


  });
}
