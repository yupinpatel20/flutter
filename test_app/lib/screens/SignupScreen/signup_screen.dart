import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/screens/LoginScreen/login_screen.dart';
import 'package:test_app/screens/HomeScreen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/screens/OtpScreen/otpscreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  DateTime? _selectedDate;
  String? _selectedUserRole; // Selected user role

  // Controllers for text fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  // Flags to track whether the text fields are empty
  bool usernameEmpty = false;
  bool mobileNumberEmpty = false;
  bool passwordEmpty = false;
  bool confirmPasswordEmpty = false;
  bool otpEmpty = false;

  // Flag to track if mobile number is valid
  bool mobileNumberValid = true;
  String? verificationId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.person),
                        errorText:
                            usernameEmpty ? 'Username is required' : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: mobileNumberController,
                      decoration: InputDecoration(
                        hintText: "Mobile Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.phone),
                        errorText: mobileNumberEmpty
                            ? 'Mobile Number is required'
                            : mobileNumberValid
                                ? null
                                : 'Check the number',
                      ),
                      keyboardType: TextInputType.phone,
                      // maxLength: 10, // Limit to 10 digits
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Date of Birth",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Colors.purple.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () {
                              _selectDate(context);
                            },
                            controller: _selectedDate != null
                                ? TextEditingController(
                                    text: "${_selectedDate!.toLocal()}"
                                        .split(' ')[0],
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                          icon: _isPasswordVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        errorText:
                            passwordEmpty ? 'Password is required' : null,
                      ),
                      obscureText: !_isPasswordVisible,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                          icon: _isConfirmPasswordVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        errorText: confirmPasswordEmpty
                            ? 'Confirm Password is required'
                            : null,
                      ),
                      obscureText: !_isConfirmPasswordVisible,
                    ),
                    const SizedBox(height: 20),
                    // Dropdown Button for User Role
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.purple.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedUserRole,
                          hint: Text('Select User Role'),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedUserRole = newValue;
                            });
                          },
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          items: <String>['Donater', 'Servicer']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: _selectedUserRole != null &&
                          _selectedUserRole == 'Servicer',
                      child: TextFormField(
                        controller: otpController,
                        decoration: InputDecoration(
                          hintText: "Enter OTP",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.sms),
                          errorText: otpEmpty ? 'OTP is required' : null,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Update the flags based on text field content
                        usernameEmpty = usernameController.text.isEmpty;
                        mobileNumberEmpty =
                            mobileNumberController.text.isEmpty;
                        passwordEmpty = passwordController.text.isEmpty;
                        confirmPasswordEmpty =
                            confirmPasswordController.text.isEmpty;
                        mobileNumberValid =
                            mobileNumberController.text.length == 10;
                        otpEmpty = _selectedUserRole == 'Servicer' &&
                            otpController.text.isEmpty;
                      });

                      if (validateForm() && _selectedUserRole != null) {
                        if (_selectedUserRole == 'Servicer') {
                          // Perform OTP verification
                          _verifyPhoneNumber();
                        } else {
                          // Proceed with signup logic without OTP verification
                          _signup();
                        }
                      } else {
                        // Show an error message or prevent the signup
                        // ...
                      }
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.purple,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  bool validateForm() {
    return !usernameEmpty &&
        !mobileNumberEmpty &&
        mobileNumberValid &&
        !passwordEmpty &&
        !confirmPasswordEmpty &&
        (_selectedUserRole != null && _selectedUserRole!.isNotEmpty);
  }

  void _signup() async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'username': usernameController.text,
        'mobileNumber': mobileNumberController.text,
        'password': passwordController.text,
        'userRole': _selectedUserRole, // Add user role to Firestore
        // Add other fields as needed
      });
      print('User added to Firestore');
      // Navigate to the home screen or replace with your desired screen.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>HomeScreen()),
      );
    } catch (e) {
      print('Error adding user to Firestore: $e');
      // Handle error as needed
    }
  }

  void _verifyPhoneNumber() async {
    String phoneNumber = mobileNumberController.text.trim();
    print('Verifying phone number: $phoneNumber');
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        print('Phone number automatically verified');
        _signup();
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Phone number verification failed: ${e.message}');
        // Handle verification failure
      },
      codeSent: (String verificationId, int? resendToken) {
        print('Verification code sent to $phoneNumber');
        setState(() {
          this.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Verification code auto retrieval timed out');
        // Handle timeout
      },
    );
  }
}