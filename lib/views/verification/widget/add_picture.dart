import 'dart:io';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:rider/common/broken_border_line.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/location_sheet.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/verification_tracker.dart';
import 'package:rider/controllers/verification_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:camera/camera.dart';

import '../../../common/custom_button.dart';

class AddPicture extends StatefulWidget {
  const AddPicture({super.key, required this.back, required this.next});
  final Function back;
  final Function next;

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
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
    final controller = Get.put(VerificationController());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: ReuseableText(
                  title: "Verify Identity",
                  style: TextStyle(
                    color: Tcolor.Text,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Stack(
          children: [
            
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



                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VerificationTracker(
                        title: '1',
                        color: Tcolor.Secondary_Checkbox_icon,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      VerificationTracker(
                        title: '2',
                        color: Tcolor.Secondary_Checkbox_icon,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      VerificationTracker(
                        title: '3',
                        color: Tcolor.Secondary_Checkbox_icon,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      VerificationTracker(
                        title: '4',
                        color: Tcolor.Primary_Checkbox_icon,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 80.h,
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
                          controller.riderImageUrl.value = _imageUrl!;
                          controller.setLoading = false;

                          showModalBottomSheet(
                          context: context,
                          isScrollControlled: true, // Allows full customization
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return SizedBox(
                              child: LocationSheet(),
                            );
                          });
                            print("image => ${controller.riderImageUrl.value}");
                          }
                        : null),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





