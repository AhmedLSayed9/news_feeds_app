import '../../../../core/infrastructure/services/url_launcher_facade.dart';
import '../../../../core/presentation/providers/provider_utils.dart';
import '../../../../core/presentation/utils/event.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';

part 'open_website_provider.g.dart';

@riverpod
FutureOr<Option<Unit>> openWebsiteState(OpenWebsiteStateRef ref) {
  final event = ref.watch(openWebsiteEventProvider);
  return event.match(
    () => const None(),
    (event) =>
        ref.watch(urlLauncherFacadeProvider).openUrl(event.arg).then((_) => const Some(unit)),
  );
}

@riverpod
class OpenWebsiteEvent extends _$OpenWebsiteEvent with NotifierUpdate {
  @override
  Option<Event<String>> build() => const None();
}
