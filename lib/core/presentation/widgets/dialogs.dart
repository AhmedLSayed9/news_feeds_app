import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../helpers/localization_helper.dart';
import '../routing/navigation_service.dart';
import '../styles/styles.dart';
import 'loading_widgets.dart';
import 'platform_widgets/platform_alert_dialog.dart';

abstract class Dialogs {
  static const _defaultTitlePadding = EdgeInsets.symmetric(
    vertical: Sizes.dialogPaddingV20,
    horizontal: Sizes.dialogPaddingH24,
  );

  static const _defaultContentPadding = EdgeInsets.symmetric(
    vertical: Sizes.dialogPaddingV20,
    horizontal: Sizes.dialogPaddingH24,
  );

  static const _defaultMaterialInsetPadding = EdgeInsets.symmetric(
    horizontal: Sizes.marginH28,
  );

  static RoundedRectangleBorder get _defaultMaterialShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.dialogR20),
      );

  static Future<T?> showLoadingDialog<T extends Object?>(BuildContext context) async {
    return showPlatformAlertDialog(
      context: context,
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(
        vertical: Sizes.dialogPaddingV28,
        horizontal: Sizes.dialogPaddingH24,
      ),
      content: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TitledLoadingIndicator(message: tr(context).loading),
        ],
      ),
      materialDialogData: MaterialDialogData(
        insetPadding: const EdgeInsets.symmetric(horizontal: 72),
        shape: _defaultMaterialShape,
      ),
    );
  }

  static Future<void> showSuccessDialog<T extends Object?>(
    BuildContext context, {
    required String message,
    List<Widget>? materialActions,
    List<CupertinoDialogAction> cupertinoActions = const [],
  }) async {
    unawaited(
      showPlatformAlertDialog(
        context: context,
        barrierDismissible: false,
        contentPadding: _defaultContentPadding.copyWith(
          top: 72,
          bottom: 72,
        ),
        content: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyles.dialogSuccess(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        materialDialogData: MaterialDialogData(
          insetPadding: const EdgeInsets.symmetric(horizontal: 64),
          shape: _defaultMaterialShape,
          actions: (context) => materialActions,
          actionsPadding: _defaultTitlePadding,
        ),
        cupertinoDialogData: CupertinoDialogData(
          actions: (context) => cupertinoActions,
        ),
      ),
    );
    await Future<void>.delayed(const Duration(seconds: 2));
    if (context.mounted) await NavigationService.popDialog(context);
  }

  static Future<T?> showGeneralDialog<T extends Object?>(
    BuildContext context, {
    Widget? title,
    Widget Function(BuildContext context)? content,
    EdgeInsetsGeometry contentPadding = _defaultContentPadding,
    Color? backgroundColor,
    List<Widget>? Function(BuildContext context)? materialActions,
    List<CupertinoDialogAction> Function(BuildContext context)? cupertinoActions,
  }) async {
    return showPlatformAlertDialog(
      context: context,
      titlePadding: _defaultTitlePadding,
      title: title,
      contentPadding: contentPadding,
      content: content != null
          ? (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [content(context)],
              )
          : null,
      materialDialogData: MaterialDialogData(
        insetPadding: _defaultMaterialInsetPadding,
        shape: _defaultMaterialShape,
        actions: (context) => materialActions?.call(context),
        actionsPadding: _defaultTitlePadding,
        backgroundColor: backgroundColor,
      ),
      cupertinoDialogData: CupertinoDialogData(
        actions: (context) => cupertinoActions?.call(context) ?? [],
      ),
    );
  }
}
