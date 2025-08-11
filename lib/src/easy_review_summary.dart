import 'package:flutter/material.dart';
import 'easy_stars_display.dart';
import 'models/star_config.dart';
import 'models/star_animation_config.dart';
import 'enums/star_enums.dart';

/// A widget for displaying review summary with rating breakdown
class EasyReviewSummary extends StatelessWidget {
  /// Overall rating value
  final double overallRating;
  
  /// Total number of ratings
  final int totalRatings;
  
  /// Rating breakdown (5-star, 4-star, etc.)
  final Map<int, int> ratingBreakdown;
  
  /// Star configuration for the display
  final StarConfig? starConfig;
  
  /// Animation configuration
  final StarAnimationConfig animationConfig;
  
  /// Overall rating text style
  final TextStyle? overallRatingStyle;
  
  /// Total ratings text style
  final TextStyle? totalRatingsStyle;
  
  /// Progress bar color
  final Color progressBarColor;
  
  /// Progress bar background color
  final Color progressBarBackground;
  
  /// Progress bar height
  final double progressBarHeight;
  
  /// Progress bar border radius
  final BorderRadius? progressBarBorderRadius;
  
  /// Spacing between elements
  final double spacing;
  
  /// Whether to show the star display
  final bool showStars;
  
  /// Whether to show rating numbers (5, 4, 3, 2, 1)
  final bool showRatingNumbers;
  
  /// Whether to show rating counts
  final bool showRatingCounts;
  
  /// Whether to show percentages
  final bool showPercentages;
  
  /// Layout direction (horizontal or vertical)
  final StarDirection direction;
  
  /// Custom widget builder for rating breakdown items
  final Widget Function(int rating, int count, double percentage)? customBreakdownBuilder;
  
  /// Rating number style
  final TextStyle? ratingNumberStyle;
  
  /// Rating count style  
  final TextStyle? ratingCountStyle;
  
  /// Percentage style
  final TextStyle? percentageStyle;
  
  /// Container decoration
  final BoxDecoration? containerDecoration;
  
  /// Container padding
  final EdgeInsetsGeometry? padding;
  
  /// Container margin
  final EdgeInsetsGeometry? margin;
  
  /// Progress bar border
  final Border? progressBarBorder;
  
  /// Animation duration for progress bars
  final Duration progressAnimationDuration;
  
  /// Animation curve for progress bars
  final Curve progressAnimationCurve;
  
  /// Whether to animate progress bars
  final bool animateProgress;

