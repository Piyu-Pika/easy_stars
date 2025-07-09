import 'package:flutter/material.dart';
import '../enums/star_enums.dart';

/// Configuration class for star appearance and behavior
class StarConfig {
  /// Number of stars to display
  final int starCount;
  
  /// Current rating value
  final double rating;
  
  /// Size of individual stars
  final double starSize;
  
  /// Color of filled stars
  final Color filledColor;
  
  /// Color of empty stars
  final Color emptyColor;
  
  /// Color of star border
  final Color? borderColor;
  
  /// Width of star border
  final double borderWidth;
  
  /// Spacing between stars
  final double spacing;
  
  /// Direction of star layout
  final StarDirection direction;
  
  /// Star filling behavior
  final StarFilling filling;
  
  /// Star alignment
  final StarAlignment alignment;
  
  /// Whether stars are interactive
  final StarInteractionMode interactionMode;
  
  /// Icon for filled star
  final IconData filledIcon;
  
  /// Icon for empty star
  final IconData emptyIcon;
  
  /// Icon for half-filled star
  final IconData? halfIcon;
  
  /// Custom star widget builder
  final Widget Function(int index, bool isFilled, bool isHalf)? customStarBuilder;
  
  /// Minimum rating value
  final double minRating;
  
  /// Maximum rating value
  final double maxRating;
  
  /// Whether to allow clearing rating
  final bool allowClear;
  
  /// Whether to show rating text
  final bool showRatingText;
  
  /// Text style for rating display
  final TextStyle? ratingTextStyle;
  
  /// Whether rating is read-only
  final bool readOnly;
  
  /// Tooltip text for stars
  final String? tooltip;
  
  /// Whether to use adaptive sizing
  final bool adaptive;

  const StarConfig({
    this.starCount = 5,
    this.rating = 0.0,
    this.starSize = 24.0,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
    this.borderColor,
    this.borderWidth = 0.0,
    this.spacing = 4.0,
    this.direction = StarDirection.horizontal,
    this.filling = StarFilling.full,
    this.alignment = StarAlignment.start,
    this.interactionMode = StarInteractionMode.none,
    this.filledIcon = Icons.star,
    this.emptyIcon = Icons.star_border,
    this.halfIcon,
    this.customStarBuilder,
    this.minRating = 0.0,
    this.maxRating = 5.0,
    this.allowClear = false,
    this.showRatingText = false,
    this.ratingTextStyle,
    this.readOnly = false,
    this.tooltip,
    this.adaptive = false,
  });

  /// Create a copy of this config with updated values
  StarConfig copyWith({
    int? starCount,
    double? rating,
    double? starSize,
    Color? filledColor,
    Color? emptyColor,
    Color? borderColor,
    double? borderWidth,
    double? spacing,
    StarDirection? direction,
    StarFilling? filling,
    StarAlignment? alignment,
    StarInteractionMode? interactionMode,
    IconData? filledIcon,
    IconData? emptyIcon,
    IconData? halfIcon,
    Widget Function(int index, bool isFilled, bool isHalf)? customStarBuilder,
    double? minRating,
    double? maxRating,
    bool? allowClear,
    bool? showRatingText,
    TextStyle? ratingTextStyle,
    bool? readOnly,
    String? tooltip,
    bool? adaptive,
  }) {
    return StarConfig(
      starCount: starCount ?? this.starCount,
      rating: rating ?? this.rating,
      starSize: starSize ?? this.starSize,
      filledColor: filledColor ?? this.filledColor,
      emptyColor: emptyColor ?? this.emptyColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      spacing: spacing ?? this.spacing,
      direction: direction ?? this.direction,
      filling: filling ?? this.filling,
      alignment: alignment ?? this.alignment,
      interactionMode: interactionMode ?? this.interactionMode,
      filledIcon: filledIcon ?? this.filledIcon,
      emptyIcon: emptyIcon ?? this.emptyIcon,
      halfIcon: halfIcon ?? this.halfIcon,
      customStarBuilder: customStarBuilder ?? this.customStarBuilder,
      minRating: minRating ?? this.minRating,
      maxRating: maxRating ?? this.maxRating,
      allowClear: allowClear ?? this.allowClear,
      showRatingText: showRatingText ?? this.showRatingText,
      ratingTextStyle: ratingTextStyle ?? this.ratingTextStyle,
      readOnly: readOnly ?? this.readOnly,
      tooltip: tooltip ?? this.tooltip,
      adaptive: adaptive ?? this.adaptive,
    );
  }

  /// Get effective star size based on adaptive setting
  double getEffectiveStarSize(BuildContext context) {
    if (!adaptive) return starSize;
    
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    
    if (screenWidth < 600) {
      return starSize * 0.8;
    } else if (screenWidth < 900) {
      return starSize;
    } else {
      return starSize * 1.2;
    }
  }

  /// Get MainAxisAlignment from StarAlignment
  MainAxisAlignment getMainAxisAlignment() {
    switch (alignment) {
      case StarAlignment.start:
        return MainAxisAlignment.start;
      case StarAlignment.center:
        return MainAxisAlignment.center;
      case StarAlignment.end:
        return MainAxisAlignment.end;
      case StarAlignment.spaceBetween:
        return MainAxisAlignment.spaceBetween;
      case StarAlignment.spaceAround:
        return MainAxisAlignment.spaceAround;
      case StarAlignment.spaceEvenly:
        return MainAxisAlignment.spaceEvenly;
    }
  }
}