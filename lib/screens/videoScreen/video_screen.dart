import '../../common_widgets/custom_appbar_widget.dart';
import '../../consts/consts.dart';
import '../../consts/text_style.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppbar(
          leadingIcon: Icons.videocam_outlined,
          title: "Video Player",
          onSearch: () {}),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: appHorizontalPadding,
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 8,
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
                      borderRadius: BorderRadius.circular(smallBorderRadius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: size.height *
                                    0.1, // Adjust the height as needed
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius:
                                      BorderRadius.circular(smallBorderRadius),
                                ),
                              ),
                              Positioned.fill(
                                // Fills the Stack's container space
                                child: Center(
                                  // Centers the IconButton inside the Stack
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.play_circle_fill_rounded,
                                      color: fontGrey,
                                      size: largeIconSize,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              width:
                                  10), // Add some space between image and text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Title name",
                                  overflow: TextOverflow.ellipsis,
                                  style: customTextStyle(
                                      color: black,
                                      size: largeFont,
                                      weight: mediumWeight),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Artist name',
                                  overflow: TextOverflow.ellipsis,
                                  style: customTextStyle(
                                    color: black,
                                    size: smallFont,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(
                                          smallBorderRadius)),
                                  child: Text(
                                    '00:00:00',
                                    overflow: TextOverflow.ellipsis,
                                    style: customTextStyle(
                                      color: darkGrey,
                                      size: extraSmallFont,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.07,
          ),
        ],
      ),
    );
  }
}
