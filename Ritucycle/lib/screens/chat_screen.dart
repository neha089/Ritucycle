import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:sdp/services/auth_service.dart'; // Import your AuthService here
import 'auth_screen.dart'; // Import AuthScreen for navigation

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  late IO.Socket _socket;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final authService = AuthService();
    bool isLoggedIn = await authService.isLoggedIn();
    if (!isLoggedIn) {
      Navigator.pushReplacementNamed(context, AuthScreen.id);
    } else {
      _socket = IO.io('http://10.10.30.100:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      _socket.connect();

      _socket.on('message', (data) {
        setState(() {
          _messages.add(data['text']);
        });
      });

      _socket.on('connect_error', (error) {
        print('Connection Error: $error');
      });
    }
  }

  @override
  void dispose() {
    _socket.disconnect();
    super.dispose();
  }

  void _sendMessage(String message) {
    if (_socket.connected) {
      _socket.emit('message', {'text': message});
      _messageController.clear();
    } else {
      print('Socket is not connected');
    }
  }

  Widget _buildMessageBubble(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.pink[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.pink[300],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
              separatorBuilder: (context, index) => SizedBox(height: 8.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.pink[200]!),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.pink[300]),
                  onPressed: () {
                    final message = _messageController.text;
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
