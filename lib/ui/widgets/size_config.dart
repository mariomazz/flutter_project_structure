import 'package:flutter/material.dart';

class Sizer {
  static double getProportionateScreenHeight(
      BuildContext context, double inputHeight) {
    final MediaQueryData mediaData = MediaQuery.of(context);
    final double screenHeight = mediaData.size.height;
    return (inputHeight / 844.0) * screenHeight;
  }

  static double getProportionateScreenWidth(
      BuildContext context, double inputWidth) {
    final MediaQueryData mediaData = MediaQuery.of(context);
    final double screenWidth = mediaData.size.width;
    return (inputWidth / 390.0) * screenWidth;
  }

  static double getProportionateScreenRadius(
      BuildContext context, double inputHeight) {
    return getProportionateScreenHeight(context, inputHeight);
  }

  static double getProportionateScreenTextSize(
      BuildContext context, double inputWidth) {
    return getProportionateScreenWidth(context, inputWidth)-2;
  }

  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static MediaQueryData getMediaQuery(BuildContext context) {
    return MediaQuery.of(context);
  }
}
