import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/controllers/profile_controllers.dart';
import 'package:rider/views/profile/profile_document/profile_document.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'dart:io';

import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../../models/image_update.dart';


class FaceCapturePage extends StatefulWidget {
  const FaceCapturePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FaceCapturePageState createState() => _FaceCapturePageState();
}

class _FaceCapturePageState extends State<FaceCapturePage> {
  late CameraController _cameraController;
  late FaceDetector _faceDetector;
  bool _isCameraInitialized = false;
  bool _isDetecting = false;
  bool _isUploading = false;
  bool _isButtonEnabled = false;
  bool _isProcessingImage = false; // New flag for showing "Processing image..."
  XFile? _capturedImage;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _faceDetector = FaceDetector(
  options: FaceDetectorOptions(
    enableContours: true, // Enables facial contours detection
    enableClassification: true, // Enables smile & eyes open classification
  ),
);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _faceDetector.close();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[1], // Use the front camera
      ResolutionPreset.medium,
    );

    await _cameraController.initialize();
    setState(() {
      _isCameraInitialized = true;
    });

    // Start face detection automatically after the camera initializes
    _startFaceDetection();
  }

  // void _startFaceDetection() {
  //   if (!_isDetecting) {
  //     _isDetecting = true;
  //     _cameraController.startImageStream((CameraImage image) async {
  //       if (_isDetecting) {
  //         try {
  //           final WriteBuffer allBytes = WriteBuffer();
  //           for (final Plane plane in image.planes) {
  //             allBytes.putUint8List(plane.bytes);
  //           }
  //           final bytes = allBytes.done().buffer.asUint8List();
  //           final imageSize =
  //               Size(image.width.toDouble(), image.height.toDouble());

  //           final inputImage = InputImage.fromBytes(
  //             bytes: bytes,
  //             metadata: InputImageMetadata(
  //               size: imageSize,
  //               rotation: InputImageRotation.rotation0deg,
  //               format: InputImageFormat.nv21,
  //               bytesPerRow: image.planes[0].bytesPerRow, // Required field
  //             ),
  //           );

  //           final List<Face> faces =
  //               await _faceDetector.processImage(inputImage);
  //           if (faces.isNotEmpty) {
  //             _isDetecting = false;
  //             await _cameraController.stopImageStream();
  //             _capturedImage = await _cameraController.takePicture();
  //             _uploadImage();
  //           }
  //         } catch (e) {
  //           print("Face detection error: $e");
  //         }
  //       }
  //     });
  //   }
  // }

  void _startFaceDetection() {
  if (!_isDetecting) {
    _isDetecting = true;
    _cameraController.startImageStream((CameraImage image) async {
      if (!_isDetecting) return; // Prevent duplicate processing

      try {
        final WriteBuffer allBytes = WriteBuffer();
        for (final Plane plane in image.planes) {
          allBytes.putUint8List(plane.bytes);
        }
        final bytes = allBytes.done().buffer.asUint8List();
        final imageSize = Size(image.width.toDouble(), image.height.toDouble());

        // Get correct rotation from camera
        final int rotationDegrees = _cameraController.description.sensorOrientation;
        final InputImageRotation rotation = InputImageRotation.values.firstWhere(
          (r) => r.index * 90 == rotationDegrees,
          orElse: () => InputImageRotation.rotation0deg,
        );

        final inputImage = InputImage.fromBytes(
          bytes: bytes,
          metadata: InputImageMetadata(
            size: imageSize,
            rotation: rotation, // Dynamic rotation
            format: InputImageFormat.nv21,
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        final List<Face> faces = await _faceDetector.processImage(inputImage);
        
        if (faces.isNotEmpty) {
          _isDetecting = false; // Prevent further detections
          await _cameraController.stopImageStream();
          _capturedImage = await _cameraController.takePicture();
          _uploadImage();
        }
      } catch (e) {
        print("Face detection error: $e");
      }
    });
  }
}


  Future<void> _uploadImage() async {
    setState(() {
      _isUploading = true; // Show "Uploading..." message
    });

    final ref = FirebaseStorage.instance
        .ref()
        .child('face_images/${DateTime.now()}.jpg');
    final uploadTask = ref.putFile(File(_capturedImage!.path));

    await uploadTask;
    _imageUrl = await ref.getDownloadURL();
    print("Image URL: $_imageUrl");

    setState(() {
      _isUploading = false; // Hide "Uploading..." message
      _isProcessingImage = false; // Hide "Processing image..." message
      _isButtonEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final profileController = Get.put(ProfileController());
    var riderId = box.read("riderId");
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.h),
              child: Center(
                child: ReuseableText(
                  title: "Update Driver’s Picture",
                  style: TextStyle(
                    color: Tcolor.Text,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  // right: 0, // Align the icon to the left
                  child: GestureDetector(
                    onTap: () {
                      //     Navigator.push(
                      // context,
                      // MaterialPageRoute(
                      //   builder: (context) => ProfileDocument()
                      // ));
        
                      Get.back();
                    },
                    child: Container(
                      height: 55.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Tcolor.White,
                          border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.49))),
                      child: Icon(
                        HeroiconsMini.chevronLeft,
                        color: Tcolor.Text,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 200.r,
                        backgroundColor: Colors.grey[300],
                        child: ClipOval(
                          child: //_imageUrl != null
                              // ? Image.network(_imageUrl!,
                              //     fit: BoxFit.cover, width: 200, height: 200)
                              // : _isCameraInitialized
                              //     ? CameraPreview(_cameraController)
                              //     : CircularProgressIndicator(),
        
                              _imageUrl != null
                                  ? Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Image.network(_imageUrl!,
                                            fit: BoxFit.cover,
                                            width: 400.w,
                                            height: 400.h),
                                        if (_isUploading)
                                          Container(
                                            color: Colors.black54,
                                            
                                            child: Center(
                                              child: Text(
                                                "Uploading...",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                      ],
                                    )
                                  : _isCameraInitialized
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SizedBox(
                                              height: 400.h,
                                              width: 400.w,
                                              child: ClipOval(child: CameraPreview(_cameraController))
                                              ),
                                            if (_isUploading)
                                              Container(
                                                color: Colors.black54,
                                                child: Center(
                                                  child: Text(
                                                    "Processing...",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        )
                                      : Container(
                                      height: 96.h,
                                      width: 96.w,
                                      decoration: BoxDecoration(
                                        color: Tcolor.BACKGROUND_Dark,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          HeroiconsOutline.camera,
                                          color: Tcolor.Text,
                                          size: 40.sp,
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                    ),
        
                    // SizedBox(height: 20),
        
                    // Show status messages while processing
                    if (_isProcessingImage)
                      Text("Processing image...",
                          style: TextStyle(color: Colors.orange)),
                    if (_isUploading)
                      Text("Uploading...", style: TextStyle(color: Colors.orange)),
        
                    SizedBox(height: 20),
                    SizedBox(height: 60.h),
                    ReuseableText(
                      title: "Put your bare face clearly in the camera.",
                      style: TextStyle(
                        color: Tcolor.Text,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ReuseableText(
                      title: "No face mask or glasses",
                      style: TextStyle(
                        color: Tcolor.Text,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
        
                    CustomButton(
                        title: "Complete Update",
                        textColor: Tcolor.Text,
                        btnColor: _isButtonEnabled ? Tcolor.PRIMARY_Button_color_2 : Color.fromRGBO(193, 193, 193, 1),
                        btnWidth: MediaQuery.of(context).size.width / 1.1,
                        btnHeight: 90.h,
                        raduis: 100.r,
                        fontSize: 32.sp,
                        showArrow: false,
                        onTap: _isButtonEnabled
                            ? () {
                              print(_imageUrl);
                              ImageUpdate model = ImageUpdate(userImageUrl: _imageUrl!);
                              String data = imageUpdateToJson(model);
                              profileController.updateUserImage(data, riderId);
                              }
                            : null),
                  ],
                ),
              ],
            ),
          ),
        ),

        Obx(() {
          if (profileController.isLoading) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Dim background
                child: Center(
                  child: LottieBuilder.asset(
                    'assets/animation/loading_state.json', // Replace with your Lottie file path
                    width: 200.w,
                    height: 200.h,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}





