/// Enum for star layout direction
enum StarDirection {
  horizontal,
  vertical,
}

/// Enum for star size variants
enum StarSize {
  small,
  medium,
  large,
  adaptive,
}

/// Enum for star animation types
enum StarAnimation {
  none,
  scale,
  bounce,
  fade,
  rotate,
  shake,
  pulse,
}

/// Enum for star filling behavior
enum StarFilling {
  full,
  half,
  precise,
}

/// Enum for star alignment
enum StarAlignment {
  start,
  center,
  end,
  spaceBetween,
  spaceAround,
  spaceEvenly,
}

/// Enum for star interaction mode
enum StarInteractionMode {
  none,
  tap,
  drag,
  tapAndDrag,
}

/// Enum for star arrangement shapes
enum StarArrangement {
  linear,
  circular,
  arc,
  grid,
  wave,
  spiral,
}

/// Enum for star size variants (extended)
enum StarSizeVariant {
  tiny,
  small,
  medium,
  large,
  huge,
  custom,
}

/// Enum for drag sensitivity
enum DragSensitivity {
  low,
  medium,
  high,
  custom,
}

/// Enum for star shapes
enum StarShape {
  star,
  heart,
  diamond,
  circle,
  square,
  custom,
}

enum ButtonLayoutConfig {
  /// Buttons in a horizontal row
  row,

  /// Buttons in a vertical column
  column,

  /// Submit button only (full width)
  submitOnly,

  /// Cancel button only (full width)
  cancelOnly,

  /// Custom layout
  custom,
}
