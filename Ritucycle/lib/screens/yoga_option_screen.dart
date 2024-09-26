import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'yoga_list_screen.dart';

class YogaOptionScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  YogaOptionScreen({required this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend the body behind the AppBar
      appBar: AppBar(
        title: Text('Select Yoga Goal', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // Remove the shadow under the AppBar
      ),
      body: Stack(
        children: [
          // Background image or gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink[100]!, Colors.pink[300]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // List of options
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 80.0), // Adjust padding to avoid overlapping with AppBar
            children: [
              _buildOption(context, 'Reduce Cramp Pain', Icons.favorite),
              _buildOption(context, 'Healthy Period Cycle', Icons.self_improvement),
              _buildOption(context, 'Cure PCOD/PCOS', Icons.local_hospital),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String title, IconData icon) {
    return Card(
      elevation: 8.0, // Add shadow to the cards
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)), // Rounded corners
      margin: EdgeInsets.symmetric(vertical: 10.0), // Margin between cards
      child: ListTile(
        leading: Icon(icon, color: Colors.pink[400], size: 30), // Add an icon
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.pink[800]), // Stylized text
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink[400]), // Add a trailing arrow icon
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => YogaListScreen(goal: title, cameras: cameras),
            ),
          );
        },
      ),
    );
  }
}
