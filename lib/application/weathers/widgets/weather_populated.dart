import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/weathers/models/models.dart';
import '../cubit/weather_cubit.dart';
import 'weather_current.dart';
import 'weather_forecast.dart';
class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({
    required this.weather,
    required this.forecast,
    required this.units,
    required this.onRefresh,
    required this.currentIndex,
    super.key,
  });

  final Weather weather;

  final Forecast forecast;
  final TemperatureUnits units;
  final ValueGetter<Future<void>> onRefresh;

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;


    return Stack(
      children: [
        _WeatherBackground(),
        RefreshIndicator(
          onRefresh: onRefresh,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // IconButton(onPressed: () {
                    //   Navigator.of(context).push(SearchPage.route());
                    // }, icon: Text('🏙️ City Search', style: TextStyle(fontSize: 30))),
                    //Spacer(),
                    Text('°F',style: textTheme.headlineLarge,),
                    SizedBox(width: 5,),
                    Switch(
                      value: units.isCelsius,
                      onChanged: (_) => context.read<WeatherCubit>().toggleUnits(),
                    ),
                    Text('°C',style: textTheme.headlineLarge,),
                    SizedBox(width: 10,),
                  ],
                ),
              ),
              Expanded(
                child: IndexedStack(
                  index: currentIndex,
                  children: [
                    Align(
                      alignment: const Alignment(0, -1 / 3),
                      child: WeatherCurrent(weather: weather,units: units,),
                    ),
                    WeatherForecast(forecast: forecast, units: units),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primaryContainer;
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.25, 0.75, 0.90, 1.0],
            colors: [
              color,
              color.brighten(),
              color.brighten(33),
              color.brighten(50),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(
      1 <= percent && percent <= 100,
      'percentage must be between 1 and 100',
    );
    final p = percent / 100;
    final alpha = a.round();
    final red = r.round();
    final green = g.round();
    final blue = b.round();
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}

