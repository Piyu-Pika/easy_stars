import 'package:flutter/material.dart';
import 'package:easy_stars/easy_stars.dart';

void main() {
  runApp(EasyStarsExampleApp());
}

class EasyStarsExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Stars Complete Example',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EasyStarsDemo(),
    );
  }
}

class EasyStarsDemo extends StatefulWidget {
  @override
  _EasyStarsDemoState createState() => _EasyStarsDemoState();
}

class _EasyStarsDemoState extends State<EasyStarsDemo> {
  double _basicRating = 3.0;
  double _halfRating = 2.5;
  double _animatedRating = 4.0;
  double _customRating = 3.5;
  double _readOnlyRating = 4.2;
  double _circularRating = 3.0;
  double _gridRating = 2.8;
  double _waveRating = 3.7;
  double _spiralRating = 4.1;
  double _gradientRating = 3.3;
  double _dragRating = 2.9;
  double _multiShapeRating = 3.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy Stars - Complete Examples'),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.amber.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection('Basic Rating', _buildBasicExamples()),
              _buildSection('Animation Examples', _buildAnimationExamples()),
              _buildSection('Arrangements', _buildArrangementExamples()),
              _buildSection('Custom Shapes & Colors', _buildCustomExamples()),
              _buildSection('Interactive Features', _buildInteractiveExamples()),
              _buildSection('Advanced Features', _buildAdvancedExamples()),
              _buildSection('Emoji Rating', _buildEmojiExamples()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
            SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildBasicExamples() {
    return Column(
      children: [
        _buildExample(
          'Basic 5-Star Rating',
          EasyStarsRating(
            initialRating: _basicRating,
            starCount: 5,
            starSize: 30,
            onRatingChanged: (rating) {
              setState(() {
                _basicRating = rating;
              });
            },
          ),
          'Rating: ${_basicRating.toStringAsFixed(1)}',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Half-Star Rating',
          EasyStarsRating(
            initialRating: _halfRating,
            starCount: 5,
            starSize: 28,
            allowHalfRating: true,
            filledColor: Colors.orange,
            emptyColor: Colors.grey.shade300,
            onRatingChanged: (rating) {
              setState(() {
                _halfRating = rating;
              });
            },
          ),
          'Rating: ${_halfRating.toStringAsFixed(1)}',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Read-Only Display',
          EasyStarsDisplay(
            initialRating: _readOnlyRating,
            starCount: 5,
            starSize: 26,
            readOnly: true,
            showRatingText: true,
            filledColor: Colors.green,
            emptyColor: Colors.grey.shade400,
          ),
          'Fixed rating display',
        ),
      ],
    );
  }

  Widget _buildAnimationExamples() {
    return Column(
      children: [
        _buildExample(
          'Scale Animation',
          EasyStarsRating(
            initialRating: _animatedRating,
            starCount: 5,
            starSize: 32,
            animationConfig: StarAnimationConfig.scale,
            filledColor: Colors.purple,
            onRatingChanged: (rating) {
              setState(() {
                _animatedRating = rating;
              });
            },
          ),
          'Rating: ${_animatedRating.toStringAsFixed(1)}',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Bounce Animation',
          EasyStarsRating(
            initialRating: 3.0,
            starCount: 5,
            starSize: 30,
            animationConfig: StarAnimationConfig.bounce,
            filledColor: Colors.blue,
            onRatingChanged: (rating) {},
          ),
          'Tap to see bounce effect',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Rotation Animation',
          EasyStarsRating(
            initialRating: 4.0,
            starCount: 5,
            starSize: 28,
            animationConfig: StarAnimationConfig.rotate,
            filledColor: Colors.red,
            onRatingChanged: (rating) {},
          ),
          'Stars rotate on interaction',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Pulse Animation',
          EasyStarsRating(
            initialRating: 3.5,
            starCount: 5,
            starSize: 26,
            animationConfig: StarAnimationConfig.pulse,
            filledColor: Colors.pink,
            onRatingChanged: (rating) {},
          ),
          'Continuous pulse effect',
        ),
      ],
    );
  }

  Widget _buildArrangementExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Arrangement Examples',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        _buildExample(
          'Circular Arrangement',
          EasyStarsRating(
            initialRating: _circularRating,
            starCount: 6,
            starSize: 24,
            arrangement: StarArrangement.arc,
            arrangementRadius: 60,
            filledColor: Colors.teal,
            onRatingChanged: (rating) {
              setState(() {
                _circularRating = rating;
              });
            },
          ),
          'Rating: ${_circularRating.toStringAsFixed(1)}',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Grid Arrangement',
          EasyStarsRating(
            initialRating: _gridRating,
            starCount: 6,
            starSize: 28,
            arrangement: StarArrangement.grid,
            gridColumns: 3,
            spacing: 8,
            filledColor: Colors.indigo,
            onRatingChanged: (rating) {
              setState(() {
                _gridRating = rating;
              });
            },
          ),
          'Rating: ${_gridRating.toStringAsFixed(1)}',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Wave Arrangement',
          EasyStarsRating(
            initialRating: _waveRating,
            starCount: 7,
            starSize: 26,
            arrangement: StarArrangement.wave,
            waveAmplitude: 15,
            filledColor: Colors.cyan,
            onRatingChanged: (rating) {
              setState(() {
                _waveRating = rating;
              });
            },
          ),
          'Rating: ${_waveRating.toStringAsFixed(1)}',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Spiral Arrangement',
          EasyStarsRating(
            initialRating: _spiralRating,
            starCount: 8,
            starSize: 22,
            arrangement: StarArrangement.spiral,
            arrangementRadius: 50,
            filledColor: Colors.deepOrange,
            onRatingChanged: (rating) {
              setState(() {
                _spiralRating = rating;
              });
            },
          ),
          'Rating: ${_spiralRating.toStringAsFixed(1)}',
        ),
      ],
    );
  }

  Widget _buildEmojiExamples() {
    return Column(
      children: [
        _buildExample(
          'Emoji Rating',
          EasyStarsEmoji(
            initialRating: 4.5,
            
            onRatingChanged: (rating) {},
          ),
          'Use emojis as stars',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Emoji Rating with custom icons',
          EasyStarsEmojiSlider(
            initialRating: 4.5,
            onRatingChanged: (rating) {},
          ),
          'Use custom icons',
        ),
      ],
    );
  }

  Widget _buildCustomExamples() {
    return Column(
      children: [
        _buildExample(
          'Heart Shape',
          EasyStarsRating(
            initialRating: 4.0,
            starCount: 5,
            starSize: 32,
            starShape: StarShape.heart,
            filledColor: Colors.red,
            emptyColor: Colors.pink.shade100,
            onRatingChanged: (rating) {},
          ),
          'Heart-shaped rating',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Gradient Colors',
          EasyStarsRating(
            initialRating: _gradientRating,
            starCount: 5,
            starSize: 30,
            gradientColors: [Colors.yellow, Colors.orange, Colors.red],
            onRatingChanged: (rating) {
              setState(() {
                _gradientRating = rating;
              });
            },
          ),
          'Rating: ${_gradientRating.toStringAsFixed(1)}',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Custom Icons',
          EasyStarsRating(
            initialRating: _multiShapeRating,
            starCount: 5,
            starSize: 28,
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
            onRatingChanged: (rating) {
              setState(() {
                _multiShapeRating = rating;
              });
            },
          ),
          'Rating: ${_multiShapeRating.toStringAsFixed(1)}',
        ),
      ],
    );
  }

  Widget _buildInteractiveExamples() {
    return Column(
      children: [
        _buildExample(
          'Drag Interaction',
          EasyStarsRating(
            initialRating: _dragRating,
            starCount: 5,
            starSize: 32,
            dragSensitivity: DragSensitivity.high,
            animationConfig: StarAnimationConfig.scale,
            filledColor: Colors.deepPurple,
            onRatingChanged: (rating) {
              setState(() {
                _dragRating = rating;
              });
            },
          ),
          'Rating: ${_dragRating.toStringAsFixed(1)} - Drag to rate',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Clearable Rating',
          EasyStarsRating(
            initialRating: 3.0,
            starCount: 5,
            starSize: 30,
            allowClear: true,
            filledColor: Colors.brown,
            onRatingChanged: (rating) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Rating: ${rating.toStringAsFixed(1)}')),
              );
            },
          ),
          'Tap same star to clear',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Vertical Layout',
          EasyStarsRating(
            initialRating: 4.0,
            starCount: 5,
            starSize: 28,
            direction: StarDirection.vertical,
            spacing: 8,
            filledColor: Colors.lime,
            onRatingChanged: (rating) {},
          ),
          'Vertical arrangement',
        ),
      ],
    );
  }

  Widget _buildAdvancedExamples() {
    return Column(
      children: [
        _buildExample(
          'Size Variants',
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  EasyStarsRating(
                    initialRating: 3.0,
                    starCount: 3,
                    sizeVariant: StarSizeVariant.small,
                    filledColor: Colors.blue,
                    onRatingChanged: (rating) {},
                  ),
                  SizedBox(height: 4),
                  Text('Small', style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                children: [
                  EasyStarsRating(
                    initialRating: 3.0,
                    starCount: 3,
                    sizeVariant: StarSizeVariant.medium,
                    filledColor: Colors.green,
                    onRatingChanged: (rating) {},
                  ),
                  SizedBox(height: 4),
                  Text('Medium', style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                children: [
                  EasyStarsRating(
                    initialRating: 3.0,
                    starCount: 3,
                    sizeVariant: StarSizeVariant.large,
                    filledColor: Colors.red,
                    onRatingChanged: (rating) {},
                  ),
                  SizedBox(height: 4),
                  Text('Large', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          'Different size variants',
        ),
        SizedBox(height: 20),
        _buildExample(
          'With Shadow',
          EasyStarsRating(
            initialRating: 4.0,
            starCount: 5,
            starSize: 32,
            starShadow: BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(1, 1),
            ),
            filledColor: Colors.amber,
            onRatingChanged: (rating) {},
          ),
          'Stars with shadow effect',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Rotated Arrangement',
          EasyStarsRating(
            initialRating: 3.5,
            starCount: 5,
            starSize: 28,
            arrangementRotation: 0.2,
            filledColor: Colors.purple,
            onRatingChanged: (rating) {},
          ),
          'Rotated star arrangement',
        ),
        SizedBox(height: 20),
        _buildExample(
          'Arc Arrangement',
          EasyStarsRating(
            initialRating: 4.0,
            starCount: 7,
            starSize: 26,
            arrangement: StarArrangement.arc,
            arrangementRadius: 80,
            filledColor: Colors.orange,
            onRatingChanged: (rating) {},
          ),
          'Arc-shaped arrangement',
        ),
      ],
    );
  }

  Widget _buildExample(String title, Widget widget, String description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 12),
          Center(child: widget),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Custom star builder example
class CustomStarBuilder {
  static Widget buildCustomStar(int index, bool isFilled, bool isHalf) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? Colors.amber : Colors.grey.shade300,
        border: Border.all(
          color: Colors.amber.shade700,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: isFilled ? Colors.white : Colors.grey.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

// Extension for additional functionality
extension EasyStarsExtension on EasyStarsRating {
  EasyStarsRating withCustomAnimation(StarAnimationConfig config) {
    return EasyStarsRating(
      initialRating: initialRating,
      starCount: starCount,
      starSize: starSize,
      animationConfig: config,
      filledColor: filledColor,
      emptyColor: emptyColor,
      onRatingChanged: onRatingChanged,
    );
  }
}

// Example of custom animation configurations
class CustomAnimations {
  static const StarAnimationConfig bouncyScale = StarAnimationConfig(
    animationType: StarAnimation.scale,
    duration: Duration(milliseconds: 400),
    curve: Curves.bounceOut,
    scaleFactor: 1.4,
    staggerDelay: Duration(milliseconds: 100),
  );

  static const StarAnimationConfig smoothFade = StarAnimationConfig(
    animationType: StarAnimation.fade,
    duration: Duration(milliseconds: 600),
    curve: Curves.easeInOutCubic,
    fadeOpacity: 0.2,
    animateColor: true,
    colorDuration: Duration(milliseconds: 300),
  );

  static const StarAnimationConfig elasticRotation = StarAnimationConfig(
    animationType: StarAnimation.rotate,
    duration: Duration(milliseconds: 800),
    curve: Curves.elasticOut,
    rotationAngle: 0.5,
    useSpringAnimation: true,
    springStiffness: 80.0,
    springDamping: 6.0,
  );
}

// Helper class for creating themed star configurations
class StarThemes {
  static StarConfig goldTheme() {
    return StarConfig(
      filledColor: Colors.amber,
      emptyColor: Colors.grey.shade300,
      starSize: 28,
      spacing: 6,
      gradientColors: [Colors.yellow, Colors.orange],
      starShadow: BoxShadow(
        color: Colors.amber.withOpacity(0.3),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    );
  }

  static StarConfig darkTheme() {
    return StarConfig(
      filledColor: Colors.white,
      emptyColor: Colors.grey.shade700,
      starSize: 26,
      spacing: 8,
      borderColor: Colors.grey.shade400,
      borderWidth: 1,
    );
  }

  static StarConfig heartTheme() {
    return StarConfig(
      filledColor: Colors.red,
      emptyColor: Colors.pink.shade100,
      starSize: 30,
      spacing: 4,
      starShape: StarShape.heart,
      arrangement: StarArrangement.arc,
      arrangementRadius: 60,
    );
  }
}