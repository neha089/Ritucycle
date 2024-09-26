import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class PoseDetectionScreen extends StatefulWidget {
  final String imagePath;

  PoseDetectionScreen({required this.imagePath});

  @override
  _PoseDetectionScreenState createState() => _PoseDetectionScreenState();
}

class _PoseDetectionScreenState extends State<PoseDetectionScreen> {
  late PoseDetector poseDetector;
  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void initState() {
    super.initState();
    poseDetector = GoogleMlKit.vision.poseDetector();
    _processImage();
  }

  @override
  void dispose() {
    poseDetector.close();
    super.dispose();
  }

  Future<void> _processImage() async {
    if (isBusy) return;
    isBusy = true;
    setState(() {});

    final inputImage = await _getInputImage();
    final poses = await poseDetector.processImage(inputImage);
    if (poses.isNotEmpty) {
      // Handle the detected poses here
    }

    isBusy = false;
    setState(() {});
  }

  Future<InputImage> _getInputImage() async {
    final imageFile = File(widget.imagePath);
    final image = img.decodeImage(imageFile.readAsBytesSync());

    final directory = await getTemporaryDirectory();
    final tempFile = File('${directory.path}/temp_image.jpg');
    tempFile.writeAsBytesSync(img.encodeJpg(image!));

    return InputImage.fromFilePath(tempFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (customPaint != null)
              Container(
                color: Colors.black,
                child: CustomPaint(
                  painter: customPaint?.painter, // Correctly passing the painter
                  child: Container(),
                ),
              )
            else
              const Text('No pose detected yet'),
            ElevatedButton(
              onPressed: () async {
                await _processImage();
              },
              child: const Text('Detect Pose'),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_tts/flutter_tts.dart';  // Added for text-to-speech
// import 'dart:io';
// import 'package:image/image.dart' as img;
// import 'package:path_provider/path_provider.dart';
//
// class PoseDetectionScreen extends StatefulWidget {
//   final String imagePath;
//
//   PoseDetectionScreen({required this.imagePath});
//
//   @override
//   _PoseDetectionScreenState createState() => _PoseDetectionScreenState();
// }
//
// class _PoseDetectionScreenState extends State<PoseDetectionScreen> {
//   late PoseDetector poseDetector;
//   bool isBusy = false;
//   CustomPaint? customPaint;
//   late FlutterTts flutterTts;  // TTS instance for feedback
//
//   @override
//   void initState() {
//     super.initState();
//     poseDetector = GoogleMlKit.vision.poseDetector();
//     flutterTts = FlutterTts();  // Initialize text-to-speech
//     _processImage();
//   }
//
//   @override
//   void dispose() {
//     poseDetector.close();
//     flutterTts.stop();  // Stop text-to-speech on dispose
//     super.dispose();
//   }
//
//   Future<void> _processImage() async {
//     if (isBusy) return;
//     isBusy = true;
//     setState(() {});
//
//     final inputImage = await _getInputImage();
//     final poses = await poseDetector.processImage(inputImage);
//     if (poses.isNotEmpty) {
//       _comparePoses(poses.first);  // Compare first detected pose with predefined pose
//     }
//
//     isBusy = false;
//     setState(() {});
//   }
//
//   Future<InputImage> _getInputImage() async {
//     final imageFile = File(widget.imagePath);
//     final image = img.decodeImage(imageFile.readAsBytesSync());
//
//     final directory = await getTemporaryDirectory();
//     final tempFile = File('${directory.path}/temp_image.jpg');
//     tempFile.writeAsBytesSync(img.encodeJpg(image!));
//
//     return InputImage.fromFilePath(tempFile.path);
//   }
//
//   // Method to calculate angles between three landmarks
//   double _calculateAngle(PoseLandmark? point1, PoseLandmark? point2, PoseLandmark? point3) {
//     if (point1 == null || point2 == null || point3 == null) return 0.0;
//
//     final angle = ((point2.y - point1.y) * (point3.x - point2.x) -
//         (point2.x - point1.x) * (point3.y - point2.y)) /
//         ((point2.y - point1.y) * (point3.y - point2.y) +
//             (point2.x - point1.x) * (point3.x - point2.x));
//
//     return (angle * (180 / 3.14159)).abs();  // Convert radians to degrees
//   }
//
//   // Method to provide feedback based on pose comparison
//   void _provideFeedback(String message) async {
//     await flutterTts.speak(message);  // Use TTS to provide feedback
//   }
//
//   // Method to compare detected pose with predefined pose angles
//   void _comparePoses(Pose detectedPose) {
//     // Define the target pose angles (in degrees)
//     final predefinedPose = {
//       "leftElbow": 90,
//       "rightElbow": 90,
//     };
//
//     // Extract key landmarks
//     final leftElbow = detectedPose.landmarks[PoseLandmarkType.leftElbow];
//     final rightElbow = detectedPose.landmarks[PoseLandmarkType.rightElbow];
//     final leftShoulder = detectedPose.landmarks[PoseLandmarkType.leftShoulder];
//     final rightShoulder = detectedPose.landmarks[PoseLandmarkType.rightShoulder];
//     final leftWrist = detectedPose.landmarks[PoseLandmarkType.leftWrist];
//     final rightWrist = detectedPose.landmarks[PoseLandmarkType.rightWrist];
//
//     // Calculate the angles for elbows
//     final leftElbowAngle = _calculateAngle(leftShoulder, leftElbow, leftWrist);
//     final rightElbowAngle = _calculateAngle(rightShoulder, rightElbow, rightWrist);
//
//     // Compare detected angles with predefined angles and give feedback
//     if ((leftElbowAngle - predefinedPose["leftElbow"]!).abs() > 10) {
//       _provideFeedback("Bend your left elbow to 90 degrees.");
//     }
//     if ((rightElbowAngle - predefinedPose["rightElbow"]!).abs() > 10) {
//       _provideFeedback("Bend your right elbow to 90 degrees.");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pose Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (customPaint != null)
//               Container(
//                 color: Colors.black,
//                 child: CustomPaint(
//                   painter: customPaint?.painter,
//                   child: Container(),
//                 ),
//               )
//             else
//               const Text('No pose detected yet'),
//             ElevatedButton(
//               onPressed: () async {
//                 await _processImage();
//               },
//               child: const Text('Detect Pose'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
