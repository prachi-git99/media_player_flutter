import 'package:get/get.dart';
import 'package:media_player/consts/consts.dart';
import 'package:media_player/consts/text_style.dart';
import 'package:media_player/controllers/audio_player_controller.dart';
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
      appBar: AppBar(
        actions: [
          Obx(() {
            bool isFavorite = controller.isFavorite(controller.playIndex.value);
            return IconButton(
                onPressed: () {
                  controller.toggleFavorite(controller.playIndex.value);
                },
                icon: isFavorite
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(Icons.favorite_border_rounded, color: darkGrey));
          })
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: themeGradient),
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
              margin: const EdgeInsets.only(top: mediumMargin),
              alignment: Alignment.center,
              child: Obx(
                () => Column(
                  children: [
                    //song name
                    Text(
                      data[controller.playIndex.value].title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: customTextStyle(
                          color: black,
                          size: extraLargeFont,
                          weight: largeWeight),
                    ),
                    const SizedBox(height: mediumMargin),

                    //artist name
                    Text(data[controller.playIndex.value].artist.toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: customTextStyle(
                          color: darkGrey,
                          size: mediumFont,
                          weight: mediumWeight,
                        )),
                    SizedBox(height: size.height * 0.1),

                    //start time || repeating icon || end time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${controller.position.value}",
                            style: customTextStyle(color: white)),
                        IconButton(
                          icon: controller.isRepeating.value
                              ? const Icon(Icons.repeat_one,
                                  size: mediumIconSize, color: white)
                              : const Icon(Icons.repeat,
                                  size: mediumIconSize, color: white),
                          onPressed: () {
                            controller.isRepeating.value =
                                !controller.isRepeating.value;
                          },
                        ),
                        Text("${controller.duration.value}",
                            style: customTextStyle(color: white)),
                      ],
                    ),
                    //slider and times
                    Obx(
                      () => Slider(
                          thumbColor: primaryColor,
                          activeColor: primaryColor,
                          inactiveColor: white,
                          min: const Duration(seconds: 0).inSeconds.toDouble(),
                          max: controller.max.value,
                          value: controller.value.value,
                          onChanged: (newValue) {
                            controller
                                .changeDurationToseconds(newValue.toInt());
                            newValue = newValue;
                          }),
                    ),
                    const SizedBox(height: smallMargin),

                    //play || pause|| previous||next
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
                              color: white,
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
                                      color: white,
                                      size: 65.0,
                                    )
                                  : const Icon(
                                      Icons.play_circle_filled_rounded,
                                      color: white,
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
                              color: white,
                            )),
                      ],
                    ),
                    const SizedBox(height: 2 * largeMargin),

                    // //music visualiser
                    // Obx(() => controller.isPlaying.value
                    //     ? const MusicVisualizer(
                    //         barCount: 30,
                    //         colors: [white, white, white, white],
                    //         duration: [900, 700, 600, 800, 500],
                    //       )
                    //     : SizedBox(
                    //         height: size.height * 0.04,
                    //         width: size.width,
                    //         child: Image.asset(
                    //           "assets/gifs/sound_wave.png",
                    //           fit: BoxFit.cover,
                    //           color: white,
                    //         )))
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
