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
  final Widget Function(int index, bool isFilled, bool isHalf)?
      customStarBuilder;

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

  /// Star arrangement shape
  final StarArrangement arrangement;

  /// Star shape type
  final StarShape starShape;

  /// Size variant for predefined sizes
  final StarSizeVariant sizeVariant;

  /// Drag sensitivity
  final DragSensitivity dragSensitivity;

  /// Custom drag threshold
  final double customDragThreshold;

  /// Gradient colors for stars
  final List<Color>? gradientColors;

  /// Shadow configuration
  final BoxShadow? starShadow;

  /// Rotation angle for the entire star arrangement
  final double arrangementRotation;

  /// Radius for circular/arc arrangements
  final double arrangementRadius;

  /// Grid columns for grid arrangement
  final int gridColumns;

  /// Wave amplitude for wave arrangement
  final double waveAmplitude;

  /// Wave frequency for wave arrangement
  final double waveFrequency;

  /// Spiral turns for spiral arrangement
  final double spiralTurns;

  /// Different icons for each star
  final List<IconData>? customIcons;

  /// Different colors for each star
  final List<Color>? customColors;

  /// Size multiplier for each star
  final List<double>? customSizes;

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
    double? maxRating ,
    this.allowClear = false,
    this.showRatingText = false,
    this.ratingTextStyle,
    this.readOnly = false,
    this.tooltip,
    this.adaptive = false,
    this.arrangement = StarArrangement.linear,
    this.starShape = StarShape.star,
    this.sizeVariant = StarSizeVariant.medium,
    this.dragSensitivity = DragSensitivity.medium,
    this.customDragThreshold = 10.0,
    this.gradientColors,
    this.starShadow,
    this.arrangementRotation = 0.0,
    this.arrangementRadius = 50.0,
    this.gridColumns = 2,
    this.waveAmplitude = 10.0,
    this.waveFrequency = 1.0,
    this.spiralTurns = 1.0,
    this.customIcons,
    this.customColors,
    this.customSizes,
  }): maxRating = maxRating ?? starCount.toDouble();

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

  double getPredefinedSize(BuildContext context) {
    final baseSize = getEffectiveStarSize(context);
    switch (sizeVariant) {
      case StarSizeVariant.tiny:
        return baseSize * 0.5;
      case StarSizeVariant.small:
        return baseSize * 0.75;
      case StarSizeVariant.medium:
        return baseSize;
      case StarSizeVariant.large:
        return baseSize * 1.5;
      case StarSizeVariant.huge:
        return baseSize * 2.0;
      case StarSizeVariant.custom:
        return starSize;
    }
  }

  double getDragThreshold() {
    switch (dragSensitivity) {
      case DragSensitivity.low:
        return 20.0;
      case DragSensitivity.medium:
        return 10.0;
      case DragSensitivity.high:
        return 5.0;
      case DragSensitivity.custom:
        return customDragThreshold;
    }
  }

  IconData getIconForShape(StarShape shape, bool isFilled) {
  switch (shape) {
    case StarShape.star:
      return isFilled ? Icons.star : Icons.star_border;
    case StarShape.heart:
      return isFilled ? Icons.favorite : Icons.favorite_border;
    case StarShape.diamond:
      return isFilled ? Icons.diamond : Icons.diamond_outlined;
    case StarShape.circle:
      return isFilled ? Icons.circle : Icons.circle_outlined;
    case StarShape.square:
      return isFilled ? Icons.square : Icons.square_outlined;
    case StarShape.custom:
      return isFilled ? filledIcon : emptyIcon;
  }
}

  IconData getStarIcon(int index, bool isFilled, bool isHalf) {
  if (customIcons != null && index < customIcons!.length) {
    return customIcons![index];
  }

  // Use shape-specific icons
  if (isHalf && halfIcon != null) {
    return halfIcon!;
  }
  
  return getIconForShape(starShape, isFilled);
}

  Color getStarColor(int index, bool isFilled) {
    if (customColors != null && index < customColors!.length) {
      return customColors![index];
    }

    if (gradientColors != null && gradientColors!.length > 1) {
      double ratio = index / (starCount - 1);
      return Color.lerp(gradientColors!.first, gradientColors!.last, ratio) ??
          filledColor;
    }

    return isFilled ? filledColor : emptyColor;
  }

  /// Get size for specific star index
  double getStarSize(int index, BuildContext context) {
    double baseSize = getPredefinedSize(context);

    if (customSizes != null && index < customSizes!.length) {
      return baseSize * customSizes![index];
    }

    return baseSize;
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
