part of '../../../main.dart';

Future<ProviderContainer> _mainInitializer() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  _setupLogger();

  final container = ProviderContainer(observers: [ProviderLogger(), ProviderCrashlytics()]);
  // Warming-up androidDeviceInfoProvider to be used synchronously at AppTheme to setup the navigation bar
  // behavior for older Android versions without flickering (of the navigation bar) when app starts.
  await container.read(androidDeviceInfoProvider.future).suppressError();
  // Warming-up sharedPrefsAsyncProvider to be used synchronously at theme/locale. Not warming-up this
  // at splashServicesWarmup as theme/locale is used early at SplashScreen (avoid theme/locale flickering).
  await container.read(sharedPrefsAsyncProvider.future).suppressError();

  // This Prevent closing native splash screen until we finish warming-up custom splash images.
  // App layout will be built but not displayed.
  widgetsBinding.deferFirstFrame();
  widgetsBinding.addPostFrameCallback((_) async {
    // Run any function you want to wait for before showing app layout.
    final BuildContext context = widgetsBinding.rootElement!;
    await _precacheAssets(context, container.read(androidDeviceInfoProvider).isAndroid12AndHigher);

    // When the native splash screen is fullscreen, iOS will not automatically show the notification
    // bar when the app loads. To show it, setEnabledSystemUIMode has to be explicitly set:
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge, // https://github.com/flutter/flutter/issues/105714
    );

    // Closes splash screen, and show the app layout.
    widgetsBinding.allowFirstFrame();
  });

  return container;
}

void _setupLogger() {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.ALL;
}

Future<void> _precacheAssets(BuildContext context, bool isAndroid12AndHigher) async {
  await <Future<void>>[
    SplashScreen.precacheAssets(context),
  ].wait.suppressError();
}
