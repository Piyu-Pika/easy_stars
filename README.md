
✨ **Easy Stars: Your Flutter Rating Solution!** ✨

Give your Flutter app some sparkle with Easy Stars, the ultimate package for creating beautiful and customizable star ratings! Whether you need interactive ratings or static displays, Easy Stars provides the flexibility and control you desire.

⭐ **Features** ⭐

*   **Interactive Star Ratings:** Use the `EasyStarsRating` widget to let users easily submit ratings.
*   **Static Star Displays:** Showcase ratings with the `EasyStarsDisplay` widget. Perfect for reviews and product details!
*   **Highly Customizable:**
    *   Tweak star size, color, spacing, and direction. 🎨
    *   Supports half-star ratings. 🌗
    *   Control interaction modes. 👆
    *   Add tooltips. ℹ️
*   **Animations:** Bring your stars to life with a variety of animation types! 💫 Choose from:
    *   Scale
    *   Bounce
    *   Fade
    *   Rotate
    *   Shake
    *   Pulse
*   **Layout Flexibility:** Arrange stars horizontally or vertically. ↕️
*   **Complete Configuration:**  Utilize `StarConfig` and `StarAnimationConfig` classes for deep customization. ⚙️
**Example**
![image](https://github.com/user-attachments/assets/5fe1ad61-d91c-4f5c-8bf0-23db8153d069)

🚀 **Getting Started** 🚀

Add `easy_stars` to your `pubspec.yaml` file:

```yaml
dependencies:
  easy_stars: ^1.0.0
```

Then, run `flutter pub get` in your terminal.

💡 **Usage Examples** 💡

**1. Basic Rating:**

```dart
import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  double _rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyStarsRating(
          initialRating: _rating,
          onRatingChanged: (value) {
            setState(() {
              _rating = value;
            });
          },
        ),
        Text('Rating: $_rating'),
      ],
    );
  }
}
```

**2. Customized Rating with Half Stars and Colors:**

```dart
EasyStarsRating(
  initialRating: 2.0,
  starCount: 7,
  filledColor: Colors.green,
  emptyColor: Colors.grey.shade300,
  allowHalfRating: true,
  onRatingChanged: (value) {
    setState(() {
      _rating = value;
    });
  },
),
```

**3. Read-Only Display with Custom Size:**

```dart
EasyStarsRating(
  initialRating: 4.0,
  starSize: 30,
  readOnly: true,
  filledColor: Colors.purple,
  onRatingChanged: (value) {
    setState(() {
      _rating = value;
    });
  },
),
```

📚 **Additional Information** 📚

*   Find more examples in the `example/` folder.
*   Contribute to the package on [GitHub](https://github.com/Piyu-Pika/easy_stars).
*   Report issues and suggest features on the [GitHub issues page](https://github.com/Piyu-Pika/easy_stars/issues).

We're committed to providing a high-quality package and welcome your feedback!  ✨
