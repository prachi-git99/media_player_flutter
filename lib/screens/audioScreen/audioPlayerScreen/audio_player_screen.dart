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
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(gradient: bgGradient),
        padding: const EdgeInsets.symmetric(horizontal: appHorizontalPadding),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                  child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                alignment: Alignment.center,
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
                        child: Icon(
                          Icons.music_note_rounded,
                          size: extraLargeIconSize, // Set the size of the icon
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ),
              )),
            ),
            const SizedBox(height: largeMargin),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(mediumPadding),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: bgColor,
                  boxShadow: [
                    BoxShadow(
                      color: darkGrey,
                      spreadRadius: 0.2, // Spread radius
                      blurRadius: 2, // Blur radius
                      offset: Offset(1, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(smallBorderRadius))),
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
                                  min:
                                      Duration(seconds: 0).inSeconds.toDouble(),
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
                                  ? Icon(
                                      Icons.pause_circle,
                                      color: primaryColor,
                                      size: extraLargeIconSize,
                                    )
                                  : Icon(
                                      Icons.play_circle_filled_rounded,
                                      color: primaryColor,
                                      size: extraLargeIconSize,
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
                    )
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
