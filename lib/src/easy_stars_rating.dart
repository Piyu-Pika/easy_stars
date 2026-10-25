import 'package:flutter/material.dart';
import 'easy_stars_widget.dart';
import 'easy_stars_controller.dart';
import 'models/star_config.dart';
import 'models/star_animation_config.dart';
import 'enums/star_enums.dart';

/// A convenient widget for interactive star rating
class EasyStarsRating extends StatefulWidget {
  /// Initial rating value
  final double initialRating;

  /// Number of stars
  final int starCount;

  /// Size of stars
  final double starSize;

  /// Color of filled stars
  final Color filledColor;

  /// Color of empty stars
  final Color emptyColor;

  /// Spacing between stars
  final double spacing;

  /// Layout direction
  final StarDirection direction;

  /// Animation configuration
  final StarAnimationConfig animationConfig;

  /// Callback when rating changes
  final ValueChanged<double>? onRatingChanged;

  /// Whether to allow half ratings
  final bool allowHalfRating;

  /// Whether to allow clearing rating
  final bool allowClear;

  /// Whether to show rating text
  final bool showRatingText;

  /// Custom text style for rating display
  final TextStyle? ratingTextStyle;

  /// Minimum rating
  final double minRating;

  /// Maximum rating
  final double maxRating;

  /// Tooltip text
  final String? tooltip;

  /// Whether stars are read-only
  final bool readOnly;

  /// Custom star widget builder
  final Widget Function(int index, bool isFilled, bool isHalf)?
      customStarBuilder;

  /// Whether to animate on rating change
  final bool animateOnRatingChange;

  // Star arrangement shape
  final StarArrangement arrangement;

  /// Star shape type
  final StarShape starShape;

  /// Size variant
  final StarSizeVariant sizeVariant;

  /// Drag sensitivity
  final DragSensitivity dragSensitivity;

  /// Gradient colors
  final List<Color>? gradientColors;

  /// Star shadow
  final BoxShadow? starShadow;

  /// Arrangement rotation
  final double arrangementRotation;

  /// Arrangement radius
  final double arrangementRadius;

  /// Grid columns
  final int gridColumns;

  /// Wave amplitude
  final double waveAmplitude;

  /// Custom icons for each star
  final List<IconData>? customIcons;

  /// Custom colors for each star
  final List<Color>? customColors;

  /// Optional controller for programmatic rating updates
  final EasyStarsController? controller;

  /// Whether to trigger a light haptic pulse when the rating changes
  final bool enableHapticFeedback;

  EasyStarsRating({
    super.key,
    this.initialRating = 0.0,
    this.starCount = 5,
    this.starSize = 24.0,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
    this.spacing = 4.0,
    this.direction = StarDirection.horizontal,
    this.animationConfig = StarAnimationConfig.none,
    this.onRatingChanged,
    this.allowHalfRating = false,
    this.allowClear = false,
    this.showRatingText = false,
    this.ratingTextStyle,
    this.minRating = 0.0,
    double? maxRating,
    this.tooltip,
    this.readOnly = false,
    this.customStarBuilder,
    this.animateOnRatingChange = true,
    this.arrangement = StarArrangement.linear,
    this.starShape = StarShape.star,
    this.sizeVariant = StarSizeVariant.medium,
    this.dragSensitivity = DragSensitivity.medium,
    this.gradientColors,
    this.starShadow,
    this.arrangementRotation = 0.0,
    this.arrangementRadius = 50.0,
    this.gridColumns = 2,
    this.waveAmplitude = 10.0,
    this.customIcons,
    this.customColors,
    this.controller,
    this.enableHapticFeedback = false,
  }) : maxRating = maxRating ?? starCount.toDouble();

  @override
  State<EasyStarsRating> createState() => _EasyStarsRatingState();
}

class _EasyStarsRatingState extends State<EasyStarsRating> {
  @override
  Widget build(BuildContext context) {
    final config = StarConfig(
      starCount: widget.starCount,
      rating: widget.initialRating,
      starSize: widget.starSize,
      filledColor: widget.filledColor,
      emptyColor: widget.emptyColor,
      spacing: widget.spacing,
      direction: widget.direction,
      filling: widget.allowHalfRating ? StarFilling.half : StarFilling.full,
      alignment: StarAlignment.start,
      interactionMode: widget.readOnly
          ? StarInteractionMode.none
          : StarInteractionMode.tap,
      filledIcon: Icons.star,
      emptyIcon: Icons.star_border,
      customStarBuilder: widget.customStarBuilder,
      minRating: widget.minRating,
      maxRating: widget.maxRating,
      allowClear: widget.allowClear,
      showRatingText: widget.showRatingText,
      ratingTextStyle: widget.ratingTextStyle,
      readOnly: widget.readOnly,
      tooltip: widget.tooltip,
      arrangement: widget.arrangement,
      starShape: widget.starShape,
      sizeVariant: widget.sizeVariant,
      dragSensitivity: widget.dragSensitivity,
      gradientColors: widget.gradientColors,
      starShadow: widget.starShadow,
      arrangementRotation: widget.arrangementRotation,
      arrangementRadius: widget.arrangementRadius,
      gridColumns: widget.gridColumns,
      waveAmplitude: widget.waveAmplitude,
      customIcons: widget.customIcons,
      customColors: widget.customColors,
      enableHapticFeedback: widget.enableHapticFeedback,
    );

    return EasyStars(
      config: config,
      animationConfig: widget.animationConfig,
      controller: widget.controller,
      onRatingChanged: widget.onRatingChanged,
    );
  }
}
