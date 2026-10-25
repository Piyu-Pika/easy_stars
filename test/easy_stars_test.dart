import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('Public API exports', () {
        // Regression test: the bottom sheet exports were accidentally removed
        // from the barrel file in 1.0.10.
    test('barrel exports review bottom sheet symbols', () {
      expect(EasyStarsReviewBottomSheet, isNotNull);
      expect(ReviewType.values, containsAll([ReviewType.stars, ReviewType.emoji]));
      expect(ReviewData, isNotNull);
      expect(ButtonLayoutConfig.values, isNotEmpty);
    });

    test('barrel exports review summary and core widgets', () {
      expect(EasyReviewSummary, isNotNull);
      expect(EasyStars, isNotNull);
      expect(EasyStarsRating, isNotNull);
      expect(EasyStarsDisplay, isNotNull);
      expect(EasyStarsEmoji, isNotNull);
      expect(EasyStarsEmojiSlider, isNotNull);
      expect(StarConfig, isNotNull);
      expect(StarAnimationConfig, isNotNull);
    });
  });

  group('EasyStarsRating Widget Tests', () {
    testWidgets('renders with default properties', (tester) async {
      await tester.pumpWidget(_wrap(
        EasyStarsRating(
          initialRating: 3.0,
          starCount: 5,
          onRatingChanged: (value) {},
        ),
      ));

      expect(find.byType(EasyStarsRating), findsOneWidget);
      // 3 filled + 2 empty icons
      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_border), findsNWidgets(2));
    });

    testWidgets('updates rating on tap', (tester) async {
      double rating = 0.0;
      await tester.pumpWidget(_wrap(
        EasyStarsRating(
          initialRating: rating,
          starCount: 5,
          onRatingChanged: (value) {
            rating = value;
          },
        ),
      ));

      await tester.tap(find.byIcon(Icons.star_border).first);
      await tester.pumpAndSettle();

      expect(rating, greaterThan(0.0));
    });

    testWidgets('shows rating text when enabled', (tester) async {
      await tester.pumpWidget(_wrap(
        EasyStarsRating(
          initialRating: 3.0,
          starCount: 5,
          showRatingText: true,
        ),
      ));

      expect(find.text('3.0'), findsOneWidget);
    });

    testWidgets('updates reactively when properties change', (tester) async {
      await tester.pumpWidget(_wrap(
        EasyStarsRating(
          initialRating: 2.0,
          starCount: 3,
          filledColor: Colors.amber,
        ),
      ));
      expect(find.byIcon(Icons.star), findsNWidgets(2));
      expect(find.byIcon(Icons.star_border), findsNWidgets(1));

      // Changing starCount at runtime must not crash and must rebuild.
      await tester.pumpWidget(_wrap(
        EasyStarsRating(
          initialRating: 2.0,
          starCount: 7,
          filledColor: Colors.amber,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star), findsNWidgets(2));
      expect(find.byIcon(Icons.star_border), findsNWidgets(5));
    });

    testWidgets('exposes semantic rating label', (tester) async {
      await tester.pumpWidget(_wrap(
        EasyStarsRating(initialRating: 3.0, starCount: 5),
      ));

      expect(
        find.bySemanticsLabel('3 out of 5 stars'),
        findsOneWidget,
      );
    });
  });

  group('EasyStarsDisplay Widget Tests', () {
    testWidgets('renders read-only rating', (tester) async {
      await tester.pumpWidget(_wrap(
        EasyStarsDisplay(initialRating: 4.0, starCount: 5),
      ));

      expect(find.byType(EasyStarsDisplay), findsOneWidget);
      expect(find.byIcon(Icons.star), findsNWidgets(4));
      expect(find.byIcon(Icons.star_border), findsNWidgets(1));
    });
  });

  group('StarConfig', () {
    test('copyWith keeps original values when no overrides given', () {
      final original = StarConfig(
        starCount: 7,
        rating: 3.5,
        starShape: StarShape.heart,
        arrangement: StarArrangement.wave,
        gradientColors: [Colors.red, Colors.blue],
      );

      final copy = original.copyWith();

      expect(copy.starCount, 7);
      expect(copy.rating, 3.5);
      expect(copy.starShape, StarShape.heart);
      expect(copy.arrangement, StarArrangement.wave);
      expect(copy.gradientColors, original.gradientColors);
    });

    test('copyWith applies overrides to all fields', () {
      final original = StarConfig(starCount: 5);
      final shadow = BoxShadow(color: Colors.black26);
      final copy = original.copyWith(
        starCount: 10,
        rating: 4.0,
        starSize: 40.0,
        filledColor: Colors.red,
        emptyColor: Colors.white,
        borderColor: Colors.black,
        borderWidth: 2.0,
        spacing: 12.0,
        direction: StarDirection.vertical,
        filling: StarFilling.half,
        alignment: StarAlignment.center,
        interactionMode: StarInteractionMode.drag,
        filledIcon: Icons.favorite,
        emptyIcon: Icons.favorite_border,
        minRating: 1.0,
        maxRating: 10.0,
        allowClear: true,
        showRatingText: true,
        readOnly: true,
        tooltip: 'Rate this',
        semanticLabel: 'Custom label',
        adaptive: true,
        starShape: StarShape.diamond,
        arrangement: StarArrangement.grid,
        gridColumns: 4,
        starShadow: shadow,
      );

      expect(copy.starCount, 10);
      expect(copy.rating, 4.0);
      expect(copy.starSize, 40.0);
      expect(copy.filledColor, Colors.red);
      expect(copy.emptyColor, Colors.white);
      expect(copy.borderColor, Colors.black);
      expect(copy.borderWidth, 2.0);
      expect(copy.spacing, 12.0);
      expect(copy.direction, StarDirection.vertical);
      expect(copy.filling, StarFilling.half);
      expect(copy.alignment, StarAlignment.center);
      expect(copy.interactionMode, StarInteractionMode.drag);
      expect(copy.filledIcon, Icons.favorite);
      expect(copy.emptyIcon, Icons.favorite_border);
      expect(copy.minRating, 1.0);
      expect(copy.maxRating, 10.0);
      expect(copy.allowClear, isTrue);
      expect(copy.showRatingText, isTrue);
      expect(copy.readOnly, isTrue);
      expect(copy.tooltip, 'Rate this');
      expect(copy.semanticLabel, 'Custom label');
      expect(copy.adaptive, isTrue);
      expect(copy.starShape, StarShape.diamond);
      expect(copy.arrangement, StarArrangement.grid);
      expect(copy.gridColumns, 4);
      expect(copy.starShadow, shadow);
    });

    test('star color handles single-star gradient without NaN', () {
      final config = StarConfig(
        starCount: 1,
        gradientColors: [Colors.red, Colors.blue],
      );

      expect(config.getStarColor(0, true), isA<Color>());
    });
  });

  group('EasyStars (arrangements)', () {
    testWidgets('single star arc arrangement does not crash', (tester) async {
      await tester.pumpWidget(_wrap(
        EasyStarsRating(
          initialRating: 1.0,
          starCount: 1,
          arrangement: StarArrangement.arc,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(EasyStarsRating), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('renders grid arrangement', (tester) async {
      await tester.pumpWidget(_wrap(
        EasyStarsRating(
          initialRating: 3.0,
          starCount: 6,
          arrangement: StarArrangement.grid,
          gridColumns: 2,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star), findsNWidgets(3));
    });
  });

  group('EasyStarsEmoji', () {
    testWidgets('supports any number of custom emojis', (tester) async {
      double rating = 0.0;
      await tester.pumpWidget(_wrap(
        EasyStarsEmoji(
          initialRating: 0.0,
          customEmojis: const ['😡', '😑', '🤩'],
          onRatingChanged: (value) {
            rating = value;
          },
        ),
      ));

      expect(find.text('😡'), findsOneWidget);
      expect(find.text('😑'), findsOneWidget);
      expect(find.text('🤩'), findsOneWidget);

      await tester.tap(find.text('🤩'));
      await tester.pumpAndSettle();

      expect(rating, 3.0);
    });

    testWidgets('defaults to five emojis', (tester) async {
      await tester.pumpWidget(_wrap(
        EasyStarsEmoji(initialRating: 2.0),
      ));

      expect(find.text('🤮'), findsOneWidget);
      expect(find.text('😍'), findsOneWidget);
    });
  });

  group('EasyStarsEmojiSlider', () {
    testWidgets('renders slider with rating description', (tester) async {
      await tester.pumpWidget(_wrap(
        EasyStarsEmojiSlider(
          initialRating: 4.0,
          sliderWidth: 240,
          onRatingChanged: (value) {},
        ),
      ));

      expect(find.byType(Slider), findsOneWidget);
      expect(find.textContaining('Good'), findsOneWidget);
    });
  });

  group('EasyStarsController', () {
    testWidgets('updates the widget rating programmatically', (tester) async {
      final controller = EasyStarsController(initialRating: 1.0);
      await tester.pumpWidget(_wrap(
        EasyStarsRating(
          controller: controller,
          initialRating: 1.0,
          starCount: 5,
        ),
      ));
      expect(find.byIcon(Icons.star), findsNWidgets(1));

      controller.update(4.0);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star), findsNWidgets(4));
      expect(find.byIcon(Icons.star_border), findsNWidgets(1));
    });

    testWidgets('tap updates the controller', (tester) async {
      final controller = EasyStarsController();
      await tester.pumpWidget(_wrap(
        EasyStarsRating(controller: controller, starCount: 5),
      ));

      await tester.tap(find.byIcon(Icons.star_border).at(2));
      await tester.pumpAndSettle();

      expect(controller.rating, 3.0);
    });

    testWidgets('clear resets to zero', (tester) async {
      final controller = EasyStarsController(initialRating: 3.0);
      await tester.pumpWidget(_wrap(
        EasyStarsRating(controller: controller, starCount: 5),
      ));

      controller.clear();
      await tester.pumpAndSettle();

      expect(controller.rating, 0.0);
      expect(find.byIcon(Icons.star_border), findsNWidgets(5));
    });
  });

  group('EasyRatingBadge', () {
    testWidgets('renders rating value', (tester) async {
      await tester.pumpWidget(_wrap(const EasyRatingBadge(rating: 4.2)));

      expect(find.byType(EasyRatingBadge), findsOneWidget);
      expect(find.text('4.2'), findsOneWidget);
      expect(find.byIcon(Icons.star_rounded), findsOneWidget);
      expect(find.textContaining('('), findsNothing);
    });

    testWidgets('renders optional ratings count', (tester) async {
      await tester.pumpWidget(_wrap(
        const EasyRatingBadge(rating: 3.7, count: 89),
      ));

      expect(find.text('3.7'), findsOneWidget);
      expect(find.text('(89)'), findsOneWidget);
    });
  });

  group('EasyReviewSummary', () {
    testWidgets('renders overall rating and breakdown', (tester) async {
      await tester.pumpWidget(_wrap(
        EasyReviewSummary(
          overallRating: 4.2,
          totalRatings: 156,
          ratingBreakdown: const {5: 89, 4: 35, 3: 18, 2: 8, 1: 6},
          showRatingCounts: true,
        ),
      ));

      expect(find.byType(EasyReviewSummary), findsOneWidget);
      expect(find.text('4.2'), findsOneWidget);
      expect(find.text('156 Ratings'), findsOneWidget);
    });

    testWidgets('renders singular rating label', (tester) async {
      await tester.pumpWidget(_wrap(
        EasyReviewSummary(
          overallRating: 5.0,
          totalRatings: 1,
          ratingBreakdown: const {5: 1},
        ),
      ));

      expect(find.text('1 Rating'), findsOneWidget);
    });
  });
}
