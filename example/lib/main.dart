import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:easy_stars/easy_stars.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Stars Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Easy Stars Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _rating1 = 3.5;
  double _rating2 = 2.0;
  double _rating3 = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Easy Stars Demo - Customizations',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            const Text('1. Basic Rating:'),
            EasyStarsRating(
              initialRating: _rating1,
              onRatingChanged: (value) {
                setState(() {
                  _rating1 = value;
                });
              },
            ),
            Text('Rating: $_rating1'),
            const SizedBox(height: 20),

            const Text('2. Half Rating, Different Colors:'),
            EasyStarsRating(
              initialRating: _rating2,
              starCount: 7,
              filledColor: Colors.green,
              emptyColor: Colors.grey.shade300,
              allowHalfRating: true,
              onRatingChanged: (value) {
                setState(() {
                  _rating2 = value;
                });
              },
            ),
            Text('Rating: $_rating2'),
            const SizedBox(height: 20),

            const Text('3. Read Only, Custom Size:'),
            EasyStarsRating(
              initialRating: _rating3,
              starSize: 30,
              readOnly: true,
              filledColor: Colors.purple,
              onRatingChanged: (value) {
                setState(() {
                  _rating3 = value;
                });
              },
            ),
            Text('Rating: $_rating3'),
            const SizedBox(height: 20),

            const Text('4. Vertical Direction:'),
            SizedBox(
              height: 200,
              child: EasyStarsRating(
                initialRating: _rating3,
                starSize: 25,
                direction: StarDirection.vertical,
                onRatingChanged: (value) {
                  setState(() {
                    _rating3 = value;
                  });
                },
              ),
            ),
            Text('Rating: $_rating3'),
            const SizedBox(height: 20),

            const Text('5. Circular Arrangement:'),
            EasyStarsRating(
              initialRating: 3.0,
              starSize: 25,
              arrangement: StarArrangement.circular,
              arrangementRadius: 40,
              onRatingChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),

            const Text('6. Heart Shape:'),
            EasyStarsRating(
              initialRating: 3.0,
              starSize: 25,
              starShape: StarShape.heart,
              filledColor: Colors.red,
              onRatingChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),

            const Text('7. Custom Icons:'),
            EasyStarsRating(
              initialRating: 3.0,
              starSize: 25,
              customIcons: const [
                Icons.sentiment_very_dissatisfied,
                Icons.sentiment_dissatisfied,
                Icons.sentiment_neutral,
                Icons.sentiment_satisfied,
                Icons.sentiment_very_satisfied,
              ],
              onRatingChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),

            const Text('8. Gradient Colors:'),
            EasyStarsRating(
              initialRating: 3.0,
              starSize: 25,
              gradientColors: const [
                Colors.purple,
                Colors.pink,
                Colors.orange,
              ],
              onRatingChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),

            const Text('9.  Arrangement.wave:'),
            EasyStarsRating(
              initialRating: 3.0,
              starSize: 25,
              arrangement: StarArrangement.wave,
              onRatingChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),

            const Text('10.  Arrangement.spiral:'),
            EasyStarsRating(
              initialRating: 3.0,
              starSize: 25,
              arrangement: StarArrangement.spiral,
              onRatingChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            const Text('11. Different sizes for each star:'),
            EasyStarsRating(
              initialRating: 3.0,
              starSize: 25,
              // Sizes: const [10, 15, 20, 25, 30],
              onRatingChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
// Discrete emoji selection
            EasyStarsEmoji(
              initialRating: 3.0,
              emojiSize: 32.0,
              spacing: 8.0,
              showRatingText: true,
              animationConfig: StarAnimationConfig.bounce,
              onRatingChanged: (rating) {
                log('Rating changed to: $rating');
              },
            ),

// Smooth emoji slider
            EasyStarsEmojiSlider(
              initialRating: 2.5,
              emojiSize: 48.0,
              sliderWidth: 300.0,
              showRatingText: true,
              animationConfig: StarAnimationConfig.scale,
              onRatingChanged: (rating) {
                log('Rating changed to: $rating');
              },
            ),

// Custom emojis
            const EasyStarsEmoji(
              initialRating: 4.0,
              customEmojis: ['😡', '😔', '😑', '😃', '🤩'],
              showRatingText: true,
            )
          ],
        ),
      ),
    );
  }
}
