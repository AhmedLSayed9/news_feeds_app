part of 'app_colors.dart';

class AppColorsDark implements AppColors {
  @override
  Color get primaryColor => const Color(0xff212327);
  @override
  Color get primary => const Color(0xFF4aa3f6);
  @override
  Color get secondary => const Color(0xFF213871);

  @override
  Color get statusBarColor => Colors.transparent;
  @override
  Color get systemNavBarColor => Colors.transparent;
  @override
  Color get olderAndroidSystemNavBarColor => scaffoldBGColor;
  @override
  Color get appBarBGColor => scaffoldBGColor.withOpacity(0.60);
  @override
  Color get scaffoldBGColor => const Color(0xFFD9D9D9);
  @override
  Color get navBarColor => secondary;
  @override
  Color get navBarIndicatorColor => const Color(0xFFBBDEFB);

  //in the custom
  Color get font40Color => const Color(0xfff0f0f0);

  @override
  Color get textFieldSubtitle1Color => const Color(0xfff0f0f0);
  @override
  Color get textFieldHintColor => const Color(0xFF888888);
  @override
  Color get textFieldCursorColor => const Color(0xfff44336);
  @override
  Color get textFieldFillColor => Colors.transparent;
  @override
  Color get textFieldPrefixIconColor => const Color(0xFF888888);
  @override
  Color get textFieldSuffixIconColor => const Color(0xFF888888);
  @override
  Color get textFieldBorderColor => const Color(0xFF888888);
  @override
  Color get textFieldEnabledBorderColor => const Color(0xFF888888);
  @override
  Color get textFieldFocusedBorderColor => const Color(0xFF51A7DD);
  @override
  Color get textFieldErrorBorderColor => const Color(0xffff0000);
  @override
  Color get textFieldErrorStyleColor => const Color(0xffff0000);

  @override
  Color get iconColor => const Color(0xfff0f0f0);

  @override
  Color get buttonColor => const Color(0xFF51A7DD);
  @override
  Color get buttonDisabledColor => const Color(0xFF9E9E9E);

  @override
  Color get toggleButtonBorderColor => const Color(0xFF858585);
  @override
  Color get toggleButtonSelectedColor => const Color(0xFF858585);
  @override
  Color get toggleButtonDisabledColor => const Color(0xFF303030);

  @override
  Color get cardBGColor => const Color(0xFF424242);
  @override
  Color get cardShadowColor => const Color(0x26000000);

  @override
  Color get dialogBGColor => const Color(0xFF303030);

  @override
  CustomColors get customColors => const CustomColors(
        fullScreenScaffoldColor: Color(0xFF303030),
        font28Color: Color(0xfff0f0f0),
        font24Color: Color(0xfff0f0f0),
        font20Color: Color(0xfff0f0f0),
        font18Color: Color(0xfff0f0f0),
        font16Color: Color(0xfff0f0f0),
        font14Color: Color(0xffcccccc),
        font12Color: Color(0xffcccccc),
        whiteColor: Color(0xffffffff),
        blackColor: Color(0xff000000),
        redColor: Color(0xFFF44336),
        darkRedColor: Color(0xFFB10606),
        greenColor: Color(0xFF32cf32),
        greyColor: Color(0xFF888888),
        carolinaBlueColor: Color(0xFF51A7DD),
        marinerColor: Color(0xFF9ab2d5),
        loadingIndicatorColor: Color(0xFF51A7DD),
      );
}
