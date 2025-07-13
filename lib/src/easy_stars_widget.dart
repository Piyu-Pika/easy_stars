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
  late List<AnimationController> _hoverControllers;
  late List<Animation<double>> _starAnimations;
  late List<Animation<double>> _hoverAnimations;
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

    // Create separate hover controllers for smooth hover animations
    _hoverControllers = List.generate(
      widget.config.starCount,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 150), // Fast hover animation
        vsync: this,
      ),
    );

    _starAnimations = _starControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: widget.animationConfig.curve),
      );
    }).toList();

    _hoverAnimations = _hoverControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();
  }

  Offset _calculateStarPosition(int index, Size containerSize) {
  double effectiveSize = widget.config.getPredefinedSize(context);
  // double totalSpacing = widget.config.spacing * (widget.config.starCount - 1);
  
  switch (widget.config.arrangement) {
    case StarArrangement.linear:
      return widget.config.direction == StarDirection.horizontal
          ? Offset(index * (effectiveSize + widget.config.spacing), 0)
          : Offset(0, index * (effectiveSize + widget.config.spacing));
          
    case StarArrangement.circular:
      double angle = (2 * math.pi * index) / widget.config.starCount;
      double x = widget.config.arrangementRadius * math.cos(angle);
      double y = widget.config.arrangementRadius * math.sin(angle);
      return Offset(x, y);
      
    case StarArrangement.arc:
      double angle = (math.pi * index) / (widget.config.starCount - 1);
      double x = widget.config.arrangementRadius * math.cos(angle);
      double y = widget.config.arrangementRadius * math.sin(angle);
      return Offset(x, y);
      
    case StarArrangement.grid:
      int row = index ~/ widget.config.gridColumns;
      int col = index % widget.config.gridColumns;
      return Offset(
        col * (effectiveSize + widget.config.spacing),
        row * (effectiveSize + widget.config.spacing),
      );
      
    case StarArrangement.wave:
      double x = index * (effectiveSize + widget.config.spacing);
      double y = widget.config.waveAmplitude * 
                math.sin(widget.config.waveFrequency * index);
      return Offset(x, y);
      
    case StarArrangement.spiral:
      double angle = (2 * math.pi * widget.config.spiralTurns * index) / 
                     widget.config.starCount;
      double radius = widget.config.arrangementRadius * index / 
                     widget.config.starCount;
      double x = radius * math.cos(angle);
      double y = radius * math.sin(angle);
      return Offset(x, y);
  }
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

  void _handleStarHover(int index) {
    if (widget.config.readOnly) return;

    setState(() {
      _hoveredIndex = index;
    });

    // Animate all stars up to the hovered star
    for (int i = 0; i <= index; i++) {
      _hoverControllers[i].forward();
    }
    
    // Animate all stars after the hovered star back to normal
    for (int i = index + 1; i < _hoverControllers.length; i++) {
      _hoverControllers[i].reverse();
    }
  }

  void _handleStarExit() {
    setState(() {
      _hoveredIndex = -1;
    });

    // Animate all stars back to normal
    for (final controller in _hoverControllers) {
      controller.reverse();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details, BoxConstraints constraints) {
  if (widget.config.readOnly) return;
  
  double threshold = widget.config.getDragThreshold();
  if (details.delta.distance < threshold) return;
  
  double rating = _calculateRatingFromDrag(details, constraints);
  
  if (widget.animationConfig.animateOnDrag) {
    _animateDragFeedback(rating);
  }
  
  _updateRating(rating);
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
      animation: Listenable.merge([_starAnimations[index], _hoverAnimations[index]]),
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
    double hoverValue = _hoverAnimations[index].value;

    Matrix4 transform = Matrix4.identity();

    // Apply hover scale first
    if (widget.animationConfig.animateOnHover) {
      double hoverScale = 1.0 + (0.2 * hoverValue); // Scale up by 20% on hover
      transform.scale(hoverScale);
    }

    // Apply main animation
    switch (widget.animationConfig.animationType) {
      case StarAnimation.scale:
        double scale = 1.0 + (widget.animationConfig.scaleFactor - 1.0) * animationValue;
        transform.scale(scale);
        break;

      case StarAnimation.rotate:
        double rotation = widget.animationConfig.rotationAngle * animationValue;
        transform.rotateZ(rotation);
        break;

      case StarAnimation.bounce:
        double bounce = -widget.animationConfig.bounceHeight * 
                       math.sin(animationValue * math.pi);
        transform.translate(0.0, bounce);
        break;

      case StarAnimation.shake:
        double shake = widget.animationConfig.shakeIntensity * 
                      math.sin(animationValue * math.pi * 8);
        transform.translate(shake, 0.0);
        break;

      case StarAnimation.pulse:
        double pulse = 1.0 + (widget.animationConfig.pulseScale - 1.0) * 
                      (0.5 + 0.5 * math.sin(animationValue * math.pi * 2));
        transform.scale(pulse);
        break;

      default:
        break;
    }

    return transform;
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
  double starSize = widget.config.getStarSize(index, context);
  Color starColor = widget.config.getStarColor(index, isFilled);
  IconData starIcon = widget.config.getStarIcon(index, isFilled, isHalf);
  double hoverValue = _hoverAnimations[index].value;

  if (widget.config.customStarBuilder != null) {
    return widget.config.customStarBuilder!(index, isFilled, isHalf);
  }

  // Determine star color with hover effect
  bool isHovered = _hoveredIndex >= 0 && index <= _hoveredIndex;
  
  if (isHovered && widget.animationConfig.animateOnHover) {
    // Interpolate between empty and filled color on hover
    starColor = Color.lerp(
      widget.config.emptyColor,
      starColor,
      hoverValue,
    ) ?? starColor;
  }

  // Use enhanced star icon selection
  if (isHovered && widget.animationConfig.animateOnHover) {
    starIcon = widget.config.filledIcon;
  }

  Widget star = Icon(
    starIcon,
    size: starSize,
    color: starColor,
  );

  // Add gradient if specified
  if (widget.config.gradientColors != null && widget.config.gradientColors!.length > 1) {
    star = ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: widget.config.gradientColors!,
      ).createShader(bounds),
      child: star,
    );
  }

  // Add shadow if specified
  if (widget.config.starShadow != null) {
    star = Container(
      decoration: BoxDecoration(
        boxShadow: [widget.config.starShadow!],
      ),
      child: star,
    );
  }

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
  return _buildStarArrangement();
}

  // Widget _buildStarList() {
  //   List<Widget> stars = [];

  //   for (int i = 0; i < widget.config.starCount; i++) {
  //     bool isFilled = _isStarFilled(i);
  //     bool isHalf = _isStarHalf(i);

  //     Widget star = _buildAnimatedStar(i, isFilled, isHalf);

  //     if (widget.config.interactionMode != StarInteractionMode.none) {
  //       star = GestureDetector(
  //         onTap: () => _handleStarTap(i),
  //         child: MouseRegion(
  //           onEnter: (_) => _handleStarHover(i),
  //           onExit: (_) => _handleStarExit(),
  //           child: star,
  //         ),
  //       );
  //     }

  //     stars.add(star);
  //   }

  //   return widget.config.direction == StarDirection.horizontal
  //       ? Row(
  //           mainAxisAlignment: widget.config.getMainAxisAlignment(),
  //           children: stars.expand((star) => [
  //             star,
  //             if (star != stars.last) SizedBox(width: widget.config.spacing),
  //           ]).toList(),
  //         )
  //       : Column(
  //           mainAxisAlignment: widget.config.getMainAxisAlignment(),
  //           children: stars.expand((star) => [
  //             star,
  //             if (star != stars.last) SizedBox(height: widget.config.spacing),
  //           ]).toList(),
  //         );
  // }

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

