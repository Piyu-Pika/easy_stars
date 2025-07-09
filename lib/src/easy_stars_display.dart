import 'package:flutter/material.dart';
import 'easy_stars_widget.dart';
import 'models/star_config.dart';
import 'models/star_animation_config.dart';
import 'enums/star_enums.dart';

/// A convenient widget for interactive star rating
class EasyStarsDisplay extends StatefulWidget {
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
  final Widget Function(int index, bool isFilled, bool isHalf)? customStarBuilder;
  /// Whether to animate on rating change
  final bool animateOnRatingChange;

  const EasyStarsDisplay({
    Key? key,
    required this.initialRating,
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
    this.maxRating = 5.0,
    this.tooltip,
    this.readOnly = false,
    this.customStarBuilder,
    this.animateOnRatingChange = true,
  }) : super(key: key);

  @override
  State<EasyStarsDisplay> createState() => _EasyStarsDisplayState();
}

class _EasyStarsDisplayState extends State<EasyStarsDisplay> {
  late StarConfig _config;

  @override
  void initState() {
    super.initState();
    _config = StarConfig(
      starCount: widget.starCount,
      rating: widget.initialRating,
      starSize: widget.starSize,
      filledColor: widget.filledColor,
      emptyColor: widget.emptyColor,
      spacing: widget.spacing,
      direction: widget.direction,
      filling: widget.allowHalfRating ? StarFilling.half : StarFilling.full,
      alignment: StarAlignment.start,
      interactionMode: StarInteractionMode.tap,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return EasyStars(
      config: _config,
      animationConfig: widget.animationConfig,
      onRatingChanged: widget.onRatingChanged,
    );
  }
} 