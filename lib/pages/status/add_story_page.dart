import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({Key? key}) : super(key: key);

  @override
  _AddStoryPageState createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  String? _statusText; // Initialize as null or with a default status text
  XFile? _pickedImage; // Updated to use XFile instead of PickedFile

  Future<void> _uploadStatus() async {
    try {
      final User? user = _auth.currentUser;

      // check if user is logged in
      if(user == null){
        print('User is not logged in');
        return;
      }

      // check if status is not empty
      if (_statusText == null || _statusText!.isEmpty){
        print('Status text is empty');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a status'),
          ),
        );
        return;
      }

      // Check if an image is picked
      if (_pickedImage == null) {
        print('No image selected.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an image'),
          ),
        );
        return;
      }

      // proceed with uploading the image first
      final storageReference = _storage
          .ref()
          .child('status_images/${user.uid}_${DateTime.now().millisecondsSinceEpoch}.png');

      final uploadTask = storageReference.putFile(File(_pickedImage!.path));
      final TaskSnapshot uploadSnapshot = await uploadTask;
      final String imageDownloadUrl = await uploadSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('status').add({
        'userID': user.uid,
        'statusText': _statusText,
        'mediaUrl': imageDownloadUrl,
        'timeStamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        _statusText = null;
        _pickedImage = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Status uploaded successfully'),
        ),
      );

    } catch (e) {
      print('Error uploading status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading status: $e'),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Story'),
        actions: [
          IconButton(
            onPressed: _uploadStatus,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              setState(() {
                _statusText = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Status Here',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  _pickedImage = pickedFile;
                });
              }
            },
            child: const Text('Select Image'),
          ),
          if (_pickedImage != null)
            Image.file(
              File(_pickedImage!.path),
              width: 100,
              height: 100,
            ),
        ],
      ),
    );
  }
}