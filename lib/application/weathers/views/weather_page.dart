import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../search/search.dart';
import '../cubit/weather_cubit.dart';
import '../widgets/widgets.dart';


class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return switch (state.status) {
              WeatherStatus.initial => const WeatherEmpty(),
              WeatherStatus.loading => const WeatherLoading(),
              WeatherStatus.failure => const WeatherError(),
              WeatherStatus.success => WeatherPopulated(
                  weather: state.weather,
                  units: state.temperatureUnits,
                  currentIndex: state.currentIndex,
                  forecast: state.forecast,
                  onRefresh: () {
                    return context.read<WeatherCubit>().refreshWeather();
                  },
                ),
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search',),
        onPressed: () async {
          Navigator.of(context).push(SearchPage.route());
        },
      ),
      bottomNavigationBar: BlocBuilder<WeatherCubit, WeatherState>(
        buildWhen: (previous, current) =>
        previous.currentIndex != current.currentIndex || previous.status != current.status,
        builder: (context, state) {
          if (!state.status.isSuccess) {
            return SizedBox();
          }
          return BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index )=> context.read<WeatherCubit>().index = index,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.sunny_snowing),
                label: 'Current',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_sharp),
                label: 'Forecast',
              ),

            ],
          );
        },
      ),
    );
  }
}
