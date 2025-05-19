// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:weather/application/repositories/weathers/models/models.dart';
import 'package:weather/application/repositories/weathers/weather_repository.dart';
import 'package:weather/application/search/search.dart';
import 'package:weather/application/weathers/weathers.dart';
import 'package:weather/application/weathers/widgets/widgets.dart';


import '../../helpers/hydrated_bloc.dart';

const weatherLocationPoint = Location(id: 0, name: 'Chiang Mai', latitude: 18.79038, longitude: 98.98468);

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockWeatherCubit extends MockCubit<WeatherState>
    implements WeatherCubit {}

void main() {
  setUpAll(() {
    registerFallbackValue(weatherLocationPoint );
  });
  initHydratedStorage();

  group('WeatherPage', () {
    final weather = Weather(
      weatherInfo: WeatherInformation(
        temperature: 340,
        humidity: 60,
        condition: WeatherCondition.cloudy,
        dateTime: DateTime(2025)
      ),
      location: 'London',
    );
    late WeatherCubit weatherCubit;

    setUp(() {
      weatherCubit = MockWeatherCubit();
    });

    testWidgets('renders WeatherEmpty for WeatherStatus.initial',
        (tester) async {
      when(() => weatherCubit.state).thenReturn(WeatherState());
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherPage()),
        ),
      );
      expect(find.byType(WeatherEmpty), findsOneWidget);
    });

    testWidgets('renders WeatherLoading for WeatherStatus.loading',
        (tester) async {
      when(() => weatherCubit.state).thenReturn(
        WeatherState(
          status: WeatherStatus.loading,
        ),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherPage()),
        ),
      );
      expect(find.byType(WeatherLoading), findsOneWidget);
    });

    testWidgets('renders WeatherPopulated for WeatherStatus.success',
        (tester) async {
      when(() => weatherCubit.state).thenReturn(
        WeatherState(
          status: WeatherStatus.success,
          weather: weather,
        ),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherPage()),
        ),
      );
      expect(find.byType(WeatherPopulated), findsOneWidget);
    });

    testWidgets('renders WeatherError for WeatherStatus.failure',
        (tester) async {
      when(() => weatherCubit.state).thenReturn(
        WeatherState(
          status: WeatherStatus.failure,
        ),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherPage()),
        ),
      );
      expect(find.byType(WeatherError), findsOneWidget);
    });

    testWidgets('state is cached', (tester) async {
      when<dynamic>(() => hydratedStorage.read('$WeatherCubit')).thenReturn(
        WeatherState(
          status: WeatherStatus.success,
          weather: weather,
          temperatureUnits: TemperatureUnits.fahrenheit,
        ).toJson(),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: WeatherCubit(MockWeatherRepository()),
          child: MaterialApp(home: WeatherPage()),
        ),
      );
      expect(find.byType(WeatherPopulated), findsOneWidget);
    });



    testWidgets('navigates to SearchPage when search button is tapped',
        (tester) async {
      when(() => weatherCubit.state).thenReturn(WeatherState());
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherPage()),
        ),
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(SearchPage), findsOneWidget);
    });

    testWidgets('triggers refreshWeather on pull to refresh', (tester) async {
      when(() => weatherCubit.state).thenReturn(
        WeatherState(
          status: WeatherStatus.success,
          weather: weather,
        ),
      );
      when(() => weatherCubit.refreshWeather()).thenAnswer((_) async {});
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherPage()),
        ),
      );
      await tester.fling(
        find.text('London'),
        const Offset(0, 500),
        1000,
      );
      await tester.pumpAndSettle();
      verify(() => weatherCubit.refreshWeather()).called(1);
    });


  });
}
