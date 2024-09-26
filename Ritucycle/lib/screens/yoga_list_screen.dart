import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'pose.dart';

class YogaListScreen extends StatelessWidget {
  final List<CameraDescription> cameras; // Make this field final
  final String goal;
  // static const platform = MethodChannel('com.yourapp.yoga');

  // Corrected constructor syntax
  YogaListScreen({required this.goal, required this.cameras});

  @override
  Widget build(BuildContext context) {
    final yogaPoses = [
      {
        'name': 'Pose 1',
        'image': 'assets/p1.jpeg',
        'instructions': 'Step 1: Do this...\nStep 2: Do that...',
        'benefits': 'Improves flexibility and relieves cramps.'
      },
      {
        'name': 'Pose 2',
        'image': 'assets/p2.jpg',
        'instructions': 'Step 1: Start here...\nStep 2: Finish there...',
        'benefits': 'Helps in maintaining a healthy period cycle.'
      },
      {
        'name': 'Pose 3',
        'image': 'assets/p3.jpg',
        'instructions': 'Step 1: Breathe in...\nStep 2: Stretch out...',
        'benefits': 'Aids in curing PCOD/PCOS.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          goal,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.pinkAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink[50]!, Colors.pink[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: yogaPoses.length,
          itemBuilder: (context, index) {
            final pose = yogaPoses[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    pose['image']!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  pose['name']!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.pink[800],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    pose['benefits']!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                trailing: ElevatedButton.icon(
                  icon: Icon(Icons.play_arrow),
                  label: Text('Do It'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400], // Background color
                    foregroundColor: Colors.white, // Text and icon color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    _startYogaPoseDetector(context, pose);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _startYogaPoseDetector(BuildContext context, Map<String, String> pose) async {
    var status = await Permission.camera.request();

    if (status.isGranted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Starting Yoga Pose Detector'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Pose: ${pose['name']}'),
              SizedBox(height: 10),
              Text('Instructions:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(pose['instructions']!),
              SizedBox(height: 10),
              Text('Benefits:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(pose['benefits']!),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Start Detection'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PoseDetectionScreen(imagePath: pose['image']!),
                  ),
                );
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission is required to start pose detection.')),
      );
    }
  }
}
