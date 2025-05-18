import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/application/application.dart';

import 'package:weather/application/repositories/repositories.dart';
import 'package:weather/application/repositories/weathers/models/models.dart';
import 'package:weather/application/weathers/weathers.dart';

import 'helpers/hydrated_bloc.dart';


class MockWeatherCubit extends MockCubit<WeatherState>
    implements WeatherCubit {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  initHydratedStorage();

  group('WeatherApp', () {
    testWidgets('renders WeatherAppView', (tester) async {
      await tester.pumpWidget(const WeatherApp());
      expect(find.byType(WeatherAppView), findsOneWidget);
    });
  });

  group('WeatherAppView', () {
    late WeatherCubit weatherCubit;
    late WeatherRepository weatherRepository;

    setUp(() {
      weatherCubit = MockWeatherCubit();
      weatherRepository = MockWeatherRepository();
    });

    testWidgets('renders WeatherPage', (tester) async {
      when(() => weatherCubit.state).thenReturn(WeatherState());
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: weatherRepository,
          child: BlocProvider.value(
            value: weatherCubit,
            child: const WeatherAppView(),
          ),
        ),
      );
      expect(find.byType(WeatherPage), findsOneWidget);
    });

    testWidgets('has correct theme color scheme', (tester) async {
      final state = WeatherState(
        status: WeatherStatus.success,
        weather: Weather(
          weatherInfo: WeatherInformation(temperature: 304, humidity: 60, condition: WeatherCondition.rainy, dateTime: DateTime.now()),
          location: 'Chiang Mai',
        ),
      );
      when(() => weatherCubit.state).thenReturn(state);
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: weatherRepository,
          child: BlocProvider.value(
            value: weatherCubit,
            child: const WeatherAppView(),
          ),
        ),
      );
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(
        materialApp.theme?.colorScheme,
        ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
      );
    });
  });
}
