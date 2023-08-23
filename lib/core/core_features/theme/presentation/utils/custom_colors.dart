import 'package:flutter/material.dart';

CustomColors customColors(BuildContext context) => Theme.of(context).extension<CustomColors>()!;

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.fullScreenScaffoldColor,
    required this.font28Color,
    required this.font24Color,
    required this.font20Color,
    required this.font18Color,
    required this.font16Color,
    required this.font14Color,
    required this.font12Color,
    required this.whiteColor,
    required this.blackColor,
    required this.redColor,
    required this.darkRedColor,
    required this.greenColor,
    required this.greyColor,
    required this.carolinaBlueColor,
    required this.marinerColor,
    required this.loadingIndicatorColor,
  });

  final Color? fullScreenScaffoldColor;
  final Color? font28Color;
  final Color? font24Color;
  final Color? font20Color;
  final Color? font18Color;
  final Color? font16Color;
  final Color? font14Color;
  final Color? font12Color;
  final Color? whiteColor;
  final Color? blackColor;
  final Color? redColor;
  final Color? darkRedColor;
  final Color? greenColor;
  final Color? greyColor;
  final Color? carolinaBlueColor;
  final Color? marinerColor;
  final Color? loadingIndicatorColor;

  @override
  CustomColors copyWith({
    Color? fullScreenScaffoldColor,
    Color? font40Color,
    Color? font28Color,
    Color? font24Color,
    Color? font20Color,
    Color? font18Color,
    Color? font16Color,
    Color? font14Color,
    Color? font12Color,
    Color? whiteColor,
    Color? blackColor,
    Color? redColor,
    Color? darkRedColor,
    Color? greenColor,
    Color? greyColor,
    Color? orangeColor,
    Color? carolinaBlueColor,
    Color? marinerColor,
    Color? loadingIndicatorColor,
  }) {
    return CustomColors(
      fullScreenScaffoldColor: fullScreenScaffoldColor ?? this.fullScreenScaffoldColor,
      font28Color: font28Color ?? this.font28Color,
      font24Color: font24Color ?? this.font24Color,
      font20Color: font20Color ?? this.font20Color,
      font18Color: font18Color ?? this.font18Color,
      font16Color: font16Color ?? this.font16Color,
      font14Color: font14Color ?? this.font14Color,
      font12Color: font12Color ?? this.font12Color,
      whiteColor: whiteColor ?? this.whiteColor,
      blackColor: blackColor ?? this.blackColor,
      redColor: redColor ?? this.redColor,
      darkRedColor: darkRedColor ?? this.darkRedColor,
      greenColor: greenColor ?? this.greenColor,
      greyColor: greyColor ?? this.greyColor,
      carolinaBlueColor: carolinaBlueColor ?? this.carolinaBlueColor,
      marinerColor: marinerColor ?? this.marinerColor,
      loadingIndicatorColor: loadingIndicatorColor ?? this.loadingIndicatorColor,
    );
  }

  // Controls how the properties change on theme changes
  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      fullScreenScaffoldColor:
          Color.lerp(fullScreenScaffoldColor, other.fullScreenScaffoldColor, t),
      font28Color: Color.lerp(font28Color, other.font28Color, t),
      font24Color: Color.lerp(font24Color, other.font24Color, t),
      font20Color: Color.lerp(font20Color, other.font20Color, t),
      font18Color: Color.lerp(font18Color, other.font18Color, t),
      font16Color: Color.lerp(font16Color, other.font16Color, t),
      font14Color: Color.lerp(font14Color, other.font14Color, t),
      font12Color: Color.lerp(font12Color, other.font12Color, t),
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t),
      blackColor: Color.lerp(blackColor, other.blackColor, t),
      redColor: Color.lerp(redColor, other.redColor, t),
      darkRedColor: Color.lerp(darkRedColor, other.darkRedColor, t),
      greenColor: Color.lerp(greenColor, other.greenColor, t),
      greyColor: Color.lerp(greyColor, other.greyColor, t),
      carolinaBlueColor: Color.lerp(carolinaBlueColor, other.carolinaBlueColor, t),
      marinerColor: Color.lerp(marinerColor, other.marinerColor, t),
      loadingIndicatorColor: Color.lerp(loadingIndicatorColor, other.loadingIndicatorColor, t),
    );
  }

  // Controls how it displays when the instance is being passed
  // to the `print()` method.
  @override
  String toString() => 'CustomColors('
      'fullScreenScaffoldColor: $fullScreenScaffoldColor'
      'font28Color: $font28Color, font24Color: $font24Color, font20Color: $font20Color'
      'font18Color: $font18Color, font16Color: $font16Color, font14Color: $font14Color'
      'font12Color: $font12Color'
      'whiteColor: $whiteColor, blackColor: $blackColor, redColor: $redColor, darkRedColor: $darkRedColor'
      'greenColor: $greenColor, greyColor: $greyColor, carolinaBlueColor:$carolinaBlueColor'
      'marinerColor: $marinerColor'
      'loadingIndicatorColor: $loadingIndicatorColor'
      ')';
}
