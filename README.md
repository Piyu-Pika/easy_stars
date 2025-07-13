# ✨ Easy Stars: Your Flutter Rating Solution! ✨

Add a touch of sparkle to your Flutter app with **Easy Stars** — the all-in-one solution for elegant and customizable rating widgets. Whether you're collecting user feedback or displaying existing ratings, Easy Stars gives you total control over look, feel, and behavior.

---

## ⭐ Features

✅ **Interactive Ratings**
✅ **Static Displays**
✅ **Half-Star & Clearable Ratings**
✅ **Custom Shapes, Colors & Icons**
✅ **Smooth Animations (Scale, Bounce, Rotate, Pulse, etc.)**
✅ **Flexible Arrangements (Grid, Arc, Spiral, Wave, Vertical)**
✅ **Emoji & Slider Ratings**
✅ **Advanced Themes and Shadows**

---

## 🚀 Getting Started

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  easy_stars: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## 💡 Example Usage

Below are rich examples showcasing the versatility of Easy Stars:

---

### 🌟 Basic 5-Star Rating

```dart
EasyStarsRating(
  initialRating: 3.0,
  onRatingChanged: (value) {
    setState(() {
      _rating = value;
    });
  },
)
```

![Basic Rating](assets/ss1.png)

---

### ⭐ Half-Star Rating

```dart
EasyStarsRating(
  initialRating: 2.5,
  allowHalfRating: true,
  filledColor: Colors.orange,
  onRatingChanged: (value) {
    setState(() {
      _rating = value;
    });
  },
)
```

![Half-Star](assets/ss2.png)

---

### ✅ Read-Only Display

```dart
EasyStarsDisplay(
  initialRating: 4.2,
  readOnly: true,
  filledColor: Colors.green,
)
```

![Read-Only](assets/ss3.png)

---

### ↕️ Vertical Layout

```dart
EasyStarsRating(
  initialRating: 4.0,
  direction: StarDirection.vertical,
)
```

![Vertical](assets/ss4.png)

---

### 💫 Animated Stars

#### Scale Animation

```dart
EasyStarsRating(
  initialRating: 5.0,
  animationConfig: StarAnimationConfig.scale,
)
```

![Scale Animation](assets/ss2.png)

---

#### Bounce Animation

```dart
EasyStarsRating(
  initialRating: 4.0,
  animationConfig: StarAnimationConfig.bounce,
)
```

![Bounce Animation](assets/ss2.png)

---

### 🎨 Custom Shapes & Icons

#### Heart Shape

```dart
EasyStarsRating(
  initialRating: 3.0,
  starShape: StarShape.heart,
  filledColor: Colors.red,
)
```

![Heart](assets/ss4.png)

---

#### Custom Icons

```dart
EasyStarsRating(
  initialRating: 2.0,
  customIcons: [
    Icons.favorite,
    Icons.star,
    Icons.thumb_up,
    Icons.mood,
    Icons.emoji_events,
  ],
  customColors: [
    Colors.red,
    Colors.amber,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ],
)
```

![Custom Icons](assets/ss5.png)

---

### 🌀 Arrangements

#### Arc Arrangement

```dart
EasyStarsRating(
  initialRating: 4.0,
  arrangement: StarArrangement.arc,
  arrangementRadius: 80,
)
```

![Arc](assets/ss7.png)

#### Grid Arrangement

```dart
EasyStarsRating(
  initialRating: 3.0,
  arrangement: StarArrangement.grid,
  gridColumns: 3,
)
```

![Grid](assets/ss6.png)

---

### 🥳 Emoji Ratings

#### Discrete Emojis

```dart
EasyStarsEmoji(
  initialRating: 3.0,
  showRatingText: true,
)
```

![Emoji](assets/ss5.png)

---

#### Emoji Slider

```dart
EasyStarsEmojiSlider(
  initialRating: 4.5,
  showRatingText: true,
)
```

![Emoji Slider](assets/ss6.png)

---

#### Custom Emojis

```dart
EasyStarsEmoji(
  initialRating: 4.0,
  customEmojis: ['😡', '😔', '😑', '😃', '🤩'],
  showRatingText: true,
)
```

![Custom Emojis](assets/ss7.png)

---

## 📸 Full Preview

![Preview](assets/image.png)

---

## 📚 Additional Resources

🔍 Explore more in the `example/` directory
🛠 Contribute or view source on [GitHub](https://github.com/Piyu-Pika/easy_stars)
🐞 Found a bug? [Open an issue](https://github.com/Piyu-Pika/easy_stars/issues)

---

## 🙌 Contributing

Pull requests and issues are welcome!

---

## 🏁 License

MIT © 2025 [Piyu-Pika](https://github.com/Piyu-Pika)

---

**Let your stars shine with Easy Stars!** 🌟


