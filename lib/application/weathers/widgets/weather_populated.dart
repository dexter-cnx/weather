import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


import '../../repositories/weathers/models/models.dart';
import '../cubit/weather_cubit.dart';

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
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');

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
                    Spacer(),
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
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        clipBehavior: Clip.none,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 48),
                            _WeatherIcon(condition: weather.weatherInfo.condition),
                            Text(
                              weather.location,
                              style: theme.textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w200,
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  weather.weatherInfo.formattedTemperature(units),
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Humidity\n',
                                    style: theme.textTheme.bodySmall,
                                    children: [
                                      TextSpan(
                                        text: '${weather.weatherInfo.humidity} %',
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ]
                                  ),textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                            //RichText(text: text),
                            Text(
                              '''Last Updated at ${TimeOfDay.fromDateTime(weather.weatherInfo.dateTime).format(context)}''',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      //mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //SizedBox(height: 100,),
                        Text(
                          forecast.location,
                          style: theme.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            if (forecast.weatherInfos.isEmpty) {
                              return SizedBox();
                            }
                            final first = dateFormat.format(forecast.weatherInfos.first.dateTime);
                            final last = dateFormat.format(forecast.weatherInfos.last.dateTime);
                            return Text(
                              'Forecast: $first - $last',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w200,
                              ),
                            );
                          }
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(),
                        ),
                        Expanded(child: CustomScrollView(
                          scrollDirection: Axis.vertical,
                          slivers: <Widget>[
                            SliverPadding(
                              padding: const EdgeInsets.only(bottom: 70.0),
                              sliver:  SliverFixedExtentList(
                                itemExtent: 100.0,
                                delegate:  SliverChildBuilderDelegate((context, index) {
                                    final item = forecast.weatherInfos[index];
                                    return ListTile(
                                      leading: _WeatherIconLabel(condition:item.condition),
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.formattedTemperature(units),
                                            style: theme.textTheme.bodyLarge?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            dateFormat.format(item.dateTime),
                                            style: theme.textTheme.bodyLarge?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: RichText(
                                        text: TextSpan(
                                            text: 'Humidity: ',
                                            style: theme.textTheme.bodySmall,
                                            children: [
                                              TextSpan(
                                                text: '${item.humidity} %',
                                                style: theme.textTheme.titleMedium?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ]
                                        ),textAlign: TextAlign.end,
                                      ),
                                    );
                                  },
                                  childCount:  forecast.weatherInfos.length,
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    )
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

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({required this.condition});

  static const _iconSize = 75.0;

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Text(
      condition.toEmoji,
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

class _WeatherIconLabel extends StatelessWidget {
  const _WeatherIconLabel({required this.condition});

  static const _iconSize = 75.0;

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          condition.toEmoji,
          style: const TextStyle(fontSize: _iconSize),
        ),
        Positioned.fill(
          child: Text(
          condition.name,
          style: const TextStyle(fontSize: 13),
        ),)

      ],
    );
  }
}

extension on WeatherCondition {
  String get toEmoji {
    switch (this) {
      case WeatherCondition.clear:
        return '☀️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.cloudy:
        return '☁️';
      case WeatherCondition.snowy:
        return '🌨️';
      case WeatherCondition.unknown:
        return '❓';
    }
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

// extension on Weather {
//   String formattedTemperature(TemperatureUnits units) {
//     return '''${units.fromKelvin(weatherInfo.temperature).toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
//   }
// }
