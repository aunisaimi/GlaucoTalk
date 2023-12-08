import 'dart:io';

import 'package:apptalk/components/circle_avatar.dart';
import 'package:apptalk/models/utils.dart';
//import 'package:image_downloader/image_downloader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Uint8List? _image;
  final imagePicker = ImagePicker();
  String dropdownvalue = "Male"; // replace to stored user's gender


  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthController = TextEditingController();

  File? get file => null;

  String profilePictureUrl ='';

  /*
  Future <void> downloadImage(String imageUrl) async{
    try{
      // downloading the image
      var imageId = await ImageDownloader.downloadImage(imageUrl);
      if (imageId == null){
        return;
      }

      String? path = await ImageDownloader.findPath(imageId);
      File downloadedImage = File(path!);

    } catch(e){
      print(e);
    }
  } */

  /*
   selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });

  } */

  Future<void> uploadImageAndSave() async{
    try{
      final user = _auth.currentUser;
      if (user == null) {
        // Handle the case where the user is not signed in.
        return;
      }
      final profile = 'profile_pictures/${user.uid}.png';

      // upload image to cloud storage
      final UploadTask task = _storage.ref().child(profile).putData(_image!);

      //get dwnld URL of the uploaded image
      final TaskSnapshot snapshot = await task;
      final imageUrl = await snapshot.ref.getDownloadURL();

      // update user's firestore doc with the image url
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'profilePictureUrl': imageUrl});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile picture uploaded and updated.'),
        ),
      );
    }catch (error) {
      // Handle errors here.
      print('Error uploading image: $error');
    }
  }

  /*
  Future<File?> _uploadProfilePicture() async{

    File? image;

    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery);
    // You can change source to ImageSource.camera if needed

    if(pickedImage != null){
      try{
        final userId = FirebaseAuth.instance.currentUser!.uid;
        //load the image
        final file = File(pickedImage.path);


        final storageReference = FirebaseStorage.instance
            .ref()
            .child('profile_pictures')
            .child('$userId.png');
        // can use the user's ID as a unique identifier

        //upload the selected image to firebase storage
        await storageReference.putFile(file);

        //get the url of the uploaded image
        final imageUrl = await storageReference.getDownloadURL();

        // save the image URL to firestore t update the existing user document
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'profilePictureUrl' : imageUrl});

        // Update the UI to display the new profile picture
        setState(() {
          // set the profile pic to the CircleAvatar or image widget
           profilePictureUrl = imageUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('profile picture uploaded'),
            ));
      }
      catch(e){
        print(e);
      }
    }
    return image;
  }
*/
  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      final imageBytes = await pickedImage.readAsBytes();
      setState(() {
        _image = Uint8List.fromList(imageBytes);
      });
    }
  }

  @override
  void initState(){
    super.initState();
    //call a function to fetch user's data from firestore
    fetchUserData();
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
          emailController.text = userDoc['email'];
          nameController.text = userDoc['name'];
          passwordController.text = userDoc['password'];
          dropdownvalue = userDoc['gender'];
          dateController = userDoc['birthday'] ?? ' ';
          usernameController.text = userDoc['username'] ?? ' ';

          // set the profile pictrue URL from firestore
          profilePictureUrl = userDoc['profilePictureUrl'];
          // set other fields similarity
        });
      }
    } catch(e){
      print(e);
    }
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
        String formattedDate =
            "${selected.year}-${selected.month.toString().padLeft(2, '0')}"
            "-${selected.day.toString().padLeft(2, '0')}";
        dateController.text = formattedDate; // Update the dateController
        //dateController.text = selected.toString().split(" ")[0];
      });
    }
  }

  Future<void> updateUserData() async{
    try{
      // get the current users ID
      final userId = FirebaseAuth.instance.currentUser!.uid;

      // update the user document in firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({
            'name': nameController.text,
            'gender' : dropdownvalue,
            'email' : emailController.text,
            'birthday' : dateController.text,
            'username' : usernameController.text,
            'profilePictureUrl' : profilePictureUrl,
        // update other fields as needed
      },
    );

      // inform the user that the profile has been updated
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile update successfully'),
        ),
      );

    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Color(0xFF00008B),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Edit Profile"),
          backgroundColor: Colors.black38,
        ),
        body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
                 _image != null ?
                     CircleAvatar(
                       radius: 64,
                         backgroundImage: MemoryImage(_image!),
                     ) :
                 Positioned(
                     bottom: -10,
                     left: 80,
                     child: IconButton(
                       onPressed: (){
                         pickImage(ImageSource.gallery);
                       },
                       icon: const Icon(Icons.add_a_photo),
                     ),
                 ),


               const SizedBox(height: 12),
              // MyTextField(
              //     controller: nameController,
              //     hintText: "Name",
              //     obscureText: false
              // ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  filled: true,
                  fillColor: Color(0xF6F5F5FF),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButton(
                value: dropdownvalue,
                // dropdownColor: const Color(0xF6F5F5FF),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_circle_sharp),
                items: <String>['Male', 'Female'].
                map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue){
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),

              const SizedBox(height: 12),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "username",
                  filled: true,
                  fillColor: Color(0xF6F5F5FF),
                ),
              ),

             const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "email",
                  filled: true,
                  fillColor: Color(0xF6F5F5FF),
                ),
              ),

              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: Color(0xF6F5F5FF),
                  suffixIcon: Icon(Icons.password_outlined),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                  filled: true,
                  fillColor: Color(0xF6F5F5FF),
                  suffixIcon: Icon(Icons.calendar_month_outlined),
                ),
                keyboardType: TextInputType.datetime,
                onTap: (){
                  _selectDate();
                },
              ),

              const SizedBox(height: 8,),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      elevation: 10,
                      shape: const StadiumBorder()
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                        color: Color(0xF6F5F5FF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){
                   // updateUserData();
                    uploadImageAndSave();
                    Navigator.pop(context);
                  },
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
