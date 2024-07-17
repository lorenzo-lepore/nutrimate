import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  bool isCameraInitialized = false;

  /* @override
  void initState() {
    super.initState();
    startCamera();
  }
 */
  void startCamera() async {
    cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
        enableAudio: false,
      );

      try {
        await cameraController.initialize();
        if (!mounted) {
          return;
        }
        setState(() {
          isCameraInitialized = true;
        });
      } catch (e) {
        // Gestione errore nell'inizializzazione della camera 
      }
    } else {
      // Gestione nessuna camera disponibile
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return const Text('Scanner Page');/* Expanded(
        child: isCameraInitialized 
          ? AspectRatio(
            aspectRatio: cameraController.value.aspectRatio,
            child: CameraPreview(cameraController),
          )
        : const Center(child: CircularProgressIndicator()),
      );
  } */
 }
}
