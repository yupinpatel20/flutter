import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_app/screens/ServicerScreen/CompletesScreen.dart'; // Import Firestore

class ServicerScreen extends StatefulWidget {
  @override
  _ServicerScreenState createState() => _ServicerScreenState();
}

class _ServicerScreenState extends State<ServicerScreen> {
  String filter = 'all'; // Initial filter value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ServicerScreen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('donations').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(), // Display a loading indicator while fetching data
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'), // Display an error message if something goes wrong
                  );
                } else {
                  // Filter the data based on the selected filter
                  var filteredData = snapshot.data!.docs.where((doc) {
                    var donationData = doc.data() as Map<String, dynamic>;
                    if (filter == 'all') {
                      return true;
                    } else {
                      return donationData['status'] == filter;
                    }
                  }).toList();

                  // If data is successfully fetched, display it in your UI
                  return ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      var donationData = filteredData[index].data() as Map<String, dynamic>;
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Address: ${donationData['address']}', style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 8.0),
                              Text('Contact Number: ${donationData['contactNumber']}'),
                              SizedBox(height: 8.0),
                              Text('Food Description: ${donationData['foodDescription']}'),
                              SizedBox(height: 8.0),
                              Text('Date: ${donationData['selectedDate']}'),
                              SizedBox(height: 8.0),
                              Text('Time: ${donationData['selectedTime']}'),
                              ElevatedButton(
                                onPressed: () {
                                  // Move data to the "completed_donations" collection
                                  FirebaseFirestore.instance.collection('completed_donations').add(donationData);
                                  // Delete the document from the "donations" collection
                                  FirebaseFirestore.instance.collection('donations').doc(filteredData[index].id).delete();
                                },
                                child: Text('Complete'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filter = 'all'; // Set filter to 'all'
                    });
                  },
                  child: Text('All'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filter = 'pending'; // Set filter to 'pending'
                    });
                  },
                  child: Text('Pending'),
                ),
                ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CompletedDonationsScreen()),
    );
  },
  child: Text('Completed'),
),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
