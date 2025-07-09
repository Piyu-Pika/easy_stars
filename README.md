
# ✨ Easy Stars: Your Flutter Rating Solution! ✨

Add a touch of sparkle to your Flutter app with **Easy Stars** — the all-in-one solution for elegant and customizable star rating widgets. Whether you're looking to collect user feedback or display existing ratings, Easy Stars gives you total control over the look, feel, and behavior of your stars.

---

## ⭐ Features

* **🌟 Interactive Ratings**
  Use `EasyStarsRating` to let users submit ratings effortlessly.

* **⭐ Static Displays**
  Showcase ratings beautifully using `EasyStarsDisplay` — ideal for reviews, listings, and product cards.

* **🎨 Fully Customizable**

  * Adjust star **size**, **color**, **spacing**, and **orientation**.
  * Enable **half-star** support.
  * Choose interaction modes (tap, drag, read-only).
  * Add optional **tooltips**.

* **💫 Smooth Animations**
  Animate your stars with built-in effects:

  * Scale
  * Bounce
  * Fade
  * Rotate
  * Shake
  * Pulse

* **↕️ Flexible Layout**
  Render stars **horizontally** or **vertically**.

* **⚙️ Advanced Configuration**
  Use `StarConfig` and `StarAnimationConfig` for fine-tuned control over appearance and behavior.

---

## 🚀 Getting Started

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  easy_stars: ^1.0.0
```

Then, run:

```bash
flutter pub get
```

---

## 💡 Usage Examples

### 1. **Basic Rating Widget**

```dart
EasyStarsRating(
  initialRating: 3.5,
  onRatingChanged: (value) {
    setState(() {
      _rating = value;
    });
  },
)
```

---

### 2. **Custom Appearance with Half Stars**

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
)
```

---

### 3. **Read-Only Display with Larger Stars**

```dart
EasyStarsRating(
  initialRating: 4.0,
  starSize: 30,
  readOnly: true,
  filledColor: Colors.purple,
)
```
### 4. **Vertical Direction**

```dart
SizedBox(
  height: 200,
  child: EasyStarsRating(
    initialRating: 3.5,
    starSize: 25,
    direction: StarDirection.vertical,
    onRatingChanged: (value) {
      setState(() {
        _rating = value;
      });
    },
  ),
),
```

### 5. **Discrete Emoji Selection**

```dart
EasyStarsEmoji(
  initialRating: 3.0,
  emojiSize: 32.0,
  spacing: 8.0,
  showRatingText: true,
  animationConfig: StarAnimationConfig.bounce,
  onRatingChanged: (rating) {
    print('Rating changed to: $rating');
  },
),
```

### 6. **Smooth Emoji Slider**

```dart
EasyStarsEmojiSlider(
  initialRating: 2.5,
  emojiSize: 48.0,
  sliderWidth: 300.0,
  showRatingText: true,
  animationConfig: StarAnimationConfig.scale,
  onRatingChanged: (rating) {
    print('Rating changed to: $rating');
  },
),
```

### 7. **Custom Emojis**

```dart
EasyStarsEmoji(
  initialRating: 4.0,
  customEmojis: ['😡', '😔', '😑', '😃', '🤩'],
  showRatingText: true,
)
```



---

## 📸 Preview

![image](https://github.com/user-attachments/assets/5fe1ad61-d91c-4f5c-8bf0-23db8153d069)

---

## 📚 Additional Resources

* 🔍 Explore more in the `example/` directory.
* 🛠 Contribute or view source code on [GitHub](https://github.com/Piyu-Pika/easy_stars)
* 🐞 Found a bug or have a feature idea? [Open an issue](https://github.com/Piyu-Pika/easy_stars/issues)

---

## 🙌 Contributing

We welcome contributions! Feel free to submit PRs, report bugs, or suggest improvements.

---

## 🏁 License

MIT © 2025 [Piyu-Pika](https://github.com/Piyu-Pika)

---

Let your stars shine with **Easy Stars**! 🌟
