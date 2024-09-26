import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sdp/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(cameras: [])),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sdp/screens/signin_screen.dart';
// import 'home_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//
//     // Wait for 3 seconds, then check authentication status
//     Timer(Duration(seconds: 3), () async {
//       User? user = FirebaseAuth.instance.currentUser;
//
//       if (user == null) {
//         // User is not signed in, navigate to Google sign-in screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => SignInScreen()),
//         );
//       } else {
//         // User is signed in, navigate to HomeScreen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen(cameras: [])),
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset(
//             'assets/logo.png',
//             fit: BoxFit.cover,
//           ),
//           Positioned(
//             bottom: 100,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
