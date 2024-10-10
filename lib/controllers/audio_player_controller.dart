import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPlayerController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  RxInt playIndex = 0.obs;

  RxBool isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    _requestPermissions();
  }

  //handle permission for accessing audio and video
  _requestPermissions() async {
    if (Platform.isAndroid) {
      if ((await Permission.audio.request().isGranted ||
              await Permission.storage.request().isGranted) &&
          await Permission.videos.request().isGranted) {
        Get.snackbar(
          "Permission Granted",
          "Welcome to your ad free Media Player",
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

  //to display song duration
  String formatDuration(int? duration) {
    if (duration == null) return "00:00";
    Duration d = Duration(milliseconds: duration);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(d.inMinutes.remainder(60));
    String seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  playSong({String? uri, index}) {
    playIndex.value = index;
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
      isPlaying(true);
    } on Exception catch (e) {
      if (kDebugMode) {
        print("PLAY_SONG_ERROR: ${e.toString()}");
      }
    }
  }
}
