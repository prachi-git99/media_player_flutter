import 'dart:io';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

requestPermissions() async {
  if (Platform.isAndroid) {
    if ((await Permission.audio.request().isGranted ||
            await Permission.storage.request().isGranted) &&
        await Permission.videos.request().isGranted) {
      Get.snackbar(
        "Permission Granted",
        "Welcome to your ad-free Media Player",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      if (await Permission.audio.status.isDenied) {
        Get.snackbar("Permission Denied",
            "Storage permission is required to access media files.");
      }
      print(await Permission.audio.status);
    }
  }
}
