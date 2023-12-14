import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                const Text('Create New Password', style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),),
                const SizedBox(height: 10,),
                const Text ("Your new password must be different \n"
                    "from your previous password.",
                  style: TextStyle(
                    color: Color(0xFF8a929f),
                    fontSize: 15,
                  ),),
                const SizedBox(height: 20,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Current Password',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      maxLines: 1,

                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Your Current password',
                          hintStyle: const TextStyle(color: Color(0xFF6f6f6f)),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                color: Colors.black
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFf3f5f6),
                              width: 2.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'New Password',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      maxLines: 1,

                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Your New Password',
                          hintStyle: const TextStyle(color: Color(0xFF6f6f6f)),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                color: Colors.black
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFf3f5f6),
                              width: 2.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      maxLines: 1,

                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Re-type new password',
                          hintStyle: const TextStyle(color: Color(0xFF6f6f6f)),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                color: Colors.black
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFf3f5f6),
                              width: 2.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30,),

                Container(
                  child: MaterialButton(
                    onPressed: () { },
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      height: 55,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFF7b3aed)

                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: const Center(
                        child: Text(
                          "Reset Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17

                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}