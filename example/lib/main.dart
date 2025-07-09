import 'package:flutter/material.dart';
import 'package:easy_stars/easy_stars.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
            const Text('Easy Stars Demo - Customizations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          ],
        ),
      ),
    );
  }
}