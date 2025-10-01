// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:flutter/material.dart';

// class FaceCaptureController extends GetxController {
//   late CameraController cameraController;
//   late FaceDetector faceDetector;
//   RxBool isCameraInitialized = false.obs;
//   RxBool isDetecting = false.obs;
//   RxBool isUploading = false.obs;
//   RxBool isButtonEnabled = false.obs;
//   RxBool isProcessingImage = false.obs; // For "Processing image..." message
//   Rx<XFile?> capturedImage = Rx<XFile?>(null);
//   RxString imageUrl = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     initializeCamera();
//     faceDetector = GoogleMlKit.vision.faceDetector();
//   }

//   @override
//   void onClose() {
//     cameraController.dispose();
//     faceDetector.close();
//     super.onClose();
//   }

//   Future<void> initializeCamera() async {
//     final cameras = await availableCameras();
//     cameraController = CameraController(
//       cameras[1], // Use the front camera
//       ResolutionPreset.medium,
//     );

//     await cameraController.initialize();
//     isCameraInitialized.value = true;

//     // Start face detection automatically
//     startFaceDetection();
//   }

//   void startFaceDetection() {
//     if (!isDetecting.value) {
//       isDetecting.value = true;
//       cameraController.startImageStream((CameraImage image) async {
//         if (isDetecting.value) {
//           try {
//             final WriteBuffer allBytes = WriteBuffer();
//             for (final Plane plane in image.planes) {
//               allBytes.putUint8List(plane.bytes);
//             }
//             final bytes = allBytes.done().buffer.asUint8List();
//             final imageSize =
//                 Size(image.width.toDouble(), image.height.toDouble());

//             final inputImage = InputImage.fromBytes(
//               bytes: bytes,
//               metadata: InputImageMetadata(
//                 size: imageSize,
//                 rotation: InputImageRotation.rotation0deg,
//                 format: InputImageFormat.nv21,
//                 bytesPerRow: image.planes[0].bytesPerRow,
//               ),
//             );

//             final List<Face> faces = await faceDetector.processImage(inputImage);
//             if (faces.isNotEmpty) {
//               isDetecting.value = false;
//               await cameraController.stopImageStream();
//               capturedImage.value = await cameraController.takePicture();
//               uploadImage();
//             }
//           } catch (e) {
//             print("Face detection error: $e");
//           }
//         }
//       });
//     }
//   }

//   Future<void> uploadImage() async {
//     isUploading.value = true; // Show "Uploading..." message

//     final ref = FirebaseStorage.instance
//         .ref()
//         .child('face_images/${DateTime.now()}.jpg');
//     final uploadTask = ref.putFile(File(capturedImage.value!.path));

//     await uploadTask;
//     imageUrl.value = await ref.getDownloadURL();
//     print("Image URL: ${imageUrl.value}");

//     isUploading.value = false; // Hide "Uploading..." message
//     isProcessingImage.value = false; // Hide "Processing image..." message
//     isButtonEnabled.value = true;
//   }
// }
