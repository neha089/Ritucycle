import 'package:flutter/material.dart';

class RoutineCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Routine Details screen when tapped
        Navigator.pushNamed(context, '/routine_tracker');
      },
      child: Container(
        width: 200, // Adjust width similar to PeriodCard
        margin: EdgeInsets.all(8.0), // Same as PeriodCard
        padding: EdgeInsets.all(16.0), // Add consistent padding
        decoration: BoxDecoration(
          color: Colors.pink[100], // Keep the teal theme for RoutineCard
          borderRadius: BorderRadius.circular(12), // Same border radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Match shadow style
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 48, color: Colors.pink[700]), // Adjust size to match
            SizedBox(height: 10),
            Text(
              'Routine Tracker',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink[900], // Similar color scheme to PeriodCard
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Track your diet and health.',
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
