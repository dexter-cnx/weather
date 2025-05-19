// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/application/repositories/weathers/weathers.dart';
import 'package:weather/application/weathers/widgets/widgets.dart';


void main() {
  group('WeatherPopulated', () {
    final weather = Weather(
      weatherInfo: WeatherInformation(
          temperature: 340,
          humidity: 60,
          condition: WeatherCondition.cloudy,
          dateTime: DateTime(2025)
      ),
      location: 'London',
    );
    final forecast = Forecast(
      weatherInfos:[
        WeatherInformation(
            temperature: 340,
            humidity: 60,
            condition: WeatherCondition.cloudy,
            dateTime: DateTime(2025)
        )
      ],
      location: 'London',
    );

    testWidgets('renders correct emoji (clear)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherPopulated(
              weather: weather.copyWith(weatherInfo: weather.weatherInfo.copyWith(condition: WeatherCondition.clear )),
              forecast: forecast,
              currentIndex: 0,
              units: TemperatureUnits.fahrenheit,
              onRefresh: () async {},
            ),
          ),
        ),
      );
      expect(find.text('☀️'), findsOneWidget);
    });

    testWidgets('renders correct emoji (rainy)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherPopulated(
              weather: weather.copyWith(weatherInfo:
                  weather.weatherInfo.copyWith(condition: WeatherCondition.rainy)
              ),
              forecast: forecast,
              currentIndex: 0,
              units: TemperatureUnits.fahrenheit,
              onRefresh: () async {},
            ),
          ),
        ),
      );
      expect(find.text('🌧️'), findsOneWidget);
    });

    testWidgets('renders correct emoji (cloudy)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherPopulated(
              weather: weather.copyWith(weatherInfo:
                weather.weatherInfo.copyWith(condition: WeatherCondition.cloudy)
              ),
              forecast: forecast,
              currentIndex: 0,
              units: TemperatureUnits.fahrenheit,
              onRefresh: () async {},
            ),
          ),
        ),
      );
      expect(find.text('☁️'), findsOneWidget);
    });

    testWidgets('renders correct emoji (snowy)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherPopulated(
              weather: weather.copyWith(weatherInfo:
              weather.weatherInfo.copyWith(condition: WeatherCondition.snowy)
              ),
              forecast: forecast,
              currentIndex: 0,
              units: TemperatureUnits.fahrenheit,
              onRefresh: () async {},
            ),
          ),
        ),
      );
      expect(find.text('🌨️'), findsOneWidget);
    });

    testWidgets('renders correct emoji (unknown)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherPopulated(
              weather: weather.copyWith(weatherInfo:
              weather.weatherInfo.copyWith(condition: WeatherCondition.unknown)
              ),
              forecast: forecast,
              currentIndex: 0,
              units: TemperatureUnits.fahrenheit,
              onRefresh: () async {},
            ),
          ),
        ),
      );
      expect(find.text('❓'), findsOneWidget);
    });
  });
}
