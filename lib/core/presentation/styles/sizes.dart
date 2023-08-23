part of 'styles.dart';

abstract class Sizes {
  static final double statusBarHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single).padding.top;

  static final double homeIndicatorHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single)
          .viewPadding
          .bottom;

  static final double windowHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single).size.height;

  static double topPadding(BuildContext context) => MediaQuery.paddingOf(context).top;

  // Font Sizes
  /// You can use these directly if you need, but usually there should be a predefined style in TextStyles
  static const double font28 = 28;
  static const double font24 = 24;
  static const double font20 = 20;
  static const double font18 = 18;
  static const double font16 = 16;
  static const double font14 = 14;
  static const double font12 = 12;

  // Icon Sizes
  static const double icon24 = 24;

  // Screen Padding
  static const double screenPaddingV16 = 16;
  static const double screenPaddingH28 = 28;
  static const double screenPaddingH16 = 16;

  // Widget Margin
  static const double marginV28 = 28;
  static const double marginV20 = 20;
  static const double marginH28 = 28;
  static const double marginH20 = 20;
  static const double marginH12 = 12;

  // Widget Padding
  static const double paddingV14 = 14;
  static const double paddingH20 = 20;

  // Button
  static const double buttonPaddingV8 = 8;
  static const double buttonPaddingH96 = 96;
  static const double buttonR10 = 10;

  // Dialog
  static const double dialogWidth280 = 280;
  static const double dialogR20 = 20;
  static const double dialogR6 = 4;
  static const double dialogPaddingV28 = 28;
  static const double dialogPaddingV20 = 20;
  static const double dialogPaddingH24 = 24;

  // Home
  static const double appBarElevation = 0;
  static const double navBarElevation = 2;
}
