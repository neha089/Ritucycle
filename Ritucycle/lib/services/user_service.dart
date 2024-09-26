// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class UserService {
//   static Future<void> createUser(String userId, String name, String email, String gender, Timestamp dateOfBirth) async {
//     await FirebaseFirestore.instance.collection('Users').doc(userId).set({
//       'name': name,
//       'email': email,
//       'gender': gender,
//       'dateOfBirth': dateOfBirth,
//       'profilePictureUrl': null,
//       'cycleData': null,
//       'pcodPcosData': null,
//       'yogaProgress': null,
//       'emergencyContacts': {},
//       'motivationalQuotes': []
//     });
//   }
// }
