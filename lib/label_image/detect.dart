import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool imageLabelChecking = false;

  XFile? imageFile;

  String imageLabel = "";

  Future<String> getModelPath(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  Future<void> getImageLabels(XFile image) async {
    final labelTflite = await rootBundle.loadString('assets/ml/labels_mobilenet_quant_v1_224.txt');
    final labelList = labelTflite.split('\n');

    final modelPath = await getModelPath('assets/ml/mobilenet_v1_1.0_224_quant.tflite');
    final options = LocalLabelerOptions(
      confidenceThreshold: 0.75,
      modelPath: modelPath,
    );
    final imageLabeler = ImageLabeler(options: options);

    // Load the image
    final inputImage = InputImage.fromFilePath(image.path);

    // Process the image and get the labels
    final labels = await imageLabeler.processImage(inputImage);

    // Display the labels
    StringBuffer buffer = StringBuffer();
    for (final imgLabel in labels) {
      String lblText = labelList[imgLabel.index];
      double confidence = imgLabel.confidence;
      buffer.write(lblText);
      buffer.write(" : ");
      buffer.write((confidence * 100).toStringAsFixed(2));
      buffer.write("%\n");
    }
    // Close the imageLabeler when done
    imageLabeler.close();

    setState(() {
      imageLabel = buffer.toString();
      imageLabelChecking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Image Label example"),
      ),
      body: Center(
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (imageLabelChecking) const CircularProgressIndicator(),
                    if (!imageLabelChecking && imageFile == null)
                      Container(
                        width: 300,
                        height: 300,
                        color: Colors.grey[300]!,
                      ),
                    if (imageFile != null)
                      Image.file(
                        File(imageFile!.path),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.grey[400],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              onPressed: () {
                                getImage(ImageSource.gallery);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.image,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "Gallery",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.grey[400],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              onPressed: () {
                                getImage(ImageSource.camera);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "Camera",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      imageLabel,
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                )),
          )),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imageLabelChecking = true;
        imageFile = pickedImage;
        setState(() {});
        getImageLabels(pickedImage);
      }
    } catch (e) {
      imageLabelChecking = false;
      imageFile = null;
      imageLabel = "Error occurred while getting image Label";
      setState(() {});
    }
  }
}

Future<String> getModelPath(String asset) async {
  final path = '${(await getApplicationSupportDirectory()).path}/$asset';
  await Directory(dirname(path)).create(recursive: true);
  final file = File(path);
  if (!await file.exists()) {
    final byteData = await rootBundle.load(asset);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
  return file.path;
}


// void getImageLabels(XFile image) async {
//   // using base model
//   // final inputImage = InputImage.fromFilePath(image.path);
//   // ImageLabeler imageLabeler =
//   // ImageLabeler(options: ImageLabelerOptions());
//   // List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
//   // StringBuffer sb = StringBuffer();
//   // for (ImageLabel imgLabel in labels) {
//   //   String lblText = imgLabel.label;
//   //   double confidence = imgLabel.confidence;
//   //   sb.write(lblText);
//   //   sb.write(" : ");
//   //   sb.write((confidence * 100).toStringAsFixed(2));
//   //   sb.write("%\n");
//   // }
//   // imageLabeler.close();
//   //
//   // setState(() {
//   //   imageLabel = sb.toString();
//   //   imageLabelChecking = false;
//   // });
//
//   final modelPath = await getModelPath('assets/ml/mobilenet_v1_1.0_224_quant.tflite');
//   final labelPath = 'assets/ml/labels_mobilenet_quant_v1_224.txt';
//   final options = LocalLabelerOptions(
//     confidenceThreshold: 0.75,
//     modelPath: modelPath,
//   );
//   final imageLabeler = ImageLabeler(options: options);
//   try {
//     final inputImage = InputImage.fromFilePath(image.path);
//
//     // Assuming you've already initialized imageLabeler as shown in your code
//     List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
//
//     StringBuffer sb = StringBuffer();
//
//     // // Read labels from the label text file
//     // List<String> labelList = await readLabels(labelPath);
//
//     for (ImageLabel imgLabel in labels) {
//       String lblText = imgLabel.label;
//       double confidence = imgLabel.confidence;
//
//       // Append label and confidence to StringBuffer
//       print(lblText);
//       sb.write(lblText);
//       sb.write(" : ");
//       sb.write((confidence * 100).toStringAsFixed(2));
//       sb.write("%\n");
//     }
//
//     // Update the UI using setState
//     setState(() {
//       imageLabel = sb.toString();
//       imageLabelChecking = false;
//     });
//   } catch (e) {
//     // Handle any errors that occurred during image labeling
//     print('Error processing image labels: $e');
//
//     setState(() {
//       imageLabel = "Error occurred while processing image labels";
//       imageLabelChecking = false;
//     });
//   }
// }
//
// void getImageLabels(XFile image) async {
//   final modelPath = await getModelPath('assets/ml/mobilenet_v1_1.0_224_quant.tflite');
//   final labelPath = await getModelPath('assets/ml/mobilenet_v1_1.0_224_labels.txt'); // Adjust the path to your label file
//   final options = LocalLabelerOptions(
//     confidenceThreshold: 0.75,
//     modelPath: modelPath,
//   );
//   final imageLabeler = ImageLabeler(options: options);
//
//   // Load the image
//   final inputImage = InputImage.fromFilePath(image.path);
//
//   // Process the image and get the labels
//   final labels = await imageLabeler.processImage(inputImage);
//
//   // Display the labels
//   for (final label in labels) {
//     print('Label: ${label}, Confidence: ${label.confidence}');
//   }
// }