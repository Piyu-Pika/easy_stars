import 'package:flutter_test/flutter_test.dart';

import 'package:easy_stars/easy_stars.dart';

void main() {
  group('EasyStarsRating Widget Tests', () {
    testWidgets('renders with default properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        EasyStarsRating(
          initialRating: 3.0,
          starCount: 5,
          onRatingChanged: (value) {},
        ),
      );

      expect(find.byType(EasyStarsRating), findsOneWidget);
      expect(find.text('3.0'), findsOneWidget);
    });

    testWidgets('updates rating on interaction', (WidgetTester tester) async {
      double rating = 0.0;
      await tester.pumpWidget(
        EasyStarsRating(
          initialRating: rating,
          starCount: 5,
          onRatingChanged: (value) {
            rating = value;
          },
        ),
      );

      await tester.tap(find.byType(EasyStarsRating));
      await tester.pump();

      expect(rating, greaterThan(0.0));
    });
  });
  group('EasyStarsDisplay Widget Tests', () {
    testWidgets('renders with default properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        EasyStarsDisplay(
          initialRating: 4.0,
          starCount: 5,
          onRatingChanged: (value) {},
        ),
      );

      expect(find.byType(EasyStarsDisplay), findsOneWidget);
      expect(find.text('4.0'), findsOneWidget);
    });

    testWidgets('updates rating on interaction', (WidgetTester tester) async {
      double rating = 0.0;
      await tester.pumpWidget(
        EasyStarsDisplay(
          initialRating: rating,
          starCount: 5,
          onRatingChanged: (value) {
            rating = value;
          },
        ),
      );

      await tester.tap(find.byType(EasyStarsDisplay));
      await tester.pump();

      expect(rating, greaterThan(0.0));
    });
  });
}
