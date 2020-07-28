import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    final List<CameraDescription> cameras = Provider.of(context, listen: false);
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller.startImageStream(_processImage);
      setState(() {});
    });
  }

  void _processImage(CameraImage cameraImage) {
    print(cameraImage.format.group);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("扫一扫"),
      ),
      backgroundColor: Colors.white,
      body: _cameraPreview(),
    );
  }

  Widget _cameraPreview() {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
