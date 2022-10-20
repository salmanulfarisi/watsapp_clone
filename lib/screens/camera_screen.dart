// ignore_for_file: use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:watsapp_clone/screens/camara_view.dart';
import 'package:watsapp_clone/screens/video_view.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isRecording = false;
  String? videoPath;
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            future: cameraValue),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.flash_on,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    GestureDetector(
                      onLongPressUp: () async {
                        setState(() {
                          isRecording = false;
                        });
                        final videoPath = join(
                            (await getTemporaryDirectory()).path,
                            '${DateTime.now()}.mp4');
                        await _cameraController.stopVideoRecording();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoView(
                                      path: videoPath,
                                    )));
                      },
                      onLongPress: () async {
                        try {
                          await _cameraController.startVideoRecording();
                          setState(() {
                            isRecording = true;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      onTap: () {
                        if (!isRecording) {
                          takePhoto(context);
                        }
                      },
                      child: isRecording
                          ? const Icon(Icons.radio_button_on,
                              color: Colors.red, size: 80)
                          : const Icon(
                              Icons.panorama_fish_eye,
                              color: Colors.white,
                              size: 70,
                            ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.flip_camera_android,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Hold for video, tap for photo',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void takePhoto(BuildContext context) async {
    try {
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      await _cameraController.takePicture().then((XFile? file) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CamaraView(
                      path: file!.path,
                    )));
      });
    } catch (e) {
      print(e);
    }
  }
}
