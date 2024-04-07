import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  final String address;
  final String contactNumber;
  final String foodDescription;
  final String selectedDate;
  final String selectedTime;
  final Timestamp timestamp;

  Donation({
    required this.address,
    required this.contactNumber,
    required this.foodDescription,
    required this.selectedDate,
    required this.selectedTime,
    required this.timestamp,
  });

  factory Donation.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Donation(
      address: data['address'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      foodDescription: data['foodDescription'] ?? '',
      selectedDate: data['selectedDate'] ?? '',
      selectedTime: data['selectedTime'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Donation> _donationHistory = [];

  @override
  void initState() {
    super.initState();
    _fetchDonationHistory();
  }

  Future<void> _fetchDonationHistory() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('donations')
          .where('userId', isEqualTo: user.uid)
          .get();

      List<Donation> history = [];
      querySnapshot.docs.forEach((doc) {
        history.add(Donation.fromFirestore(doc));
      });

      setState(() {
        _donationHistory = history;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation History'),
      ),
      body: ListView.builder(
        itemCount: _donationHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_donationHistory[index].foodDescription),
            subtitle: Text('Date: ${_donationHistory[index].selectedDate}'),
            // Add more details as needed
          );
        },
      ),
    );
  }
}
