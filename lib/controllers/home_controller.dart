import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var searchTabIndex = 0.obs;

  RxBool isLoading = false.obs;
}
