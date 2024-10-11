import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();

  RxInt playIndex = 0.obs;
  RxBool isPlaying = false.obs;

  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;

  RxBool isRepeating = false.obs;

  late final RxList<SongModel> songs = <SongModel>[].obs;
  RxList<SongModel> selectedSongs = <SongModel>[].obs;

  final RxList<SongModel> favoriteSongs = <SongModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // requestPermissions();
    _listenForSongCompletion();
  }

  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });

    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  changeDurationToseconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  void toggleFavorite(int index) {
    SongModel song = songs[index];
    if (favoriteSongs.contains(song)) {
      favoriteSongs.remove(song);
    } else {
      favoriteSongs.add(song);
    }
  }

  // Method to check if a song is a favorite
  bool isFavorite(int index) {
    return favoriteSongs.contains(songs[index]);
  }

  playSong({String? uri, required int index}) async {
    playIndex.value = index;
    try {
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      isPlaying(true);
      updatePosition();
    } on Exception catch (e) {
      if (kDebugMode) {
        print("PLAY_SONG_ERROR: ${e.toString()}");
      }
    }
  }

  _listenForSongCompletion() {
    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        if (isRepeating.value) {
          // If repeating, play the same song again
          playSong(uri: songs[playIndex.value].uri, index: playIndex.value);
        } else {
          _playNextSong();
        }
      }
    });
  }

  _playNextSong() {
    if (playIndex.value < songs.length - 1) {
      // Increment the index and play the next song
      playIndex.value += 1;
      playSong(uri: songs[playIndex.value].uri, index: playIndex.value);
    } else {
      // Stop the player after the last song (5th song)
      audioPlayer.stop();
      isPlaying(false);
      Get.snackbar(
        "Playback Finished",
        "All songs in the playlist have been played.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