double _calculateRatingFromDrag(DragUpdateDetails details, BoxConstraints constraints) {
  switch (widget.config.arrangement) {
    case StarArrangement.linear:
      return _calculateRatingFromPosition(
        details.localPosition.dx, 
        details.localPosition.dy, 
        constraints
      );
      
    case StarArrangement.circular:
    case StarArrangement.arc:
      double centerX = constraints.maxWidth / 2;
      double centerY = constraints.maxHeight / 2;
      double angle = math.atan2(
        details.localPosition.dy - centerY,
        details.localPosition.dx - centerX
      );
      return (angle / (2 * math.pi)) * widget.config.starCount;
      
    default:
      return _calculateRatingFromPosition(
        details.localPosition.dx, 
        details.localPosition.dy, 
        constraints
      );
  }
}
void _animateDragFeedback(double rating) {
  int starIndex = rating.floor();
  if (starIndex < _starControllers.length) {
    _starControllers[starIndex].forward().then((_) {
      if (widget.animationConfig.reverse) {
        _starControllers[starIndex].reverse();
      }
    });
  }
}


/// Build enhanced star with all features


/// Build star arrangement
Widget _buildStarArrangement() {
  if (widget.config.arrangement == StarArrangement.linear) {
    List<Widget> stars = [];

    for (int i = 0; i < widget.config.starCount; i++) {
      bool isFilled = _isStarFilled(i);
      bool isHalf = _isStarHalf(i);

      Widget star = _buildAnimatedStar(i, isFilled, isHalf);

      if (widget.config.interactionMode != StarInteractionMode.none) {
        star = GestureDetector(
          onTap: () => _handleStarTap(i),
          child: MouseRegion(
            onEnter: (_) => _handleStarHover(i),
            onExit: (_) => _handleStarExit(),
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
  
  return LayoutBuilder(
    builder: (context, constraints) {
      List<Widget> positionedStars = [];
      
      for (int i = 0; i < widget.config.starCount; i++) {
        bool isFilled = _isStarFilled(i);
        bool isHalf = _isStarHalf(i);
        
        Offset position = _calculateStarPosition(i, constraints.biggest);
        
        Widget star = _buildAnimatedStar(i, isFilled, isHalf);
        
        if (widget.config.interactionMode != StarInteractionMode.none) {
          star = GestureDetector(
            onTap: () => _handleStarTap(i),
            child: MouseRegion(
              onEnter: (_) => _handleStarHover(i),
              onExit: (_) => _handleStarExit(),
              child: star,
            ),
          );
        }
        
        positionedStars.add(
          Positioned(
            left: position.dx + constraints.maxWidth / 2,
            top: position.dy + constraints.maxHeight / 2,
            child: star,
          ),
        );
      }
      
      return Transform.rotate(
        angle: widget.config.arrangementRotation,
        child: Stack(
          children: positionedStars,
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    Widget starsWidget = _buildStarList();
    // Widget starsWidget = _buildStarArrangement();
    

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
    for (final controller in _hoverControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
