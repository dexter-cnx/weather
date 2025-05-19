import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/application/search/view/search_page.dart';


void main() {
  group('SearchPage', () {
    testWidgets('is routable', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(SearchPage.route());
                },
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(SearchPage), findsOneWidget);
    });

  });
}
