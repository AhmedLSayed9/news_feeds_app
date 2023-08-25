// ignore_for_file: scoped_providers_should_specify_dependencies
part of 'utils.dart';

extension WidgetTesterX on WidgetTester {
  Future<void> pumpRiverpodApp(
    Widget widget, {
    ConsumerCallBack? initState,
    List<Override> overrides = const [],
  }) async {
    const locale = AppLocale.english;
    return pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          home: CallbackConsumerWidget(
            initState: initState,
            child: widget,
          ),
          theme: AppThemeMode.light.getThemeData(locale.fontFamily, supportsEdgeToEdge: true),
          locale: Locale(locale.code),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }

  Future<BuildContext> get setUpLocalizationsContext async {
    late BuildContext result;
    await pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              result = context;
              return Container();
            },
          ),
        ),
      ),
    );
    return result;
  }

  /// Configure the tester view to represent the given view variant.
  void configureView(ViewVariant viewVariant) {
    // view.physicalSize = viewVariant.physicalSize;
    // view.devicePixelRatio = viewVariant.devicePixelRatio;

    view.physicalSize = viewVariant.physicalSize;
    view.devicePixelRatio = viewVariant.devicePixelRatio;

    addTearDown(view.resetPhysicalSize);
    addTearDown(view.resetDevicePixelRatio);
  }

  Future<void> verifyGolden(dynamic actual, Object file) async {
    await precacheImages();
    await expectLater(actual, matchesGoldenFile(file));
  }

  /// Pauses test until images are ready to be rendered.
  Future<void> precacheImages() async {
    final imageElements = find.byType(Image, skipOffstage: false).evaluate();
    final containerElements = find.byType(DecoratedBox, skipOffstage: false).evaluate();

    await runAsync(() async {
      for (final element in imageElements) {
        final widget = element.widget as Image;
        final image = widget.image;
        await precacheImage(image, element);
      }
      for (final element in containerElements) {
        final widget = element.widget as DecoratedBox;
        final decoration = widget.decoration;
        if (decoration is BoxDecoration) {
          final image = decoration.image?.image;
          if (image != null) {
            final isGifImage = image is AssetImage && image.assetName.endsWith('.gif');
            // TODO(AHMED): figure out why precacheImage stuck when loading gif images.
            if (!isGifImage) {
              await precacheImage(image, element);
            }
          }
        }
      }
    });

    await pumpAndSettle();
  }
}
