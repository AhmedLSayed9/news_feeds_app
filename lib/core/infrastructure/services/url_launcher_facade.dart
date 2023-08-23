import 'package:url_launcher/url_launcher.dart';

import '../../presentation/utils/riverpod_framework.dart';
import '../local/extensions/local_error_extension.dart';

part 'url_launcher_facade.g.dart';

@Riverpod(keepAlive: true)
UrlLauncherFacade urlLauncherFacade(UrlLauncherFacadeRef ref) {
  return UrlLauncherFacade();
}

class UrlLauncherFacade {
  UrlLauncherFacade();

  Future<bool> openUrl(String url) async {
    return _errorHandler(
      () async {
        final uri = Uri.parse(url);
        return launchUrl(uri);
      },
    );
  }

  static Future<T> _errorHandler<T>(Future<T> Function() body) async {
    try {
      return await body.call();
    } catch (e, st) {
      final error = e.localErrorToCacheException();
      throw Error.throwWithStackTrace(error, st);
    }
  }
}
