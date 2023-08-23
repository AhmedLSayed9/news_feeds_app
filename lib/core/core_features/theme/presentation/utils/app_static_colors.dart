import 'package:flutter/material.dart';

abstract class AppStaticColors {
  static const Color pictonBlue = Color(0xFF4aa3f6);

  static const Color primary = Color(0xFFC11718);
  static const Color toastColor = Color(0xFFC11718);
  static const Color white = Color(0xffffffff);
  static const Color whiteOpacity50 = Color(0x80ffffff);
  static const Color black = Color(0xff000000);
  static const Color blackOpacity25 = Color(0x40000000);
  static const Color blackOpacity45 = Color(0x73000000);
  static const Color lightBlack = Color(0xff333333);
  static const Color lightOrange = Color(0xfffe9654);
  static const Color greyShadow = Color(0xffD9D9D9);
  static const Color blue = Color(0xFF2196F3);
  static const Color lightBlue = Color(0xFF58b9f0);
  static const LinearGradient primaryIngredientColor = LinearGradient(
    colors: [Color(0xFFd74747), Color(0xFFC11718)],
    stops: [0, 1],
  );
  static const Color placeHolderBaseColor = Color(0xFFE0E0E0);
  static const Color placeHolderHighlightColor = Color(0xFFF5F5F5);

  static const ColorFilter colorFilterBlack25 = ColorFilter.mode(blackOpacity25, BlendMode.srcOver);
  static const ColorFilter colorFilterBlack45 = ColorFilter.mode(blackOpacity45, BlendMode.srcOver);
  static const ColorFilter colorFilterWhite50 =
      ColorFilter.mode(AppStaticColors.whiteOpacity50, BlendMode.srcIn);

  static const boxShadowBlack25 = [
    BoxShadow(color: blackOpacity25, blurRadius: 6, offset: Offset(0, 2)),
  ];

  static const boxShadowBlack25Reduced = [
    BoxShadow(color: blackOpacity25, blurRadius: 3, offset: Offset(0, 1)),
  ];
}
