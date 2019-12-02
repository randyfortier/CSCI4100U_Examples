import 'dart:io';

import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override 
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController;
  bool _recordingVideo = false;
  int _photoNum = 1;
  int _movieNum = 1;
  String _moviePath;

  @override 
  void initState() {
    super.initState();

    initializeCamera();
  }

  @override 
  void dispose() {
    _cameraController?.dispose();

    super.dispose();
  }

  Future<void> initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();

    CameraDescription preferred = cameras != null ? cameras[0] : null;
    for (CameraDescription cam in cameras) {
      print('${cam.name}');

      if (cam.lensDirection == CameraLensDirection.back) {
        preferred = cam;
      }
    }

    _cameraController = CameraController(
      preferred,
      ResolutionPreset.medium,
      enableAudio: true,
    );

    try {
      await _cameraController.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    setState(() {});
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _createCameraPreview(),
          _createCameraControls(),
        ],
      ),
    );
  }

  Widget _createCameraPreview() {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return const Text('Finding camera...');
    } else {
      return AspectRatio(
        aspectRatio: _cameraController.value.aspectRatio,
        child: CameraPreview(_cameraController),
      );
    }
  }

  Widget _createCameraControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: _takePicture,
        ),
        _recordingVideo ? 
        IconButton(
          icon: Icon(Icons.stop),
          onPressed: _stopRecording,
        ) : 
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: _startRecording,
        )
      ],
    );
  }

  Future<void> _takePicture() async {
    if (_cameraController.value.isTakingPicture) {
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/photo$_photoNum.jpg';

    _photoNum++;

    print('Photo saved to $filePath');

    try {
      await _cameraController.takePicture(filePath);
    } on CameraException catch (e) {
      print(e);
    }
  }

  Future<void> _startRecording() async {
    setState(() {
      _recordingVideo = true;
    });

    if (!_cameraController.value.isInitialized) {
      print('Error: No front-facing camera found');
      return;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/movie$_movieNum.mp4';

    _movieNum++;

    try {
      await _cameraController.startVideoRecording(filePath);
      print('Recording movie...');
      _moviePath = filePath;
    } on CameraException catch(e) {
      _moviePath = null;
      print(e);
    }
  }

  Future<void> _stopRecording() async {
    setState(() {
      _recordingVideo = false;
    });

    if (!_cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await _cameraController.stopVideoRecording();
    } on CameraException catch(e) {
      print(e);
    }

    print('Movie saved to $_moviePath');
  }
}