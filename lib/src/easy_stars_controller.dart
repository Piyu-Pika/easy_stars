import 'package:flutter/foundation.dart';

/// Controller for programmatically reading and changing the rating of an
/// [EasyStars] widget.
///
/// Attach it to a star widget via `EasyStars(controller: ...)` (or one of the
/// convenience widgets). When the user taps or drags, the controller is updated
/// automatically; calling [update], setting [rating], or calling [clear] from
/// code updates the widget.
///
/// If both a [controller] and a config rating are provided, the controller
/// takes precedence.
///
/// ```dart
/// final controller = EasyStarsController(initialRating: 3.0);
///
/// EasyStarsRating(controller: controller, starCount: 5);
///
/// // Later, from anywhere:
/// controller.update(4.5);
/// controller.clear();
/// ```
class EasyStarsController extends ChangeNotifier {
  /// Creates a controller with an optional initial rating.
  EasyStarsController({double initialRating = 0.0}) : _rating = initialRating;

  double _rating = 0.0;

  /// The current rating value.
  double get rating => _rating;

  /// Sets the rating and notifies the attached widget.
  set rating(double value) {
    if (_rating == value) return;
    _rating = value;
    notifyListeners();
  }

  /// Updates the rating (same as assigning [rating]).
  void update(double value) => rating = value;

  /// Resets the rating to zero.
  void clear() => rating = 0.0;
}
