import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationScreen extends StatefulWidget {
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Controllers for text fields
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Flags to track whether the text fields are empty
  bool contactNumberEmpty = false;
  bool addressEmpty = false;

  // Food options
  bool rotiSelected = false;
  bool bhakhriSelected = false;
  bool otherSelected = false;
  TextEditingController otherDescriptionController = TextEditingController();

  // Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Now'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  height: 80,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: contactNumberEmpty ? Colors.red : Colors.purple,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: contactNumberController,
                      decoration: InputDecoration(
                        labelText: 'Your Contact Number',
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: addressEmpty ? Colors.red : Colors.purple,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description of food',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: rotiSelected,
                              onChanged: (value) {
                                setState(() {
                                  rotiSelected = value!;
                                  if (value) {
                                    // Reset other options
                                    bhakhriSelected = false;
                                    otherSelected = false;
                                  }
                                });
                              },
                            ),
                            Text('Roti'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: bhakhriSelected,
                              onChanged: (value) {
                                setState(() {
                                  bhakhriSelected = value!;
                                  if (value) {
                                    // Reset other options
                                    rotiSelected = false;
                                    otherSelected = false;
                                  }
                                });
                              },
                            ),
                            Text('Bhakhri'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: otherSelected,
                              onChanged: (value) {
                                setState(() {
                                  otherSelected = value!;
                                  if (value) {
                                    // Reset other options
                                    rotiSelected = false;
                                    bhakhriSelected = false;
                                  }
                                });
                              },
                            ),
                            Text('Other'),
                            if (otherSelected)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: TextField(
                                    controller: otherDescriptionController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter other description',
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: addressEmpty ? Colors.red : Colors.purple,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: 'Your Address',
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('Available up to:'),
                        ElevatedButton(
                          child: Text('Set Date'),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                            );
                            if (picked != null) {
                              setState(() {
                                _selectedDate = picked;
                              });
                            }
                          },
                        ),
                        Text(
                          // ignore: unnecessary_null_comparison
                          'Selected Date: ${_selectedDate != null ? DateFormat('dd-MM-yyyy').format(_selectedDate) : 'Not selected'}',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('Set Time'),
                        ElevatedButton(
                          child: Text('Set Time'),
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: _selectedTime,
                            );
                            if (picked != null) {
                              setState(() {
                                _selectedTime = picked;
                              });
                            }
                          },
                        ),
                        Text(
                          // ignore: unnecessary_null_comparison
                          'Selected Time: ${_selectedTime != null ? _selectedTime.format(context) : 'Not selected'}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20.0),
        child: ElevatedButton(
          child: Text('+ Donate'),
          onPressed: () {
            setState(() {
              // Update the flags based on text field content
              contactNumberEmpty = contactNumberController.text.isEmpty;
              addressEmpty = addressController.text.isEmpty;
            });

            if (validateForm()) {
              // Proceed with donation logic
              String contactNumber = contactNumberController.text;
              String foodDescription = buildFoodDescription();
              String address = addressController.text;

              // Save data to Firestore
              saveDonationData(contactNumber, foodDescription, address);

              // Show success message and clear text fields
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Success"),
                    content: Text("Your donation has been submitted successfully."),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Clear text fields
                          contactNumberController.clear();
                          addressController.clear();
                          // Clear other description if present
                          otherDescriptionController.clear();
                          // Reset checkboxes
                          setState(() {
                            rotiSelected = false;
                            bhakhriSelected = false;
                            otherSelected = false;
                          });
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
            } else {
              // Show an error message or prevent the donation
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text("Please fill in all the required fields."),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  bool validateForm() {
    return !contactNumberEmpty && !addressEmpty && (rotiSelected || bhakhriSelected || (otherSelected && otherDescriptionController.text.isNotEmpty));
  }

  String buildFoodDescription() {
    if (rotiSelected) {
      return 'Roti';
    } else if (bhakhriSelected) {
      return 'Bhakhri';
    } else {
      return otherDescriptionController.text;
    }
  }

  void saveDonationData(String contactNumber, String foodDescription, String address) {
    // Create a map containing the data to be saved
    Map<String, dynamic> donationData = {
      'contactNumber': contactNumber,
      'foodDescription': foodDescription,
      'address': address,
      'selectedDate': DateFormat('dd-MM-yyyy').format(_selectedDate),
      'selectedTime': _selectedTime.format(context),
      'timestamp': Timestamp.now(),
    };

    // Add the data to Firestore
    firestore.collection('donations').add(donationData)
      .then((value) {
        // Data added successfully
        print('Donation data added to Firestore');
        // Optionally, you can show a success message or navigate to another screen
      })
      .catchError((error) {
        // Error occurred while adding data
        print('Error adding donation data: $error');
        // Handle error accordingly
      });
  }
}
