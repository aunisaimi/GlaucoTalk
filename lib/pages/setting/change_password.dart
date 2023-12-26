
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  Color myCustomColor = const Color(0xFF00008B);
  Color myTextColor = const Color(0xF6F5F5FF);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _changePassword() async {
    String oldPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;

    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        try {
          AuthCredential credential =
          EmailAuthProvider.credential(email: user.email!, password: oldPassword);
          await user.reauthenticateWithCredential(credential);
          await user.updatePassword(newPassword);

          _showSnackBar('Password changed successfully.');

          _currentPasswordController.clear();
          _newPasswordController.clear();
          _confirmPasswordController.clear();

          // Navigate to home page after successful password change
          Navigator.pop(context); // Remove current screen from navigation stack
        } catch (e) {
          _showSnackBar('Error changing password. Please try again.');
          print('Error: $e');
        }
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myCustomColor,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          'Change Password',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(color: myTextColor),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: myCustomColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Create New Password',
                    style: TextStyle(
                      color: myTextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Your new password must be different \nfrom your previous password.",
                    style: TextStyle(
                      color: myTextColor,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Current Password',
                          style: TextStyle(
                            fontSize: 20,
                            color: myTextColor,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _currentPasswordController,
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Your Current password',
                          hintStyle: const TextStyle(color: Color(0xFF6f6f6f)),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFf3f5f6),
                              width: 2.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'New Password',
                          style: TextStyle(
                            fontSize: 20,
                            color: myTextColor,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _newPasswordController,
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Your New Password',
                          hintStyle: const TextStyle(color: Color(0xFF6f6f6f)),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFf3f5f6),
                              width: 2.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontSize: 20,
                            color: myTextColor,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Re-type new password',
                          hintStyle: const TextStyle(color: Color(0xFF6f6f6f)),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFf3f5f6),
                              width: 2.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange[900],
                          elevation: 10,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                            color: myTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _changePassword();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}