  const EasyReviewSummary({
    Key? key,
    required this.overallRating,
    required this.totalRatings,
    required this.ratingBreakdown,
    this.starConfig,
    this.animationConfig = StarAnimationConfig.none,
    this.overallRatingStyle,
    this.totalRatingsStyle,
    this.progressBarColor = Colors.amber,
    this.progressBarBackground = const Color(0xFFE0E0E0),
    this.progressBarHeight = 8.0,
    this.progressBarBorderRadius,
    this.spacing = 8.0,
    this.showStars = true,
    this.showRatingNumbers = true,
    this.showRatingCounts = false,
    this.showPercentages = false,
    this.direction = StarDirection.vertical,
    this.customBreakdownBuilder,
    this.ratingNumberStyle,
    this.ratingCountStyle,
    this.percentageStyle,
    this.containerDecoration,
    this.padding,
    this.margin,
    this.progressBarBorder,
    this.progressAnimationDuration = const Duration(milliseconds: 800),
    this.progressAnimationCurve = Curves.easeInOut,
    this.animateProgress = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultStarConfig = StarConfig(
      starCount: 5,
      rating: overallRating,
      starSize: 20.0,
      filledColor: progressBarColor,
      emptyColor: progressBarBackground,
      spacing: 2.0,
      readOnly: true,
    );
    
    final effectiveStarConfig = starConfig ?? defaultStarConfig;
    
    Widget content = direction == StarDirection.horizontal
        ? _buildHorizontalLayout(context, theme, effectiveStarConfig)
        : _buildVerticalLayout(context, theme, effectiveStarConfig);
    
    if (containerDecoration != null || padding != null || margin != null) {
      content = Container(
        decoration: containerDecoration,
        padding: padding,
        margin: margin,
        child: content,
      );
    }
    
    return content;
  }
  
  Widget _buildVerticalLayout(BuildContext context, ThemeData theme, StarConfig starConfig) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOverallRating(context, theme, starConfig),
        SizedBox(height: spacing),
        _buildRatingBreakdown(context, theme),
      ],
    );
  }
  
  Widget _buildHorizontalLayout(BuildContext context, ThemeData theme, StarConfig starConfig) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildOverallRating(context, theme, starConfig),
        ),
        SizedBox(width: spacing * 2),
        Expanded(
          flex: 3,
          child: _buildRatingBreakdown(context, theme),
        ),
      ],
    );
  }
  
  Widget _buildOverallRating(BuildContext context, ThemeData theme, StarConfig starConfig) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overall rating number
        Text(
          overallRating.toStringAsFixed(1),
          style: overallRatingStyle ?? theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
        
        // Stars display
        if (showStars) ...[
          SizedBox(height: spacing / 2),
          EasyStarsDisplay(
            initialRating: overallRating,
            starCount: starConfig.starCount,
            starSize: starConfig.starSize,
            filledColor: starConfig.filledColor,
            emptyColor: starConfig.emptyColor,
            spacing: starConfig.spacing,
            readOnly: true,
            animationConfig: animationConfig,
          ),
        ],
        
        // Total ratings
        SizedBox(height: spacing / 2),
        Text(
          '$totalRatings Rating${totalRatings != 1 ? 's' : ''}',
          style: totalRatingsStyle ?? theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }
  
  Widget _buildRatingBreakdown(BuildContext context, ThemeData theme) {
    final maxCount = ratingBreakdown.values.isNotEmpty 
        ? ratingBreakdown.values.reduce((a, b) => a > b ? a : b) 
        : 1;
    
    return Column(
      children: [
        for (int rating = 5; rating >= 1; rating--)
          _buildBreakdownRow(context, theme, rating, maxCount),
      ],
    );
  }
  
  Widget _buildBreakdownRow(BuildContext context, ThemeData theme, int rating, int maxCount) {
    final count = ratingBreakdown[rating] ?? 0;
    final percentage = totalRatings > 0 ? (count / totalRatings) * 100 : 0.0;
    final progress = maxCount > 0 ? count / maxCount : 0.0;
    
    if (customBreakdownBuilder != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: spacing / 4),
        child: customBreakdownBuilder!(rating, count, percentage),
      );
    }
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing / 4),
      child: Row(
        children: [
          // Rating number
          if (showRatingNumbers) ...[
            SizedBox(
              width: 12,
              child: Text(
                '$rating',
                style: ratingNumberStyle ?? theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: spacing / 2),
          ],
          
          // Progress bar
          Expanded(
            child: Container(
              height: progressBarHeight,
              decoration: BoxDecoration(
                color: progressBarBackground,
                borderRadius: progressBarBorderRadius ?? BorderRadius.circular(progressBarHeight / 2),
                border: progressBarBorder,
              ),
              child: ClipRRect(
                borderRadius: progressBarBorderRadius ?? BorderRadius.circular(progressBarHeight / 2),
                child: animateProgress
                    ? _AnimatedProgressBar(
                        progress: progress,
                        color: progressBarColor,
                        duration: progressAnimationDuration,
                        curve: progressAnimationCurve,
                      )
                    : _StaticProgressBar(
                        progress: progress,
                        color: progressBarColor,
                      ),
              ),
            ),
          ),
          
          // Count and percentage
          SizedBox(width: spacing / 2),
          if (showRatingCounts || showPercentages)
            SizedBox(
              width: 40,
              child: Text(
                showPercentages 
                    ? '${percentage.toStringAsFixed(0)}%'
                    : '$count',
                style: showPercentages 
                    ? (percentageStyle ?? theme.textTheme.bodySmall)
                    : (ratingCountStyle ?? theme.textTheme.bodySmall),
                textAlign: TextAlign.end,
              ),
            ),
        ],
      ),
    );
  }
}

class _AnimatedProgressBar extends StatefulWidget {
  final double progress;
  final Color color;
  final Duration duration;
  final Curve curve;
  
  const _AnimatedProgressBar({
    required this.progress,
    required this.color,
    required this.duration,
    required this.curve,
  });
  
  @override
  State<_AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<_AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(begin: 0.0, end: widget.progress)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    
    // Start animation after a small delay for stagger effect
    Future.delayed(Duration(milliseconds: 50), () {
      if (mounted) _controller.forward();
    });
  }
  
  @override
  void didUpdateWidget(_AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.progress,
      ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
      _controller.reset();
      _controller.forward();
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: _animation.value,
          child: Container(
            height: double.infinity,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class _StaticProgressBar extends StatelessWidget {
  final double progress;
  final Color color;
  
  const _StaticProgressBar({
    required this.progress,
    required this.color,
  });
  
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: progress,
      child: Container(
        height: double.infinity,
        color: color,
      ),
    );
  }
}
