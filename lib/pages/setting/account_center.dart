import 'package:apptalk/pages/password/change_password.dart';
import 'package:flutter/material.dart';


class SettingPageUI extends StatefulWidget {
  const SettingPageUI({super.key});

  @override
  _SettingPageUIState createState() => _SettingPageUIState();
}

class _SettingPageUIState extends State<SettingPageUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Account",
            style: TextStyle(
                fontSize: 22)),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text(
                    "Account Center",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold))

              ],
            ),
            const Divider(height: 20, thickness: 1),
            const SizedBox(height: 10),
            buildAccountOption(
                context, "Change Password"),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title){
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context)
                => const ChangePasswordScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                title,
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600]
            )),
            const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black)
          ],
        ),
      ),
    );
  }
}