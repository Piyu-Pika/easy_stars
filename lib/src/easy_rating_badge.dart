import 'package:flutter/material.dart';

/// A compact, theme-aware badge that shows a rating value with a star icon and
/// an optional ratings count — e.g. `★ 4.2 (156)`.
///
/// Pairs well with [EasyReviewSummary] in product pages, cards and list tiles.
///
/// ```dart
/// EasyRatingBadge(rating: 4.2)
/// EasyRatingBadge(rating: 4.2, count: 156)
/// EasyRatingBadge(
///   rating: 4.8,
///   count: 42,
///   backgroundColor: Colors.green.shade50,
///   starColor: Colors.green,
/// )
/// ```
class EasyRatingBadge extends StatelessWidget {
  /// The rating value to display (rendered with one decimal place).
  final double rating;

  /// Optional number of ratings, rendered in parentheses.
  final int? count;

  /// Size of the star icon.
  final double starSize;

  /// Icon used for the star.
  final IconData starIcon;

  /// Color of the star icon. Defaults to [Colors.amber].
  final Color? starColor;

  /// Text style for the rating value.
  final TextStyle? ratingTextStyle;

  /// Text style for the ratings count.
  final TextStyle? countTextStyle;

  /// Background color of the badge. Defaults to the theme's
  /// [ColorScheme.secondaryContainer].
  final Color? backgroundColor;

  /// Corner radius of the badge. Defaults to 12.
  final double borderRadius;

  /// Padding inside the badge.
  final EdgeInsetsGeometry padding;

  /// Outer margin around the badge.
  final EdgeInsetsGeometry? margin;

  /// Fully custom decoration. When provided it overrides [backgroundColor]
  /// and [borderRadius].
  final BoxDecoration? decoration;

  /// Horizontal gap between the icon and the texts.
  final double spacing;

  const EasyRatingBadge({
    super.key,
    required this.rating,
    this.count,
    this.starSize = 16.0,
    this.starIcon = Icons.star_rounded,
    this.starColor,
    this.ratingTextStyle,
    this.countTextStyle,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    this.margin,
    this.decoration,
    this.spacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveDecoration = decoration ??
        BoxDecoration(
          color: backgroundColor ?? theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(borderRadius),
        );

    final ratingStyle = ratingTextStyle ??
        theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold);
    final countStyle = countTextStyle ??
        theme.textTheme.labelMedium?.copyWith(
          color: theme.textTheme.bodySmall?.color,
        );

    return Container(
      margin: margin,
      padding: padding,
      decoration: effectiveDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            starIcon,
            size: starSize,
            color: starColor ?? Colors.amber,
          ),
          SizedBox(width: spacing),
          Text(rating.toStringAsFixed(1), style: ratingStyle),
          if (count != null) ...[
            SizedBox(width: spacing),
            Text('($count)', style: countStyle),
          ],
        ],
      ),
    );
  }
}
