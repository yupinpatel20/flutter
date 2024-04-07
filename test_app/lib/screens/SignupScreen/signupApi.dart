import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreApi {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addUser({
    required String username,
    required String mobileNumber,
    required String password,
    required String userRole,
    // Add other fields as needed
  }) async {
    try {
      await _firestore.collection('users').add({
        'username': username,
        'mobileNumber': mobileNumber,
        'password': password,
        'userRole': userRole,
        // Add other fields as needed
      });
      print('User added to Firestore');
    } catch (e) {
      print('Error adding user to Firestore: $e');
      // Handle error as needed
      throw e; // Optionally re-throw the error to handle it in the UI
    }
  }

  // Add other API functions as needed, such as adding donation data
}
