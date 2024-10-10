import 'package:media_player/consts/consts.dart';

import '../consts/text_style.dart';

AppBar customAppbar(
    {required String title, required void Function()? onSearch}) {
  return AppBar(
    title: Text(
      title,
      style: customTextStyle(size: extraLargeFont, weight: mediumWeight),
    ),
    leading: const Icon(Icons.sort_rounded, color: darkGrey),
    actions: [
      IconButton(
        onPressed: onSearch,
        icon: const Icon(
          Icons.search,
          color: darkGrey,
        ),
      ),
    ],
  );
}
