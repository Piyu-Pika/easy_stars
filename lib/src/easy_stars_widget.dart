import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'models/star_config.dart';
import 'models/star_animation_config.dart';
import 'enums/star_enums.dart';

/// Main widget for displaying and interacting with stars
class EasyStars extends StatefulWidget {
  /// Configuration for star appearance and behavior
  final StarConfig config;
  
  /// Configuration for star animations
  final StarAnimationConfig animationConfig;
  
  /// Callback when rating changes
  final ValueChanged<double>? onRatingChanged;
  
  /// Callback when star is tapped
  final ValueChanged<int>? onStarTapped;
  
  /// Callback when rating update starts
  final VoidCallback? onRatingStart;
  
  /// Callback when rating update ends
  final VoidCallback? onRatingEnd;

  const EasyStars({
    super.key,
    required this.config,
    this.animationConfig = StarAnimationConfig.none,
    this.onRatingChanged,
    this.onStarTapped,
    this.onRatingStart,
    this.onRatingEnd,
  });

  @override
  State<EasyStars> createState() => _EasyStarsState();
}

class _EasyStarsState extends State<EasyStars> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<AnimationController> _starControllers;
  late List<Animation<double>> _starAnimations;
  double _currentRating = 0.0;
  int _hoveredIndex = -1;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.config.rating;
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: widget.animationConfig.duration,
      vsync: this,
    );

    _starControllers = List.generate(
      widget.config.starCount,
      (index) => AnimationController(
        duration: widget.animationConfig.duration,
        vsync: this,
      ),
    );

    _starAnimations = _starControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: widget.animationConfig.curve),
      );
    }).toList();
  }

  @override
  void didUpdateWidget(EasyStars oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.rating != widget.config.rating) {
      _currentRating = widget.config.rating;
      if (widget.animationConfig.animateOnRatingChange) {
        _animateRatingChange();
      }
    }
  }

  void _animateRatingChange() {
    for (int i = 0; i < _starControllers.length; i++) {
      Future.delayed(
        Duration(milliseconds: i * widget.animationConfig.staggerDelay.inMilliseconds),
        () {
          if (mounted) {
            _starControllers[i].forward();
          }
        },
      );
    }
  }

  void _handleStarTap(int index) {
    if (widget.config.readOnly) return;
    
    double newRating = (index + 1).toDouble();
    
    // Handle clear rating
    if (widget.config.allowClear && _currentRating == newRating) {
      newRating = 0.0;
    }
    
    _updateRating(newRating);
    widget.onStarTapped?.call(index);
    
    if (widget.animationConfig.animateOnTap) {
      _animateStarTap(index);
    }
  }

  void _animateStarTap(int index) {
    _starControllers[index].forward().then((_) {
      if (widget.animationConfig.reverse) {
        _starControllers[index].reverse();
      }
    });
  }

  void _handleDragUpdate(DragUpdateDetails details, BoxConstraints constraints) {
    if (widget.config.readOnly) return;
    
    double localX = details.localPosition.dx;
    double localY = details.localPosition.dy;
    
    double rating = _calculateRatingFromPosition(localX, localY, constraints);
    _updateRating(rating);
  }

  double _calculateRatingFromPosition(double x, double y, BoxConstraints constraints) {
    double effectiveStarSize = widget.config.getEffectiveStarSize(context);
    
    if (widget.config.direction == StarDirection.horizontal) {
      double starWidth = effectiveStarSize + widget.config.spacing;
      double position = x / starWidth;
      return math.max(0.0, math.min(widget.config.starCount.toDouble(), position));
    } else {
      double starHeight = effectiveStarSize + widget.config.spacing;
      double position = y / starHeight;
      return math.max(0.0, math.min(widget.config.starCount.toDouble(), position));
    }
  }

  void _updateRating(double newRating) {
    if (newRating != _currentRating) {
      setState(() {
        _currentRating = newRating.clamp(widget.config.minRating, widget.config.maxRating);
      });
      widget.onRatingChanged?.call(_currentRating);
    }
  }

  Widget _buildAnimatedStar(int index, bool isFilled, bool isHalf) {
    return AnimatedBuilder(
      animation: _starAnimations[index],
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: _getTransformMatrix(index),
          child: Opacity(
            opacity: _getOpacity(index),
            child: _buildStar(index, isFilled, isHalf),
          ),
        );
      },
    );
  }

  Matrix4 _getTransformMatrix(int index) {
    double animationValue = _starAnimations[index].value;
    
    switch (widget.animationConfig.animationType) {
      case StarAnimation.scale:
        double scale = 1.0 + (widget.animationConfig.scaleFactor - 1.0) * animationValue;
        return Matrix4.identity()..scale(scale);
      
      case StarAnimation.rotate:
        double rotation = widget.animationConfig.rotationAngle * animationValue;
        return Matrix4.identity()..rotateZ(rotation);
      
      case StarAnimation.bounce:
        double bounce = -widget.animationConfig.bounceHeight * 
                       math.sin(animationValue * math.pi);
        return Matrix4.identity()..translate(0.0, bounce);
      
      case StarAnimation.shake:
        double shake = widget.animationConfig.shakeIntensity * 
                      math.sin(animationValue * math.pi * 8);
        return Matrix4.identity()..translate(shake, 0.0);
      
      case StarAnimation.pulse:
        double pulse = 1.0 + (widget.animationConfig.pulseScale - 1.0) * 
                      (0.5 + 0.5 * math.sin(animationValue * math.pi * 2));
        return Matrix4.identity()..scale(pulse);
      
      default:
        return Matrix4.identity();
    }
  }

  double _getOpacity(int index) {
    if (widget.animationConfig.animationType == StarAnimation.fade) {
      double animationValue = _starAnimations[index].value;
      return widget.animationConfig.fadeOpacity + 
             (1.0 - widget.animationConfig.fadeOpacity) * animationValue;
    }
    return 1.0;
  }

  Widget _buildStar(int index, bool isFilled, bool isHalf) {
    double effectiveStarSize = widget.config.getEffectiveStarSize(context);
    
    if (widget.config.customStarBuilder != null) {
      return widget.config.customStarBuilder!(index, isFilled, isHalf);
    }

    Color starColor = isFilled ? widget.config.filledColor : widget.config.emptyColor;
    IconData starIcon = isFilled 
        ? widget.config.filledIcon 
        : (isHalf && widget.config.halfIcon != null) 
            ? widget.config.halfIcon! 
            : widget.config.emptyIcon;

    Widget star = Icon(
      starIcon,
      size: effectiveStarSize,
      color: starColor,
    );

    if (widget.config.borderWidth > 0) {
      star = Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.config.borderColor ?? starColor,
            width: widget.config.borderWidth,
          ),
          shape: BoxShape.circle,
        ),
        child: star,
      );
    }

    return star;
  }

  bool _isStarFilled(int index) {
    switch (widget.config.filling) {
      case StarFilling.full:
        return index < _currentRating.floor();
      case StarFilling.half:
        return index < _currentRating.floor() || 
               (index == _currentRating.floor() && _currentRating % 1 >= 0.5);
      case StarFilling.precise:
        return index < _currentRating;
    }
  }

  bool _isStarHalf(int index) {
    if (widget.config.filling != StarFilling.half) return false;
    return index == _currentRating.floor() && _currentRating % 1 >= 0.5;
  }

  Widget _buildStarList() {
    List<Widget> stars = [];
    
    for (int i = 0; i < widget.config.starCount; i++) {
      bool isFilled = _isStarFilled(i);
      bool isHalf = _isStarHalf(i);
      
      Widget star = _buildAnimatedStar(i, isFilled, isHalf);
      
      if (widget.config.interactionMode != StarInteractionMode.none) {
        star = GestureDetector(
          onTap: () => _handleStarTap(i),
          child: MouseRegion(
            onEnter: (_) {
              if (widget.animationConfig.animateOnHover) {
                setState(() => _hoveredIndex = i);
              }
            },
            onExit: (_) {
              setState(() => _hoveredIndex = -1);
            },
            child: star,
          ),
        );
      }
      
      stars.add(star);
    }
    
    return widget.config.direction == StarDirection.horizontal
        ? Row(
            mainAxisAlignment: widget.config.getMainAxisAlignment(),
            children: stars.expand((star) => [
              star,
              if (star != stars.last) SizedBox(width: widget.config.spacing),
            ]).toList(),
          )
        : Column(
            mainAxisAlignment: widget.config.getMainAxisAlignment(),
            children: stars.expand((star) => [
              star,
              if (star != stars.last) SizedBox(height: widget.config.spacing),
            ]).toList(),
          );
  }

  @override
  Widget build(BuildContext context) {
    Widget starsWidget = _buildStarList();
    
    if (widget.config.interactionMode == StarInteractionMode.drag ||
        widget.config.interactionMode == StarInteractionMode.tapAndDrag) {
      starsWidget = LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanStart: (details) {
              _isDragging = true;
              widget.onRatingStart?.call();
            },
            onPanUpdate: (details) {
              if (_isDragging) {
                _handleDragUpdate(details, constraints);
              }
            },
            onPanEnd: (details) {
              _isDragging = false;
              widget.onRatingEnd?.call();
            },
            child: starsWidget,
          );
        },
      );
    }
    
    if (widget.config.showRatingText) {
      starsWidget = widget.config.direction == StarDirection.horizontal
          ? Row(
              children: [
                starsWidget,
                SizedBox(width: widget.config.spacing),
                Text(
                  _currentRating.toStringAsFixed(1),
                  style: widget.config.ratingTextStyle ?? Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
          : Column(
              children: [
                starsWidget,
                SizedBox(height: widget.config.spacing),
                Text(
                  _currentRating.toStringAsFixed(1),
                  style: widget.config.ratingTextStyle ?? Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            );
    }
    
    if (widget.config.tooltip != null) {
      starsWidget = Tooltip(
        message: widget.config.tooltip!,
        child: starsWidget,
      );
    }
    
    return starsWidget;
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (final controller in _starControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}