import 'package:flutter/material.dart';

import '../../search/view/search_page.dart';

class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
        onTap: () {
          Navigator.of(context).push(SearchPage.route());
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🏙️', style: TextStyle(fontSize: 64)),
            Text(
              'Please Select a City!',
              style: theme.textTheme.headlineSmall,
            ),
          ],
        ));
  }
}
