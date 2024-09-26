import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../screens/chat_screen.dart';  // Import the chat screen

class ChatCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.id);  // Navigate to chat screen
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
            Icon(Icons.chat, size: 48, color: Colors.blue[700]),
            SizedBox(height: 10),
            Text(
              'Girls_Chat_Only',
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
