import 'package:flutter/material.dart';

const Color shadow = Color.fromRGBO(0, 0, 0, 0.07058823529411765);
const Color white = Colors.white;
const Color black = Colors.black;
const Color transparent = Colors.transparent;

const Color bgColor = Color.fromRGBO(250, 250, 250, 1.0);
const Color glassWhite = Color.fromRGBO(232, 232, 232, 0.5882352941176471);

//blue
const Color primaryColor = Color.fromRGBO(117, 164, 231, 1.0);
const Color secondaryColor = Color.fromRGBO(148, 181, 224, 1.0);

const Color bottomNavBarDisableColor = Color.fromRGBO(178, 210, 246, 1.0);

const themeGradient = LinearGradient(
    colors: [white, secondaryColor, primaryColor],
    begin: Alignment.center,
    end: Alignment.bottomCenter);

const bgGradient = LinearGradient(colors: [
  Color.fromRGBO(166, 166, 166, 0.49411764705882355),
  Color.fromRGBO(213, 212, 212, 0.5882352941176471),
  white
], begin: Alignment.bottomCenter, end: Alignment.center);

const Color fontGrey = Color.fromRGBO(166, 167, 176, 1);
const Color lightGrey = Color.fromRGBO(239, 239, 239, 1.0);
const Color darkGrey = Color.fromRGBO(124, 122, 122, 1.0);

const Color borderGrey = Color.fromRGBO(232, 231, 231, 1.0);

const Color lightOrange = Color.fromRGBO(255, 226, 229, 1);
const Color lightYellow = Color.fromRGBO(255, 244, 222, 1);
const Color lightGreen = Color.fromRGBO(220, 252, 231, 1);
const Color lightPurple = Color.fromRGBO(243, 232, 255, 1);
const Color lightPink = Color.fromRGBO(246, 214, 224, 1.0);
const Color lightBlue = Color.fromRGBO(202, 250, 242, 1.0);
