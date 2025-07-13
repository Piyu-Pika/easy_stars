import 'package:flutter/material.dart';
import 'dart:math' as math;
// import 'models/star_config.dart';
import 'models/star_animation_config.dart';
import 'enums/star_enums.dart';

/// Emoji rating widget with discrete emoji selection
class EasyStarsEmoji extends StatefulWidget {
  /// Initial rating value (0.0 to 5.0)
  final double initialRating;

  /// Size of emojis
  final double emojiSize;

  /// Spacing between emojis
  final double spacing;

  /// Layout direction
  final StarDirection direction;

  /// Animation configuration
  final StarAnimationConfig animationConfig;

  /// Callback when rating changes
  final ValueChanged<double>? onRatingChanged;

  /// Whether to show rating text
  final bool showRatingText;

  /// Custom text style for rating display
  final TextStyle? ratingTextStyle;

  /// Whether emojis are read-only
  final bool readOnly;

  /// Tooltip text
  final String? tooltip;

  /// Custom emoji list (should have 5 emojis)
  final List<String>? customEmojis;

  const EasyStarsEmoji({
    super.key,
    required this.initialRating,
    this.emojiSize = 32.0,
    this.spacing = 8.0,
    this.direction = StarDirection.horizontal,
    this.animationConfig = StarAnimationConfig.none,
    this.onRatingChanged,
    this.showRatingText = false,
    this.ratingTextStyle,
    this.readOnly = false,
    this.tooltip,
    this.customEmojis,
  });

  @override
  State<EasyStarsEmoji> createState() => _EasyStarsEmojiState();
}

