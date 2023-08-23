part of '../utils/riverpod_framework.dart';

extension AsyncValueExtension<T> on AsyncValue<T> {
  /* Widget easyWhen({required Widget Function(T data) data}) {
    return when(
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => MyErrWidget(err),
      data: data,
    );
  } */
}
