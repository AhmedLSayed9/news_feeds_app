import 'dart:io';

import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_feeds_app/core/core_features/locale/presentation/utils/app_locale.dart';
import 'package:news_feeds_app/core/core_features/theme/presentation/utils/app_theme.dart';

import 'package:news_feeds_app/core/presentation/utils/riverpod_framework.dart';
import 'package:news_feeds_app/gen/my_assets.dart';

part 'widget_tester_utils.dart';
part 'callback_consumer_widget.dart';
part 'run_golden_tests.dart';
part 'test_variants.dart';
part 'mocks.dart';

ProviderContainer setUpContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );
  addTearDown(container.dispose);
  return container;
}

// Using mockito to keep track of when a provider notify its listeners
class Listener<T> extends Mock {
  void call(T? previous, T value);
}

Listener<T> setUpListener<T>(
  ProviderContainer container,
  ProviderListenable<T> provider, {
  bool fireImmediately = true,
}) {
  final listener = Listener<T>();
  container.listen(provider, listener.call, fireImmediately: fireImmediately);
  return listener;
}

typedef VerifyOnly = VerificationResult Function<T>(
  Mock mock,
  T Function() matchingInvocations,
);

/// Syntax sugar for:
///
/// ```dart
/// verify(mock()).called(1);
/// verifyNoMoreInteractions(mock);
/// ```
VerifyOnly get verifyOnly {
  return <T>(mock, invocation) {
    final result = verify(invocation);
    result.called(1);
    verifyNoMoreInteractions(mock);
    return result;
  };
}

class TestAsyncNotifier<T> extends AsyncNotifier<T> {
  TestAsyncNotifier(this._init);

  final Future<T> Function(AsyncNotifierProviderRef<T> ref) _init;

  @override
  Future<T> build() => _init(ref);

  @override
  set state(AsyncValue<T> value) => super.state = value;
}
