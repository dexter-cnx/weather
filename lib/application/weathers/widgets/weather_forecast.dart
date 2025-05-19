import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../repositories/weathers/models/models.dart';
import 'weather_icon.dart';

class WeatherForecast extends StatelessWidget {
  final Forecast forecast;
  final TemperatureUnits units;
  const WeatherForecast({super.key,required this.forecast,required this.units});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //final textTheme = theme.textTheme;
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
                    leading: WeatherIconLabel(condition:item.condition),
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
    );
  }
}
