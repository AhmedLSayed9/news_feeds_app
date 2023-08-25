part of 'utils.dart';

// https://medium.com/flutter-community/golden-testing-using-cachednetworkimage-1b488c653af3
class MockCacheManager extends Mock implements CacheManager {
  File? testImageFile;

  @override
  Stream<FileResponse> getFileStream(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool withProgress = false,
  }) async* {
    if (testImageFile != null) yield _fileInfo(testImageFile!, url);

    final data = await rootBundle.load(MyAssets.ASSETS_IMAGES_CORE_PLACEHOLDER_PNG);
    final tempDir = await MemoryFileSystem().systemTempDirectory.createTemp('images');
    testImageFile = tempDir.childFile('test.png');
    testImageFile!
        .writeAsBytesSync(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    yield _fileInfo(testImageFile!, url);
  }

  FileInfo _fileInfo(File file, String url) => FileInfo(
        file, // Path to the asset
        FileSource.Cache, // Simulate a cache hit
        DateTime(2050), // Very long validity
        url, // Source url
      );
}
