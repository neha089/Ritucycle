// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';
//
// class SignInScreen extends StatelessWidget {
//   final AuthService _authService = AuthService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign In')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             User? user = await _authService.signInWithGoogle();
//             if (user != null) {
//               // Navigate to HomeScreen or save user details
//             }
//           },
//           child: Text('Sign in with Google'),
//         ),
//       ),
//     );
//   }
// }
