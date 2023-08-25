import 'package:file/file.dart' as f;
import 'package:file/local.dart' as l;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform/platform.dart' as p;

Future<void> goldenTestConfig() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await _loadPoppinsFont();
  await _loadMaterialIconFont();
}

/// Load Poppins font.
///
/// By default, flutter test only uses a single "test" font called Ahem. This font is designed
/// to show black spaces for every character and icon. This obviously makes goldens much less valuable
/// if you are trying to verify that your app looks correct.
///
/// Note: Poppins works only for Material (free). For Cupertino, you will need to include copies
/// of [.SF UI Text], [.SF UI Display], [.SF Pro Text] and [.SF Pro Display] in your package's yaml.
/// It's not included in this package for licensing reasons.
Future<void> _loadPoppinsFont() async {
  final font = rootBundle.load('assets/fonts/Poppins-Regular.ttf');
  final fontLoader = FontLoader('Poppins')..addFont(font);
  await fontLoader.load();
}

/// Loads the cached material icon font.
/// Only necessary for golden tests. Relies on the tool updating cached assets
/// before running tests. More info here:
/// https://stackoverflow.com/questions/65191069/golden-tests-with-custom-icon-font-class
Future<void> _loadMaterialIconFont() async {
  const f.FileSystem fs = l.LocalFileSystem();
  const p.Platform platform = p.LocalPlatform();
  final flutterRoot = fs.directory(platform.environment['FLUTTER_ROOT']);

  final iconFont = flutterRoot.childFile(
    fs.path.join(
      'bin',
      'cache',
      'artifacts',
      'material_fonts',
      'MaterialIcons-Regular.otf',
    ),
  );

  final bytes = Future<ByteData>.value(iconFont.readAsBytesSync().buffer.asByteData());

  await (FontLoader('MaterialIcons')..addFont(bytes)).load();
}
