import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../components/calendar_widget.dart';
import '../widgets/period_card.dart';
import '../widgets/symptom_card.dart';
import '../widgets/tutorial_card.dart';
import '../widgets/chat_card.dart';
import '../widgets/routine_card.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  final List<CameraDescription> cameras;

  HomeScreen({required this.cameras});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DateTime> highlightedDates = [];
  List<DateTime> previousSelectedDates = [];

  void _updateHighlightedDates(DateTime selectedDate) {
    // Highlight 5 days starting from the selected date in the current month
    List<DateTime> newHighlightedDates = [];
    for (int i = 0; i < 5; i++) {
      newHighlightedDates.add(selectedDate.add(Duration(days: i)));
    }

    // Highlight the same days in the next two months
    for (int monthOffset = 1; monthOffset <= 2; monthOffset++) {
      for (int i = 0; i < 5; i++) {
        newHighlightedDates.add(DateTime(
          selectedDate.year,
          selectedDate.month + monthOffset,
          selectedDate.day + i,
        ));
      }
    }

    // Add the new highlighted dates and keep previously selected dates
    previousSelectedDates.add(selectedDate); // Keep track of the selected date
    highlightedDates = [...previousSelectedDates, ...newHighlightedDates];

    // Remove duplicates
    highlightedDates = highlightedDates.toSet().toList();

    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RituCycle - Caring for Women\'s Hygiene'),
        backgroundColor: Colors.pink[200],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CalendarWidget(highlightedDates: highlightedDates),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PeriodCard(onDateSelected: _updateHighlightedDates), // Pass callback
                  SymptomCard(cameras: widget.cameras), // Pass cameras here
                  TutorialCard(),
                  ChatCard(),
                  RoutineCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:camera/camera.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sdp/screens/signin_screen.dart';
// import '../components/calendar_widget.dart';
// import '../widgets/period_card.dart';
// import '../widgets/symptom_card.dart';
// import '../widgets/tutorial_card.dart';
// import '../widgets/chat_card.dart';
// import '../widgets/routine_card.dart';
//
// class HomeScreen extends StatefulWidget {
//   static const String id = 'home_screen'; // Add this for routing
//
//   final List<CameraDescription> cameras;
//
//   HomeScreen({required this.cameras});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error.toString()}'));
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.data == null) {
//               // If the user is not signed in, navigate to the SignIn page
//               return SignInScreen();
//             } else {
//               // If the user is signed in, show the home page
//               return _buildHomePage();
//             }
//           }
//
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
//
//   // The actual Home Screen UI
//   Widget _buildHomePage() {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('RituCycle - Caring for Women\'s Hygiene'),
//         backgroundColor: Colors.pink[200],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CalendarWidget(),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   PeriodCard(),
//                   SymptomCard(cameras: widget.cameras), // Pass cameras here
//                   TutorialCard(),
//                   ChatCard(),
//                   RoutineCard(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:camera/camera.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sdp/screens/signin_screen.dart';
// import '../components/calendar_widget.dart';
// import '../widgets/period_card.dart';
// import '../widgets/symptom_card.dart';
// import '../widgets/tutorial_card.dart';
// import '../widgets/chat_card.dart';
// import '../widgets/routine_card.dart';
//
// class HomeScreen extends StatefulWidget {
//   static const String id = 'home_screen'; // Add this for routing
//
//   final List<CameraDescription> cameras;
//
//   HomeScreen({required this.cameras});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error.toString()}'));
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.data == null) {
//               // If the user is not signed in, navigate to the SignIn page
//               return SignInScreen();
//             } else {
//               // If the user is signed in, show the home page
//               return _buildHomePage();
//             }
//           }
//
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
//
//   // The actual Home Screen UI
//   Widget _buildHomePage() {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('RituCycle - Caring for Women\'s Hygiene'),
//         backgroundColor: Colors.pink[200],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CalendarWidget(),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   PeriodCard(),
//                   SymptomCard(cameras: widget.cameras), // Pass cameras here
//                   TutorialCard(),
//                   ChatCard(),
//                   RoutineCard(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
