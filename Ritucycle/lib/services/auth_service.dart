import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final storage = FlutterSecureStorage();

  // Check if the user is logged in by reading the token from secure storage
  Future<bool> isLoggedIn() async {
    String? token = await storage.read(key: 'auth_token');
    return token != null;
  }

  // Save the token to secure storage
  Future<void> saveToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  // Logout by deleting the token from secure storage
  Future<void> logout() async {
    await storage.delete(key: 'auth_token');
  }

  // Login function to authenticate the user
  Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.3:3000/api/auth/login'), // Your server's login URL
      headers: {
        'Content-Type': 'application/json', // Set Content-Type to JSON
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String token = data['token']; // Assumes that the response contains a 'token' field
      await saveToken(token);
      return token;
    } else {
      return null; // Return null if login fails
    }
  }

  // Registration function to create a new user account
  Future<bool> register(
      String username,
      String password,
      String email,
      String firstName,
      String lastName,
      int cycleLength,
      int periodLength,
      ) async {
    final response = await http.post(
      Uri.parse('http://10.10.30.100:3000/api/auth/register'), // Your server's registration URL
      headers: {
        'Content-Type': 'application/json', // Set Content-Type to JSON
      },
      body: json.encode({
        'username': username,
        'password': password,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'cycleLength': cycleLength,
        'periodLength': periodLength,
      }),
    );

    return response.statusCode == 201; // Returns true if registration is successful
  }
}