class _EasyStarsEmojiState extends State<EasyStarsEmoji>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<AnimationController> _emojiControllers;
  late List<Animation<double>> _emojiAnimations;
  double _currentRating = 0.0;
  int _hoveredIndex = -1;

  // Default emoji progression from worst to best
  static const List<String> _defaultEmojis = ['🤮', '😞', '😐', '😊', '😍'];

  // Rating descriptions
  static const List<String> _ratingDescriptions = [
    'Terrible',
    'Bad',
    'Okay',
    'Good',
    'Excellent'
  ];

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
    _setupAnimations();
  }

  List<String> get _emojis => widget.customEmojis ?? _defaultEmojis;

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: widget.animationConfig.duration,
      vsync: this,
    );

    _emojiControllers = List.generate(
      5,
      (index) => AnimationController(
        duration: widget.animationConfig.duration,
        vsync: this,
      ),
    );

    _emojiAnimations = _emojiControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller, curve: widget.animationConfig.curve),
      );
    }).toList();
  }

  void _handleEmojiTap(int index) {
    if (widget.readOnly) return;

    double newRating = (index + 1).toDouble();
    _updateRating(newRating);

    if (widget.animationConfig.animateOnTap) {
      _animateEmojiTap(index);
    }
  }

  void _animateEmojiTap(int index) {
    _emojiControllers[index].forward().then((_) {
      if (widget.animationConfig.reverse) {
        _emojiControllers[index].reverse();
      }
    });
  }

  void _updateRating(double newRating) {
    if (newRating != _currentRating) {
      setState(() {
        _currentRating = newRating.clamp(0.0, 5.0);
      });
      widget.onRatingChanged?.call(_currentRating);
    }
  }

  Widget _buildAnimatedEmoji(int index) {
    return AnimatedBuilder(
      animation: _emojiAnimations[index],
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: _getTransformMatrix(index),
          child: Opacity(
            opacity: _getOpacity(index),
            child: _buildEmoji(index),
          ),
        );
      },
    );
  }

  Matrix4 _getTransformMatrix(int index) {
    double animationValue = _emojiAnimations[index].value;

    switch (widget.animationConfig.animationType) {
      case StarAnimation.scale:
        double scale =
            1.0 + (widget.animationConfig.scaleFactor - 1.0) * animationValue;
        return Matrix4.identity()..scale(scale);

      case StarAnimation.bounce:
        double bounce = -widget.animationConfig.bounceHeight *
            math.sin(animationValue * math.pi);
        return Matrix4.identity()..translate(0.0, bounce);

      case StarAnimation.shake:
        double shake = widget.animationConfig.shakeIntensity *
            math.sin(animationValue * math.pi * 8);
        return Matrix4.identity()..translate(shake, 0.0);

      default:
        return Matrix4.identity();
    }
  }

  double _getOpacity(int index) {
    if (widget.animationConfig.animationType == StarAnimation.fade) {
      double animationValue = _emojiAnimations[index].value;
      return widget.animationConfig.fadeOpacity +
          (1.0 - widget.animationConfig.fadeOpacity) * animationValue;
    }
    return 1.0;
  }

  Widget _buildEmoji(int index) {
    bool isSelected = index < _currentRating;
    bool isHovered = _hoveredIndex == index;

    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.blue.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        border: isHovered ? Border.all(color: Colors.blue, width: 2.0) : null,
      ),
      child: Text(
        _emojis[index],
        style: TextStyle(
          fontSize: widget.emojiSize,
          color: isSelected ? null : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildEmojiList() {
    List<Widget> emojis = [];

    for (int i = 0; i < 5; i++) {
      Widget emoji = _buildAnimatedEmoji(i);

      if (!widget.readOnly) {
        emoji = GestureDetector(
          onTap: () => _handleEmojiTap(i),
          child: MouseRegion(
            onEnter: (_) {
              setState(() => _hoveredIndex = i);
            },
            onExit: (_) {
              setState(() => _hoveredIndex = -1);
            },
            child: emoji,
          ),
        );
      }

      emojis.add(emoji);
    }

    return widget.direction == StarDirection.horizontal
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: emojis
                .expand((emoji) => [
                      emoji,
                      if (emoji != emojis.last) SizedBox(width: widget.spacing),
                    ])
                .toList(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: emojis
                .expand((emoji) => [
                      emoji,
                      if (emoji != emojis.last)
                        SizedBox(height: widget.spacing),
                    ])
                .toList(),
          );
  }

  @override
  Widget build(BuildContext context) {
    Widget emojiWidget = _buildEmojiList();

    if (widget.showRatingText) {
      String ratingText = _currentRating > 0
          ? '${_ratingDescriptions[(_currentRating - 1).floor()]} (${_currentRating.toStringAsFixed(1)})'
          : 'No rating';

      emojiWidget = widget.direction == StarDirection.horizontal
          ? Column(
              children: [
                emojiWidget,
                SizedBox(height: widget.spacing),
                Text(
                  ratingText,
                  style: widget.ratingTextStyle ??
                      Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
          : Row(
              children: [
                emojiWidget,
                SizedBox(width: widget.spacing),
                Text(
                  ratingText,
                  style: widget.ratingTextStyle ??
                      Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            );
    }

    if (widget.tooltip != null) {
      emojiWidget = Tooltip(
        message: widget.tooltip!,
        child: emojiWidget,
      );
    }

    return emojiWidget;
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (final controller in _emojiControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

/// Emoji rating widget with slider and smooth transitions
class EasyStarsEmojiSlider extends StatefulWidget {
  /// Initial rating value (0.0 to 5.0)
  final double initialRating;

  /// Size of the main emoji
  final double emojiSize;

  /// Width of the slider
  final double sliderWidth;

  /// Animation configuration
  final StarAnimationConfig animationConfig;

  /// Callback when rating changes
  final ValueChanged<double>? onRatingChanged;

  /// Whether to show rating text
  final bool showRatingText;

  /// Custom text style for rating display
  final TextStyle? ratingTextStyle;

  /// Whether slider is read-only
  final bool readOnly;

  /// Tooltip text
  final String? tooltip;

  /// Custom emoji list (should have 5 emojis)
  final List<String>? customEmojis;

  /// Slider color
  final Color? sliderColor;

  const EasyStarsEmojiSlider({
    super.key,
    required this.initialRating,
    this.emojiSize = 48.0,
    this.sliderWidth = 300.0,
    this.animationConfig = StarAnimationConfig.none,
    this.onRatingChanged,
    this.showRatingText = true,
    this.ratingTextStyle,
    this.readOnly = false,
    this.tooltip,
    this.customEmojis,
    this.sliderColor,
  });

  @override
  State<EasyStarsEmojiSlider> createState() => _EasyStarsEmojiSliderState();
}

class _EasyStarsEmojiSliderState extends State<EasyStarsEmojiSlider>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  double _currentRating = 0.0;

  // Default emoji progression from worst to best
  static const List<String> _defaultEmojis = ['🤮', '😞', '😐', '😊', '😍'];

  // Rating descriptions
  static const List<String> _ratingDescriptions = [
    'Terrible',
    'Bad',
    'Okay',
    'Good',
    'Excellent'
  ];

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
    _setupAnimations();
  }

  List<String> get _emojis => widget.customEmojis ?? _defaultEmojis;

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: widget.animationConfig.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.animationConfig.scaleFactor,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationConfig.curve,
    ));
  }

  void _updateRating(double newRating) {
    if (newRating != _currentRating) {
      setState(() {
        _currentRating = newRating.clamp(0.0, 5.0);
      });
      widget.onRatingChanged?.call(_currentRating);

      if (widget.animationConfig.animateOnRatingChange) {
        _animationController.forward().then((_) {
          if (widget.animationConfig.reverse) {
            _animationController.reverse();
          }
        });
      }
    }
  }

  String _getCurrentEmoji() {
    if (_currentRating <= 0) return _emojis[0];
    if (_currentRating >= 5) return _emojis[4];

    // Fix: Ensure we don't go below 0 or above 4 for array indexing
    // Map rating from 0-5 to 0-4 index range
    double normalizedRating = (_currentRating / 5.0) * 4.0;
    int baseIndex = normalizedRating.floor().clamp(0, 4);
    double fraction = normalizedRating - baseIndex;

    // For smooth transitions, we can show the emoji that's more prominent
    if (fraction < 0.5) {
      return _emojis[baseIndex];
    } else {
      return _emojis[math.min(baseIndex + 1, 4)];
    }
  }

  String _getCurrentDescription() {
    if (_currentRating <= 0) return 'No rating';
    if (_currentRating >= 5) return _ratingDescriptions[4];

    // Fix: Ensure index is within bounds
    int index = ((_currentRating - 1) / 4 * 4).floor().clamp(0, 4);
    return _ratingDescriptions[index];
  }

  Widget _buildEmojiDisplay() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.emojiSize + 16,
            height: widget.emojiSize + 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.1),
              border: Border.all(
                color: _getRatingColor(),
                width: 2.0,
              ),
            ),
            child: Center(
              child: Text(
                _getCurrentEmoji(),
                style: TextStyle(fontSize: widget.emojiSize),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getRatingColor() {
    if (_currentRating <= 1) return Colors.red;
    if (_currentRating <= 2) return Colors.orange;
    if (_currentRating <= 3) return Colors.yellow;
    if (_currentRating <= 4) return Colors.lightGreen;
    return Colors.green;
  }

  Widget _buildSlider() {
    return SizedBox(
      width: widget.sliderWidth,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: widget.sliderColor ?? _getRatingColor(),
          inactiveTrackColor: Colors.grey.withOpacity(0.3),
          thumbColor: widget.sliderColor ?? _getRatingColor(),
          overlayColor:
              (widget.sliderColor ?? _getRatingColor()).withOpacity(0.2),
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
        ),
        child: Slider(
          value: _currentRating,
          min: 0.0,
          max: 5.0,
          divisions: 50, // Allow fine-grained control
          onChanged: widget.readOnly ? null : _updateRating,
        ),
      ),
    );
  }

  Widget _buildEmojiIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        bool isActive = _currentRating > index;
        return Opacity(
          opacity: isActive ? 1.0 : 0.3,
          child: Text(
            _emojis[index],
            style: const TextStyle(fontSize: 16.0),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildEmojiDisplay(),
        const SizedBox(height: 16.0),
        SizedBox(
          width: widget.sliderWidth,
          child: Column(
            children: [
              _buildSlider(),
              const SizedBox(height: 8.0),
              _buildEmojiIndicators(),
            ],
          ),
        ),
        if (widget.showRatingText) ...[
          const SizedBox(height: 16.0),
          Text(
            '${_getCurrentDescription()} (${_currentRating.toStringAsFixed(1)})',
            style: widget.ratingTextStyle ??
                Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ],
    );

    if (widget.tooltip != null) {
      content = Tooltip(
        message: widget.tooltip!,
        child: content,
      );
    }

    return content;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
