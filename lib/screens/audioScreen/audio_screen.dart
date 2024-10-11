import 'package:get/get.dart';
import 'package:media_player/common_widgets/custom_appbar_widget.dart';
import 'package:media_player/consts/consts.dart';
import 'package:media_player/consts/text_style.dart';
import 'package:media_player/controllers/audio_player_controller.dart';
import 'package:media_player/screens/audioScreen/audioPlayerScreen/audio_player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../services/format_duration.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  var controller = Get.put(AudioPlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          leadingIcon: Icons.queue_music,
          title: "Music Player",
          onSearch: () {}),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Songs Found"));
          }
          var data = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: appHorizontalPadding,
                  ),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(top: smallMargin),
                        decoration: BoxDecoration(
                            color: bgColor,
                            boxShadow: const [
                              BoxShadow(
                                color: darkGrey,
                                spreadRadius: 0.2,
                              ),
                            ],
                            borderRadius:
                                BorderRadius.circular(smallBorderRadius)),
                        child: Obx(
                          () {
                            return ListTile(
                              leading: Stack(
                                children: [
                                  QueryArtworkWidget(
                                    id: data[index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: const CircleAvatar(
                                      backgroundColor: primaryColor,
                                      child: Icon(Icons.music_note_rounded,
                                          size: mediumIconSize, color: white),
                                    ),
                                  ),
                                ],
                              ),
                              title: Text(
                                data[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: customTextStyle(
                                    color: black,
                                    size: mediumFont,
                                    weight: mediumWeight),
                              ),
                              subtitle: Text(
                                "${data[index].artist ?? "Unknown Artist"}\n${formatDuration(data[index].duration)}",
                                style: customTextStyle(
                                  color: black,
                                  size: smallFont,
                                ),
                              ),
                              // tileColor: isSelected ? Colors.blue[100] : null,
                              trailing: controller.playIndex.value == index &&
                                      controller.isPlaying.value
                                  ? const Icon(
                                      Icons.play_arrow,
                                      color: primaryColor,
                                      size: mediumIconSize,
                                    )
                                  : null,
                              onTap: () {
                                Get.to(AudioPlayerScreen(data: data));
                                controller.playSong(
                                    uri: data[index].uri, index: index);
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
            ],
          );
        },
      ),
    );
  }
}
