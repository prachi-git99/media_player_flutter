import 'package:get/get.dart';
import 'package:media_player/services/request_permission.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var searchTabIndex = 0.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestPermissions();
  }
}
