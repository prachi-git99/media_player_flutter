import 'package:get/get.dart';
import 'package:media_player/consts/consts.dart';
import 'package:media_player/consts/text_style.dart';
import 'package:media_player/controllers/audio_player_controller.dart';
import 'package:music_visualizer/music_visualizer.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerScreen extends StatelessWidget {
  final List<SongModel> data;
  const AudioPlayerScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = Get.find<AudioPlayerController>();
    controller.songs.assignAll(data);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(gradient: bgGradient),
        padding: const EdgeInsets.symmetric(horizontal: appHorizontalPadding),
        child: Column(
          children: [
            Obx(
              () => Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: size.width * 0.8,
                width: size.width * 0.8,
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: black),
                child: QueryArtworkWidget(
                  id: data[controller.playIndex.value].id,
                  artworkWidth: double.infinity,
                  artworkHeight: double.infinity,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Center(
                    // Center the entire CircleAvatar
                    child: CircleAvatar(
                      backgroundColor: fontGrey,
                      radius: size.width * 0.2,
                      child: Transform.scale(
                        scale: 2.0,
                        child: const Icon(
                          Icons.music_note_rounded,
                          size: extraLargeIconSize, // Set the size of the icon
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(mediumPadding),
              alignment: Alignment.center,
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      data[controller.playIndex.value].title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: customTextStyle(
                          color: black,
                          size: extraLargeFont,
                          weight: largeWeight),
                    ),
                    const SizedBox(height: smallMargin),
                    Text(data[controller.playIndex.value].artist.toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: customTextStyle(
                          color: darkGrey,
                          size: mediumFont,
                          weight: mediumWeight,
                        )),
                    const SizedBox(height: smallMargin),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${controller.position.value}",
                              style: customTextStyle(color: darkGrey)),
                          Expanded(
                              child: Slider(
                                  thumbColor: primaryColor,
                                  activeColor: primaryColor,
                                  min: const Duration(seconds: 0)
                                      .inSeconds
                                      .toDouble(),
                                  max: controller.max.value,
                                  value: controller.value.value,
                                  onChanged: (newValue) {
                                    controller.changeDurationToseconds(
                                        newValue.toInt());
                                    newValue = newValue;
                                  })),
                          Text("${controller.duration.value}",
                              style: customTextStyle(color: darkGrey)),
                        ],
                      ),
                    ),
                    const SizedBox(height: smallMargin),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: controller.isRepeating.value
                            ? const Icon(Icons.repeat_one,
                                size: mediumIconSize, color: primaryColor)
                            : const Icon(Icons.repeat,
                                size: mediumIconSize, color: primaryColor),
                        onPressed: () {
                          controller.isRepeating.value =
                              !controller.isRepeating.value;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (controller.playIndex.value >= 0) {
                                controller.playSong(
                                    uri: data[controller.playIndex.value - 1]
                                        .uri,
                                    index: controller.playIndex.value - 1);
                              }
                            },
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              size: mediumIconSize,
                              color: primaryColor,
                            )),
                        Obx(
                          () => IconButton(
                              onPressed: () {
                                if (controller.isPlaying.value) {
                                  controller.audioPlayer.pause();
                                  controller.isPlaying(false);
                                } else {
                                  controller.audioPlayer.play();
                                  controller.isPlaying(true);
                                }
                              },
                              icon: controller.isPlaying.value
                                  ? const Icon(
                                      Icons.pause_circle,
                                      color: primaryColor,
                                      size: 65.0,
                                    )
                                  : const Icon(
                                      Icons.play_circle_filled_rounded,
                                      color: primaryColor,
                                      size: 65.0,
                                    )),
                        ),
                        IconButton(
                            onPressed: () {
                              if (controller.playIndex.value <= data.length) {
                                controller.playSong(
                                    uri: data[controller.playIndex.value + 1]
                                        .uri,
                                    index: controller.playIndex.value + 1);
                              }
                            },
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              size: mediumIconSize,
                              color: primaryColor,
                            )),
                      ],
                    ),
                    const SizedBox(height: 3 * largeMargin),
                    Obx(() => controller.isPlaying.value
                        ? const MusicVisualizer(
                            barCount: 30,
                            colors: [
                              primaryColor,
                              secondaryColor,
                              primaryColor,
                              secondaryColor,
                            ],
                            duration: [900, 700, 600, 800, 500],
                          )
                        : Container(color: primaryColor, height: 2))
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
