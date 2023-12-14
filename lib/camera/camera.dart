import 'dart:io';
import 'package:apptalk/camera/DisplayPictureScreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<void> main() async{
  // Ensure that plugins services are initialized
  // can be called before runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device
  final cameras = await availableCameras();

  // get a specific camera from the list of available
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

// a screen that allows users to take a picture using a given camera
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  }
      );

  final CameraDescription camera;

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState(){
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController
    _controller = CameraController(
      // get a specific camera from the list of available camera
      widget.camera,
      //define resolution to use
      ResolutionPreset.medium,
    );

    // Next, initialize the controller.
    // This returns a Future<>
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose(){
    // Dispose of the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  Future <void> _displayImageFoundFromGallery() async{
    try{
      //final BuildContext context = this.context;
      final picker = ImagePicker();
      final XFile? pickedImage =
      await picker.pickImage(source: ImageSource.gallery);

      if(pickedImage != null){
        print("Before navigation");
        //display image on a new screen
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(
              imagePath: pickedImage.path,
            ),
          ),
        );
        print("After navigation");
      }
    }
    catch(e){
      // if there is an error, log the error to the console
      print("Unable to pick the image: $e");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Take A picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            //if the Future is complete, display the preview
            return CameraPreview(_controller);
          }
          else{
            //otherwise display a loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            //provide an OnPressed callback
            onPressed: () async{
              // take a picture in a try & catch.
              // if anything goes wrong, catch the error
              try{
                // Ensure that the camera is initialized
                await _initializeControllerFuture;

                // Attempt to take a picture and get the file 'image'
                // where it was saved
                final image = await _controller.takePicture();

                if (!mounted) return;

                // Create a reference to the firebase storage bucket
                final ref = firebase_storage.FirebaseStorage.instance
                    .ref().child('images/${DateTime.now().microsecondsSinceEpoch}.png');

                // Upload the image to the firebase storage
                await ref.putFile(File(image.path));

                //If picture is taken and uploaded, display a success message
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Picture taken and uploaded to firebase storage'),
                    ));

                // If the picture was taken, display it on a new screen
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                      // Pass the automatically generated path to
                      // DisplayPictureScreen widget
                      imagePath: image.path,
                      // imageUrl: imageUrl.toString(),
                    ),
                  ),
                );
              } catch (e){
                // If an error occurs, log the error to the console
                print("Unable to take a picture: $e");
              }
            },
            child: const Icon(Icons.camera_alt),
          ),
          FloatingActionButton(
            onPressed: () async {
              // Display image from gallery
              await _displayImageFoundFromGallery();
            },
            child: const Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}
