import 'package:apptalk/firebase/auth_service.dart';
import 'package:apptalk/pages/home_page.dart';
import 'package:apptalk/pages/main_menu.dart';
import 'package:flutter/material.dart';

class RoleBasedHomePage extends StatelessWidget {
  const RoleBasedHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService().getUserRole(),
      builder: (context, snapshot) {

        // Check the connection state and snapshot data
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator while the future is in progress
          return const CircularProgressIndicator();

        } else if (snapshot.hasData) {
          // Cast the data to a String since we expect a user role of type String
          final String? role = snapshot.data as String?;
          switch (role) {
            case 'user':
            // Return the HomePage specific to 'user'
              return  HomePage(); // Make sure to provide the HomePage with the necessary constructor arguments if any
            case 'volunteer':
            // Return the HomePage specific to 'volunteer'
              return  HomePage(); // Adjust this to a specific page for volunteers if needed
            default:
            // If the role is not recognized, return a default HomePage or an error page
              return  HomePage(); // Adjust this to a specific error page or a generic dashboard if needed
          }
        }
        else {
          // If there's no data (e.g., the user might not be logged in), return the MainMenu
          return const MainMenu();
        }
      },
    );
  }
}
