import 'package:flutter/material.dart';
import 'package:sdp/services/auth_service.dart'; // Adjust according to your structure
import 'chat_screen.dart'; // Import ChatScreen for navigation

class AuthScreen extends StatefulWidget {
  static const String id = 'auth_screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cycleLengthController = TextEditingController();
  final TextEditingController _periodLengthController = TextEditingController();

  bool _isLogin = true;

  void _submit() async {
    final authService = AuthService();
    if (_isLogin) {
      final token = await authService.login(
        _usernameController.text,
        _passwordController.text,
      );
      if (token != null) {
        Navigator.pushReplacementNamed(context, ChatScreen.id);
      } else {
        _showError('Invalid credentials');
      }
    } else {
      final success = await authService.register(
        _usernameController.text,
        _passwordController.text,
        _emailController.text,
        _firstNameController.text,
        _lastNameController.text,
        int.tryParse(_cycleLengthController.text) ?? 0,
        int.tryParse(_periodLengthController.text) ?? 0,
      );
      if (success) {
        _showSuccess('Registration successful! Please log in.');
        setState(() {
          _isLogin = true;
        });
      } else {
        _showError('Registration failed');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
        backgroundColor: Colors.pink[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isLogin ? 'Login' : 'Register',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.pink[800]),
                    ),
                    SizedBox(height: 20),
                    _buildTextField(_usernameController, 'Username', Icons.person),
                    SizedBox(height: 16),
                    _buildTextField(_passwordController, 'Password', Icons.lock, obscureText: true),
                    if (!_isLogin) ...[
                      SizedBox(height: 16),
                      _buildTextField(_emailController, 'Email', Icons.email),
                      SizedBox(height: 16),
                      _buildTextField(_firstNameController, 'First Name', Icons.person_add),
                      SizedBox(height: 16),
                      _buildTextField(_lastNameController, 'Last Name', Icons.person_add_alt),
                      SizedBox(height: 16),
                      _buildTextField(_cycleLengthController, 'Cycle Length (days)', Icons.calendar_today, keyboardType: TextInputType.number),
                      SizedBox(height: 16),
                      _buildTextField(_periodLengthController, 'Period Length (days)', Icons.calendar_today, keyboardType: TextInputType.number),
                    ],
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(_isLogin ? 'Login' : 'Register'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[300],
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Don\'t have an account? Register'
                          : 'Already have an account? Login'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.pink[300],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
    );
  }
}
