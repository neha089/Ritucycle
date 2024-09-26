import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sdp/main.dart';
import 'package:sdp/screens/yoga_option_screen.dart';

class SymptomCard extends StatelessWidget {
  final List<CameraDescription> cameras;

  SymptomCard({required this.cameras});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => YogaOptionScreen(cameras: cameras),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.pink[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.self_improvement, size: 48, color: Colors.green[700]),
            SizedBox(height: 10),
            Text(
              'Cure Issues With Yoga',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Track your period and get insights.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.pink[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
