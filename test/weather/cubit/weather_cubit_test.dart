// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:weather/application/repositories/weathers/weathers.dart';
import 'package:weather/application/weathers/weathers.dart';


import '../../helpers/hydrated_bloc.dart';

const weatherLocation = 'Chiang Mai';
const weatherLocationPoint = Location(id: 0, name: weatherLocation, latitude: 18.79038, longitude: 98.98468);

// const weatherCondition = WeatherCondition.rainy;
// const weatherTemperature = 9.8;

class MockWeatherRepository extends Mock
    implements WeatherRepository {}

class MockWeather extends Mock implements Weather {
}
class MockForecast extends Mock implements Forecast {}

void main() {
  setUpAll(() {
    registerFallbackValue(weatherLocationPoint );
  });
  initHydratedStorage();

  group('WeatherCubit', () {
    late Weather weather;
    late Forecast forecast;
    late WeatherRepository weatherRepository;
    late WeatherCubit weatherCubit;
    final  weatherInformation =
    WeatherInformation(temperature: 304, humidity: 60, condition:  WeatherCondition.rainy, dateTime: DateTime(2025) );

    setUp(() async {
      weather = MockWeather();
      forecast = MockForecast();


      weatherRepository = MockWeatherRepository();
      when(() => weather.weatherInfo).thenReturn(weatherInformation);
      when(() => weather.location).thenReturn(weatherLocation);
      when(() => forecast.location).thenReturn(weatherLocation);
      when(() => forecast.weatherInfos).thenReturn([weatherInformation]);


      when(
            () => weatherRepository.locationSearch(any()),
      ).thenAnswer((_) async => weatherLocationPoint);
      when(
        () => weatherRepository.getWeatherByCityName(any()),
      ).thenAnswer((_) async => weather);
      when(
            () => weatherRepository.getWeatherByLocation(any()),
      ).thenAnswer((_) async => weather);
      when(
            () => weatherRepository.getForecastByCityName(any()),
      ).thenAnswer((_) async => forecast);
      when(
            () => weatherRepository.getForecastByLocation(any()),
      ).thenAnswer((_) async => forecast);
      weatherCubit = WeatherCubit(weatherRepository);
    });

    test('initial state is correct', () {
      final weatherCubit = WeatherCubit(weatherRepository);
      expect(weatherCubit.state, WeatherState());
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        final weatherCubit = WeatherCubit(weatherRepository);
        expect(
          weatherCubit.fromJson(weatherCubit.toJson(weatherCubit.state)),
          weatherCubit.state,
        );
      });
    });

    group('fetchWeather', () {


      blocTest<WeatherCubit, WeatherState>(
        'emits [loading, failure] when getWeather throws',
        setUp: () {
          when(
            () => weatherRepository.getWeatherByCityName(any()),
          ).thenThrow(Exception('oops'));
        },
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeather(weatherLocation),
        expect: () => <WeatherState>[
          WeatherState(status: WeatherStatus.loading),
          WeatherState(status: WeatherStatus.failure),
        ],
      );


    });

    group('refreshWeather', () {

      final  weatherInformation =
      WeatherInformation(temperature: 304, humidity: 60, condition:  WeatherCondition.rainy, dateTime: DateTime(2025) );

      blocTest<WeatherCubit, WeatherState>(
        'emits nothing when status is not success',
        build: () => weatherCubit,
        act: (cubit) => cubit.refreshWeather(),
        expect: () => <WeatherState>[],
        verify: (_) {
          verifyNever(() => weatherRepository.getWeatherByCityName(any()));
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits nothing when location is null',
        build: () => weatherCubit,
        seed: () => WeatherState(status: WeatherStatus.success),
        act: (cubit) => cubit.refreshWeather(),
        expect: () => <WeatherState>[],
        verify: (_) {
          verifyNever(() => weatherRepository.getWeatherByCityName(any()));
        },
      );


    });

    group('toggleUnits', () {
      final  weatherInformation =
      WeatherInformation(temperature: 304, humidity: 60, condition:  WeatherCondition.rainy, dateTime: DateTime(2025) );
      blocTest<WeatherCubit, WeatherState>(
        'emits updated units when status is not success',
        build: () => weatherCubit,
        act: (cubit) => cubit.toggleUnits(),
        expect: () => <WeatherState>[
          WeatherState(temperatureUnits: TemperatureUnits.fahrenheit),
        ],
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits updated units and temperature '
        'when status is success (celsius)',
        build: () => weatherCubit,
        seed: () => WeatherState(
          status: WeatherStatus.success,
          temperatureUnits: TemperatureUnits.fahrenheit,
          weather: Weather(
            location: weatherLocation,
            weatherInfo: weatherInformation
          ),
        ),
        act: (cubit) => cubit.toggleUnits(),
        expect: () => <WeatherState>[
          WeatherState(
            status: WeatherStatus.success,
            weather: Weather(
              location: weatherLocation,
                weatherInfo: weatherInformation
            ),
          ),
        ],
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits updated units and temperature '
        'when status is success (fahrenheit)',
        build: () => weatherCubit,
        seed: () => WeatherState(
          status: WeatherStatus.success,
          weather: Weather(
            location: weatherLocation,
              weatherInfo: weatherInformation
          ),
        ),
        act: (cubit) => cubit.toggleUnits(),
        expect: () => <WeatherState>[
          WeatherState(
            status: WeatherStatus.success,
            temperatureUnits: TemperatureUnits.fahrenheit,
            weather: Weather(
              location: weatherLocation,
                weatherInfo: weatherInformation
            ),
          ),
        ],
      );
    });
  });
}
