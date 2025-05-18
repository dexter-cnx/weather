import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../weathers/weathers.dart';

class SearchPage extends StatefulWidget {
  const SearchPage._();

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const SearchPage._());
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();

  String get _text => _textController.text.trim();
  String? _errorMessage;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    Future<String?> onSubmitted() async {
      try {
        final cubit = context.read<WeatherCubit>();
        // cubit.getLocationByCity(_text).then((location) {
        //   cubit.fetchWeatherByLocation(location);
        //   _errorMessage = null;
        //   //Navigator.of(context).pop();
        // });
        final location = await cubit.getLocationByCity(_text);
        cubit.fetchWeatherByLocation(location);
        _errorMessage = null;
        if (context.mounted) {
          Navigator.of(context).pop();
        }
        //
        // Navigator.of(context).pop();
      } on Exception  {
        setState(() {
          _errorMessage = 'City name "$_text" not found!';
        });
      }
      return _errorMessage;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('City Search')),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text('🏙️', style: TextStyle(fontSize: 30)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: _textController,
                onSubmitted: (value) => onSubmitted(),
                decoration:  InputDecoration(
                  labelText: 'City',
                  hintText: 'Input city name',
                  errorText: _errorMessage,
                  errorStyle: textTheme.bodySmall?.copyWith(color: Colors.red),
                  hintStyle: textTheme.bodySmall?.copyWith(color: Colors.grey),
                  suffixIcon: IconButton(
                    key: const Key('searchPage_search_iconButton'),
                    icon: const Icon(Icons.search, semanticLabel: 'Submit'),
                    onPressed: ()=> onSubmitted(),
                    //onPressed: () => Navigator.of(context).pop(_text),
                  ),
                ),
              ),
            ),
          ),
          // IconButton(
          //   key: const Key('searchPage_search_iconButton'),
          //   icon: const Icon(Icons.search, semanticLabel: 'Submit'),
          //   onPressed: () => Navigator.of(context).pop(_text),
          // ),
        ],
      ),
    );
  }
}
