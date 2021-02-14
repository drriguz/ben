import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  final String callbackRoute;

  const TakePictureScreen({
    Key key,
    @required this.callbackRoute,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _cameraController;
  Future<void> _initializeControllerFuture;

  Future<void> _initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[1],
      ResolutionPreset.veryHigh,
    );
    return _cameraController.initialize();
  }

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {},
      ),
    );
  }
}
