import 'package:get/get.dart';
import 'package:media_player/screens/audioScreen/audio_screen.dart';
import 'package:media_player/screens/videoScreen/video_screen.dart';

import '../consts/consts.dart';
import 'controllers/home_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(HomeController());

  buildBottomNavigationBarItem(name, icon, controller, currentNavIndex) {
    return BottomNavigationBarItem(
        icon: Obx(
          () => Icon(icon,
              size: navBarIconSize,
              color: controller.currentNavIndex.value == currentNavIndex
                  ? primaryColor
                  : darkGrey),
        ),
        label: name);
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> navbarItem = [
      buildBottomNavigationBarItem(
          label_1, Icons.my_library_music, controller, 0),
      buildBottomNavigationBarItem(
          label_2, Icons.video_collection_outlined, controller, 1),
    ];

    var navBody = [AudioScreen(), const VideoScreen()];

    return WillPopScope(
      onWillPop: () async {
        // showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (context)=>exitDialog(context)
        // );
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Obx(() => navBody.elementAt(controller.currentNavIndex.value)),
            Obx(
              () => Container(
                alignment: Alignment.bottomCenter,
                child: BottomNavigationBar(
                    elevation: 5.0,
                    currentIndex: controller.currentNavIndex.value,
                    selectedItemColor: primaryColor,
                    unselectedItemColor: darkGrey,
                    backgroundColor: white,
                    type: BottomNavigationBarType.fixed,
                    selectedLabelStyle: const TextStyle(
                        fontFamily: poppins,
                        fontWeight: smallWeight,
                        fontSize: extraSmallFont),
                    unselectedLabelStyle: const TextStyle(
                        fontFamily: poppins, fontSize: extraSmallFont),
                    onTap: (value) => controller.currentNavIndex.value = value,
                    items: navbarItem),
              ),
            )
          ],
        ),
      ),
    );
  }
}
