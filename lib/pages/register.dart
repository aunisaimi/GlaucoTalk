import 'package:apptalk/components/square_tile.dart';
import 'package:apptalk/pages/home_page.dart';
import 'package:apptalk/pages/login.dart';
import 'package:apptalk/pages/main_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apptalk/firebase/auth_service.dart';
import 'package:flutter/material.dart';
import 'dart:core';


class RegisterPage extends StatefulWidget {

  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {
  Color myCustomColor = const Color(0xFF00008B);
  Color myTextColor = const Color(0xF6F5F5FF);


  // text editing controllers
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //final birthdayController = TextEditingController();
  final dateController = TextEditingController();
  final usernameController = TextEditingController();


  // user register method
  void userSignUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try register user
    try {

      // Validate the email address
      if (!isValidEmail(emailController.text)) {
        showErrorMessage("Please enter a valid email address");
        return; // Don't proceed with registration if the email is invalid
      }

      // check if password entered is same
      if (passwordController.text == confirmPasswordController.text) {
        // create a new user in Firebase authentication
        UserCredential userCredential =await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // create a new document in firestore for the users
        await FirebaseFirestore.instance.collection('users')
            .doc(userCredential.user!.uid).set({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'birthday' : dateController.text,
          'username' : usernameController.text
        });

        // show success message or navigate to homepage
        // show error message
        Navigator.push(
          context,
        MaterialPageRoute(
          builder: (context) =>  HomePage(),
        ),
        );

      } else {
        showErrorMessage("The passwords do not match");
      }
      // pop loading circle before user logged in
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message ?? "An unknown error occurred");
    }
  }

  // error message
  void showErrorMessage(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Register Failed'),
          content:  Text(errorMessage),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // pop loading circle after show error message
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  bool isValidEmail(String email) {
    // Define a regular expression pattern for a valid email address
    // This pattern checks for a basic valid email format, but it's not foolproof.
    // A more comprehensive pattern can be used for stricter validation.
    final pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';

    // Create a regular expression object
    final regex = RegExp(pattern);

    // Use the regex to match the email address
    return regex.hasMatch(email);
  }



  Future<void> _selectDate() async{
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if(selected != null){
      setState(() {
        dateController.text = selected.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myCustomColor,
        appBar: AppBar(
          backgroundColor: myCustomColor, // You can set the color of AppBar
               elevation: 0, // Removes the shadow under the AppBar
              leading: IconButton(
              icon: const Icon(Icons.home, color: Colors.white), // Home Icon
                 onPressed: () {
                    Navigator.of(
                        context).push(
                        MaterialPageRoute(
                          builder: (context) => const MainMenu(), // Navigate to MainMenu
                        ));
                     },
          ),
        ),
      // safe area of the screen - guarantee visible to user
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // allign everything to the middle of the screen
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                // logo
                Image.asset("assets/logo.png",
                width: 150,
                height: 150,
                ),

               // const SizedBox(height: 50),

                // welcome back
                Text(
                  'Welcome to our app !',
                  style: TextStyle(
                    color: myTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                //name textfield
                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Name',
                      fillColor: Colors.deepPurple,
                      filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                //confirm password textfield
                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: usernameController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Username',
                      fillColor: Colors.deepPurple,
                      filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // email textfield
                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: emailController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Email',
                      fillColor: Colors.deepPurple,
                      filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                //  password textfield
                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Password',
                      fillColor: Colors.deepPurple,
                      filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                //confirm password textfield
                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: confirmPasswordController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Confirm Password',
                      fillColor: Colors.deepPurple,
                      filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),


                // bod textfield
                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: dateController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Date of Birth',
                     // prefixIcon: const Icon(Icons.calendar_month_outlined),
                      fillColor: Colors.deepPurple,
                      filled: true,
                      suffixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.white,),
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                    onTap: (){
                      _selectDate();
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // register button
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrangeAccent,
                        elevation: 10,
                        shape: const StadiumBorder()
                    ),
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(color: Color(0xF6F5F5FF), fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: (){
                      userSignUp();
                    },
                  ),
                ),

                const SizedBox(height: 15),

                // // other login method
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 1.5,
                //           color: Colors.deepOrange,
                //         ),
                //       ),
                //       Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text(
                //           'Or continue with',
                //           style: TextStyle(
                //             color: Color(0xF6F5F5FF),
                //           fontWeight: FontWeight.bold,
                //           fontSize: 20),
                //         ),
                //       ),
                //
                //       Expanded(
                //         child: Divider(
                //           thickness: 1.5,
                //           color: Colors.deepOrange,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 20),
                //
                // // google + fb login buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // google button
                //     SquareTile(
                //         onTap: () => AuthService().signInWithGoogle(),
                //         imagePath: 'lib/images/google.png'),
                //
                //     const SizedBox(width: 10.0),
                //
                //     // facebook button
                //     SquareTile(
                //         onTap: (){},
                //         imagePath: 'lib/images/facebook.png'),
                //
                //   ],
                // ),
                const SizedBox(height: 25),

                // doesn't have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?',
                      style: TextStyle(
                          color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                    ),
                    const SizedBox(width: 4),
                   TextButton(
                     child: const Text('Log In',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color: Colors.orange,
                       fontSize: 20),
                     ),
                     onPressed: (){
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => LoginPage(onTap: () { },),
                         )
                       );
                     },
                   ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}