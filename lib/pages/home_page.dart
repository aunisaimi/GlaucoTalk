import 'package:apptalk/camera/camera.dart';
import 'package:apptalk/firebase/auth_service.dart';
import 'package:apptalk/pages/chat_page.dart';
import 'package:apptalk/pages/login.dart';
import 'package:apptalk/pages/search.dart';
import 'package:apptalk/pages/setting/Notification%20page/noti_page.dart';
import 'package:apptalk/pages/setting/account_center.dart';
import 'package:apptalk/pages/setting/help_center.dart';
import 'package:apptalk/pages/setting/theme/Apparance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:apptalk/pages/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String profilePictureUrl ='';

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthController = TextEditingController();

  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String name = "";
  String email = "";

  AuthService authService = AuthService();

  int _selectedIndex =0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  Color myCustomColor = const Color(0xFF00008B);
  Color myTextColor = const Color(0xF6F5F5FF);

  late CameraDescription? firstCamera;

  get floatingActionButton => null;

  //Function to navigate to TakePictureScreen
  void navigateToTakePictureScreen(
      BuildContext context, CameraDescription camera){

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TakePictureScreen(camera: camera)
      ),
    );

  }

  @override
  void initState() {
    super.initState();
    // Initialize firstCamera in the initState method
    _initializeFirstCamera();
    // call fetchUserData to get user data
    fetchUserData();
  }

  Future<void> _initializeFirstCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      setState(() {
        firstCamera = cameras.first;
      });
    }
    else{
      // handle the case when there is no camera available
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Camera Available'),
        ),
      );
    }
  }

  // sign user out
  void signOut(){
    FirebaseAuth.instance.signOut();
  }


  Future<void> fetchUserData() async{
    try{
      // get tje current user's ID
      final userId = FirebaseAuth.instance.currentUser!.uid;

      // fetch the user;s document from firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if(userDoc.exists){
        // Extract and set user data to the respective TextEditingController
        setState(() {
          nameController.text = userDoc['name'];
          usernameController.text = userDoc['username'];
          emailController.text = userDoc['email'];

          // set the profile pictrue URL from firestore
          profilePictureUrl = userDoc['profilePictureUrl'];
          // set other fields similarity
        });

        print("This is the profile picture url : ${profilePictureUrl}");
      }
      else{
        print("Data not exist");
      }
    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: myCustomColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black54,
          title: Text(
            'C H A T',
            style: GoogleFonts.aBeeZee(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.yellow,
              ),
            ),
          ),
          actions: [
            // Search button
            IconButton(
              onPressed: () {
                // Add your search functionality here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const SearchPage(),
                  ),
                );
              },
              icon: const Icon(Icons.search,
                size: 24,
                color: Colors.white,

              ),
            ),

            IconButton(
              onPressed: () {
                navigateToTakePictureScreen(context, firstCamera!);
              },
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,),
            ),
          ],

          bottom: const TabBar(
            labelColor: Colors.orange,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14),// Color for the selected tab's text
            unselectedLabelColor: Colors.white, // Color for unselected tabs' text
            tabs: [
              Tab(text: 'Chats'),
              Tab(text: 'Status'),
              Tab(text: 'Calls'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            Column(
              children: [
                // Display user's name and email
                Column(
                  children: [
                    // Display user's name
                    Text(
                      'Logged in as: ${nameController.text}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: myTextColor,
                      ),
                    ),
                    // Display user's email
                    Text(
                      'Email: ${emailController.text}',
                      style: TextStyle(
                          fontSize: 16,
                          color: myTextColor),
                    ),
                  ],
                ),
                Expanded(
                  child: _buildUserList(),
                )
              ],
            ),
            // Content for status tab
            const Center(
              child: Text('Status Tab Content'),
            ),
            // Content for calls tab
            // ignore: prefer_const_constructors
            Center(
              child: const Text('Calls Tab Content'),
            ),

          ],
        ),

        //Add a Drawer for sidebar navigation
        drawer: Drawer(
          backgroundColor: const Color(0xFF00008B),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        radius: 64,
                        backgroundImage: profilePictureUrl != null &&
                            profilePictureUrl.isNotEmpty ?
                        NetworkImage(profilePictureUrl!) :
                        AssetImage('assets/logo.png') as
                        ImageProvider<Object>,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            nameController.text, // Display the user's name
                            style: const TextStyle(
                              fontSize: 25,
                              color: Color(0xF6F5F5FF),
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            '@' + usernameController.text, // Display the user's username
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xF6F5F5FF),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Align(
                            alignment: Alignment.centerLeft, // Adjust alignment as needed
                            child: ElevatedButton(
                              onPressed: () async {
                                // Navigate to the edit profile page
                                bool result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfilePage(),
                                  ),
                                );

                                print("this is the save changes $result");
                                if(result){
                                  fetchUserData();
                                }

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                              ),
                              child: const Row(
                                children: [
                                  Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      color: Color(0xF6F5F5FF),
                                      fontSize: 20,
                                    ),
                                  ),
                                  Icon(Icons.arrow_right),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              ListTile(
                leading: const Icon(
                  Icons.account_circle_outlined,
                  color: Color(0xF6F5F5FF),
                  size: 40,
                ),
                title: const Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 30,
                    color:Color(0xF6F5F5FF),
                  ),
                ),
                selected: _selectedIndex == 0,
                onTap: (){
                  // Update the state of the app
                  _onItemTapped(0);
                  // then close the drawer
                  Navigator.pop(context);
                  Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPageUI()
                    ),
                  );
                },
              ),

              const SizedBox(height: 8,),

              ListTile(
                leading: const Icon(
                  Icons.app_settings_alt_outlined,
                  color: Color(0xF6F5F5FF),
                  size: 40,
                ),
                title: const Text(
                  'Appearance',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xF6F5F5FF),),
                ),
                selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(1);
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => const ThemePage()
                    ),
                  );
                },
              ),
              const SizedBox(height: 8,),
              ListTile(
                leading: const Icon(
                  Icons.chat_outlined,
                  color: Color(0xF6F5F5FF),
                  size: 40,
                ),
                title: const Text(
                  'Chats',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xF6F5F5FF),),
                ),
                selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(2);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 8,),
              ListTile(
                leading: const Icon(
                  Icons.notifications_active_outlined,
                  color: Color(0xF6F5F5FF),
                  size: 40,
                ),
                title: const Text('Notifications',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xF6F5F5FF),),
                ),
                selected: _selectedIndex == 3,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(3);
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                      MaterialPageRoute(
                          builder: (context) => const NotiPage())
                  );
                },
              ),
              const SizedBox(height: 8,),
              ListTile(
                leading: const Icon(
                  Icons.question_mark_outlined,
                  color: Color(0xF6F5F5FF),
                  size: 40,
                ),
                title: const Text('Help',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xF6F5F5FF),),
                ),
                selected: _selectedIndex == 4,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(4);
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) {
                      return const HelpCenter();
                    },
                      settings: const RouteSettings(name: 'HelpCenter',),
                    )
                  );
                },
              ),
              const SizedBox(height: 8,),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app_outlined,
                  color: Color(0xF6F5F5FF),
                  size: 40,
                ),
                title: const Text('Sign Out',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xF6F5F5FF),),
                ),
                selected: _selectedIndex == 5,
                onTap: () async {
                  // Update the state of the app
                  _onItemTapped(5);
                  // Then close the drawer
                  Navigator.pop(context);

                  try{
                    await FirebaseAuth.instance.signOut();
                    // Navigate to login page after signed out
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(onTap: () {})));
                  }
                  catch (e){
                    print("Error signing out: ${e}");
                  }
                },
              ),
              const SizedBox(height: 8,),
            ],
          ),
        ),
      ),
    );
  }

  //build a list of users for the current logged in users.
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text('Error');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('loading . . .');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      },
    );
  }

  //build individual user list items
  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all users except current user
    if(_auth.currentUser!.email != data['name']){
      return ListTile(
        title: Text(
            data['name'],
        style: TextStyle(color: myTextColor),),
        onTap: (){
          // pass the clicked user's UID to the chat page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage(
              receiverName: data['name'] ?? '',
              receiverUserID: data['uid'] ?? '',
              senderprofilePicUrl: data['profilePicUrl'] ?? '',
            ),
            ),
          );
        },
      );
    } else{
      // Return empty container
      return Container();
    }
  }
}