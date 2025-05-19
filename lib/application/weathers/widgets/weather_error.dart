import 'package:flutter/material.dart';

import '../../search/view/search_page.dart';

class WeatherError extends StatelessWidget {
  const WeatherError({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('🙈', style: TextStyle(fontSize: 64)),
        Text(
          'Something went wrong!',
          style: theme.textTheme.headlineSmall,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(SearchPage.route());
          },
          child: Text(
            'Try again',
            style: theme.textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}
