import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:okapia/ui/utils/toast.dart';
import 'package:okapia/ui/widgets/loading.dart';

const ResolutionPreset resolutionPreset = ResolutionPreset.high;

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

  List<CameraDescription> cameras;

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[0],
      resolutionPreset,
    );
    await Future.delayed(Duration(seconds: 1));
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

  Widget _buildCameraSwitch() {
    return Column(
      children: cameras
          .map(
            (e) => SizedBox(
              width: 100,
              child: RadioListTile<CameraDescription>(
                title: Icon(_getCameraLensIcon(e.lensDirection)),
                activeColor: Colors.green,
                value: e,
                groupValue: _cameraController?.description,
                onChanged: _onNewCameraSelected,
              ),
            ),
          )
          .toList(),
    );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
    }
    throw ArgumentError('Unknown lens direction');
  }

  Widget _buildCameraControl() {
    return Stack(
      children: <Widget>[
        CameraPreview(_cameraController),
        Positioned(
          top: 24.0,
          left: 12.0,
          child: _buildCameraSwitch(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildCameraControl();
          } else {
            return Loading();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: _onTakePhoto,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _onNewCameraSelected(CameraDescription cameraDescription) async {
    if (_cameraController != null) {
      await _cameraController.dispose();
    }
    _cameraController = _createCameraController(cameraDescription);
    _cameraController.addListener(() {
      if (mounted) setState(() {});
      if (_cameraController.value.hasError)
        Toasts.showError(
            'Camera error ${_cameraController.value.errorDescription}');
    });

    await _cameraController.initialize();
  }

  CameraController _createCameraController(
      CameraDescription cameraDescription) {
    return new CameraController(
      cameraDescription,
      resolutionPreset,
      enableAudio: true,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
  }

  Future<void> _onSwitchCamera() async {}

  Future<void> _onTakePhoto() async {}
}
