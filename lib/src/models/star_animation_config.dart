import 'package:flutter/animation.dart';
import '../enums/star_enums.dart';

/// Configuration class for star animations
class StarAnimationConfig {
  /// Type of animation to apply
  final StarAnimation animationType;
  
  /// Duration of the animation
  final Duration duration;
  
  /// Animation curve
  final Curve curve;
  
  /// Whether to animate on rating change
  final bool animateOnRatingChange;
  
  /// Whether to animate on hover (web/desktop)
  final bool animateOnHover;
  
  /// Whether to animate on tap
  final bool animateOnTap;
  
  /// Delay between star animations
  final Duration staggerDelay;
  
  /// Scale factor for scale animation
  final double scaleFactor;
  
  /// Rotation angle for rotate animation (in radians)
  final double rotationAngle;
  
  /// Opacity range for fade animation
  final double fadeOpacity;
  
  /// Bounce height for bounce animation
  final double bounceHeight;
  
  /// Shake intensity for shake animation
  final double shakeIntensity;
  
  /// Pulse scale factor for pulse animation
  final double pulseScale;
  
  /// Whether to reverse animation
  final bool reverse;
  
  /// Whether animation should repeat
  final bool repeat;

  const StarAnimationConfig({
    this.animationType = StarAnimation.none,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.animateOnRatingChange = true,
    this.animateOnHover = true,
    this.animateOnTap = true,
    this.staggerDelay = const Duration(milliseconds: 50),
    this.scaleFactor = 1.2,
    this.rotationAngle = 0.1,
    this.fadeOpacity = 0.5,
    this.bounceHeight = 5.0,
    this.shakeIntensity = 2.0,
    this.pulseScale = 1.1,
    this.reverse = false,
    this.repeat = false,
  });

  /// Create a copy of this config with updated values
  StarAnimationConfig copyWith({
    StarAnimation? animationType,
    Duration? duration,
    Curve? curve,
    bool? animateOnRatingChange,
    bool? animateOnHover,
    bool? animateOnTap,
    Duration? staggerDelay,
    double? scaleFactor,
    double? rotationAngle,
    double? fadeOpacity,
    double? bounceHeight,
    double? shakeIntensity,
    double? pulseScale,
    bool? reverse,
    bool? repeat,
  }) {
    return StarAnimationConfig(
      animationType: animationType ?? this.animationType,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      animateOnRatingChange: animateOnRatingChange ?? this.animateOnRatingChange,
      animateOnHover: animateOnHover ?? this.animateOnHover,
      animateOnTap: animateOnTap ?? this.animateOnTap,
      staggerDelay: staggerDelay ?? this.staggerDelay,
      scaleFactor: scaleFactor ?? this.scaleFactor,
      rotationAngle: rotationAngle ?? this.rotationAngle,
      fadeOpacity: fadeOpacity ?? this.fadeOpacity,
      bounceHeight: bounceHeight ?? this.bounceHeight,
      shakeIntensity: shakeIntensity ?? this.shakeIntensity,
      pulseScale: pulseScale ?? this.pulseScale,
      reverse: reverse ?? this.reverse,
      repeat: repeat ?? this.repeat,
    );
  }

  /// Predefined animation configurations
  static const StarAnimationConfig none = StarAnimationConfig(
    animationType: StarAnimation.none,
  );

  static const StarAnimationConfig scale = StarAnimationConfig(
    animationType: StarAnimation.scale,
    duration: Duration(milliseconds: 200),
    scaleFactor: 1.3,
  );

  static const StarAnimationConfig bounce = StarAnimationConfig(
    animationType: StarAnimation.bounce,
    duration: Duration(milliseconds: 400),
    curve: Curves.bounceOut,
  );

  static const StarAnimationConfig fade = StarAnimationConfig(
    animationType: StarAnimation.fade,
    duration: Duration(milliseconds: 250),
    fadeOpacity: 0.3,
  );

  static const StarAnimationConfig rotate = StarAnimationConfig(
    animationType: StarAnimation.rotate,
    duration: Duration(milliseconds: 300),
    rotationAngle: 0.15,
  );

  static const StarAnimationConfig shake = StarAnimationConfig(
    animationType: StarAnimation.shake,
    duration: Duration(milliseconds: 500),
    shakeIntensity: 3.0,
  );

  static const StarAnimationConfig pulse = StarAnimationConfig(
    animationType: StarAnimation.pulse,
    duration: Duration(milliseconds: 800),
    pulseScale: 1.15,
    repeat: true,
  );
}