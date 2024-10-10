import 'package:media_player/consts/consts.dart';

import '../consts/text_style.dart';

AppBar customAppbar(
    {required String title,
    required void Function()? onSearch,
    required IconData leadingIcon}) {
  return AppBar(
    title: Text(
      title,
      style: customTextStyle(size: extraLargeFont, weight: mediumWeight),
    ),
    leading: Icon(leadingIcon, color: primaryColor, size: mediumIconSize),
    // actions: [
    //   IconButton(
    //     onPressed: onSearch,
    //     icon: const Icon(
    //       Icons.search,
    //       color: darkGrey,
    //     ),
    //   ),
    // ],
  );
}
