// import 'package:get/get.dart';
// import 'package:camera/camera.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'dart:typed_data';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart' as path;
// import 'package:flutter/services.dart';
// import 'package:permission_handler/permission_handler.dart';

// class FaceDetectionController extends GetxController {
//   CameraController? _cameraController;
//   List<CameraDescription>? _cameras;
//   bool _isInitialized = false;
//   late FaceDetector _faceDetector;

//   RxBool isFaceDetected = false.obs;
//   RxString capturedImageUrl = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _initializeCamera();
//     _faceDetector = GoogleMlKit.vision.faceDetector();
//   }

//   // Initialize camera
//   Future<void> _initializeCamera() async {
//     if (await Permission.camera.request().isGranted) {
//       _cameras = await availableCameras();
//       if (_cameras != null && _cameras!.isNotEmpty) {
//         _cameraController = CameraController(
//           _cameras![1],
//           ResolutionPreset.high,
//         );
//         await _cameraController!.initialize();
//         setState(() {
//           _isInitialized = true;
//         });
//         _startImageStream();
//       }
//     } else {
//       print('Camera permission denied');
//     }
//   }

//   // Start streaming images from the camera
//   void _startImageStream() {
//     _cameraController!.startImageStream((CameraImage cameraImage) async {
//       if (cameraImage != null) {
//         await _detectFace(cameraImage);
//       }
//     });
//   }

//   // Detect faces in the camera stream
//   Future<void> _detectFace(CameraImage cameraImage) async {
//     final InputImage inputImage = InputImage.fromBytes(
//       bytes: cameraImage.planes[0].bytes,
//       inputImageData: InputImageData(
//         size: Size(cameraImage.width.toDouble(), cameraImage.height.toDouble()),
//         imageRotation: InputImageRotation.rotation0deg,
//         inputImageFormat: InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ?? InputImageFormat.nv21,
//         planeData: cameraImage.planes.map((plane) {
//           return InputImagePlaneMetadata(bytes: plane.bytes, height: plane.height, width: plane.width);
//         }).toList(),
//       ), metadata: null,
//     );

//     final List<Face> faces = await _faceDetector.processImage(inputImage);
//     if (faces.isNotEmpty) {
//       isFaceDetected.value = true;
//       _captureImage();
//     }
//   }

//   // Capture image when face is detected
//   Future<void> _captureImage() async {
//     if (!_isInitialized || _cameraController == null) return;

//     try {
//       final XFile image = await _cameraController!.takePicture();
//       _uploadImageToFirebase(image);
//     } catch (e) {
//       print('Error capturing image: $e');
//     }
//   }

//   // Upload image to Firebase
//   Future<void> _uploadImageToFirebase(XFile image) async {
//     try {
//       final file = File(image.path);
//       final storageRef = FirebaseStorage.instance.ref();
//       final fileName = path.basename(image.path);
//       final storageFileRef = storageRef.child('user_images/$fileName');
//       await storageFileRef.putFile(file);

//       final downloadUrl = await storageFileRef.getDownloadURL();
//       capturedImageUrl.value = downloadUrl;
//       print('Image uploaded: $downloadUrl');
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }

//   @override
//   void onClose() {
//     _cameraController?.dispose();
//     _faceDetector.close();
//     super.onClose();
//   }
// }


