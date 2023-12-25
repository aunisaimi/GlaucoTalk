import 'package:apptalk/pages/status/add_story_page.dart';
import 'package:apptalk/pages/status/stories/view_stories_page.dart';
import 'package:apptalk/pages/status/story_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  Color myCustomColor = const Color(0xFF00008B);
  Color myTextColor = const Color(0xF6F5F5FF);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final imagePicker = ImagePicker();
  String profilePictureUrl ='';

  PickedFile? pickedImage;
  String storyContent = '';

  String _statusText = ""; // Add your status text here
  String _mediaUrl = ""; // Add your media URL here (if any)


  @override
  void initState(){
    super.initState();
    // call a function to retrieve the user's profile picture url when
    // the widget initialized

    _retrieveUserProfilePicture();
  }

  // Function to retrieve user's profile picture URL
  Future <void> _retrieveUserProfilePicture() async {
    try{
      // get the current signed in user
      final user = _auth.currentUser;
      if (user != null){
        final profilePictureRef = _storage.ref().child('profile_pictures/${user.uid}.png');

        // get the download URL for the profile picture
        final downloadUrl = await profilePictureRef.getDownloadURL();

        setState(() {
          profilePictureUrl = downloadUrl;
        });
      }
    } catch(e){
      print('Error retrieving profile picture with error: $e');
    }
  }

  Future<void> pickImage() async {
    try{
      final pickedFile =
      await imagePicker.pickImage(source: ImageSource.gallery);
      if(pickedFile != null){
        setState(() {
          pickedImage = pickedFile as PickedFile?;
        });
      }
    } catch (e){
      print('Error picking image: $e');
    }
  }

  // Future<void> _uploadStatus() async{
  //   try{
  //     // get the current user ID
  //     final userId = FirebaseAuth.instance.currentUser!.uid;
  //
  //     // Generate a unique document for each uploaded status
  //     final statusDocRef =
  //     FirebaseFirestore.instance.collection('status').doc();
  //
  //     // save the uploaded statuses in the firestore
  //     await statusDocRef.set({
  //       'userID': userId,
  //       'mediaUrl': _mediaUrl,
  //       'statusText': _statusText,
  //       'timeStamp': Timestamp.now(),
  //     });
  //
  //     // inform the user that the status has been uploaded
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(
  //       const SnackBar(
  //         content: Text(
  //             'Status Uploaded'),
  //       ),
  //     );
  //
  //     // clear status and media after upload
  //     setState(() {
  //       _statusText = " ";
  //       _mediaUrl = " ";
  //     });
  //
  //   }
  //   catch (e){
  //     print('Error in uploading status: $e');
  //   }
  // }

  // Future<void> _addStory(String content, File mediaFile) async {
  //   try {
  //     final User? user = _auth.currentUser;
  //     if (user != null) {
  //       final storyMediaFile = File(mediaFile.path);
  //
  //       // Upload storyMediaFile to storage
  //       final storageReference = FirebaseStorage.instance.ref().child('stories/${user.uid}_${DateTime.now().millisecondsSinceEpoch}.png');
  //       final uploadTask = storageReference.putFile(storyMediaFile);
  //       final TaskSnapshot uploadSnapshot = await uploadTask.whenComplete(() => {});
  //
  //       // Get the download URL of the uploaded media
  //       final downloadUrl = await uploadSnapshot.ref.getDownloadURL();
  //
  //       // Create a new story document in Firestore with user's ID, content, media URL, and timestamp
  //       await FirebaseFirestore.instance.collection('stories').add({
  //         'userId': user.uid,
  //         'content': content,
  //         'mediaUrl': downloadUrl,
  //         'timestamp': Timestamp.now(),
  //       });
  //
  //       // Navigate back to the previous screen or perform any other desired actions
  //       Navigator.pop(context);
  //     }
  //   } catch (e) {
  //     print('Error adding story: $e');
  //   }
  // }

  void _openStory(){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StoryPage(),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              itemCount: 10, // Replace with actual count
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: _openStory,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(profilePictureUrl),
                    radius: 30,
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            child: const Text('View Stories'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewStoriesPage()),
              );
            },
          ),
          ElevatedButton(
            child: const Text('View Story Page'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StoryPage()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStoryPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
