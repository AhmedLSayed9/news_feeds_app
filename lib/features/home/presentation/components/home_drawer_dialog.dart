import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/helpers/localization_helper.dart';
import '../../../../core/presentation/routing/navigation_service.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../../../../core/presentation/widgets/custom_elevated_button.dart';
import '../../../../core/presentation/widgets/dialogs.dart';

Future<void> showSectionDialog(BuildContext ctx, String sectionName) async {
  await Dialogs.showGeneralDialog(
    ctx,
    contentPadding: const EdgeInsets.symmetric(
      vertical: Sizes.dialogPaddingV36,
      horizontal: Sizes.dialogPaddingH24,
    ),
    content: (context) => Text(
      sectionName,
      style: TextStyles.f20(context).copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
      textAlign: TextAlign.center,
    ),
    materialActions: _confirmButtonsMaterial,
    cupertinoActions: _confirmButtonsCupertino,
  );
}

List<Widget> _confirmButtonsMaterial(BuildContext context) {
  return [
    CustomElevatedButton(
      onPressed: () => NavigationService.popDialog(context),
      constraints: const BoxConstraints(minWidth: 160),
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.buttonPaddingV6,
        horizontal: Sizes.buttonPaddingH24,
      ),
      child: Text(
        tr(context).oK,
        style: TextStyles.coloredElevatedButton(context),
        textAlign: TextAlign.center,
      ),
    ),
  ];
}

List<CupertinoDialogAction> _confirmButtonsCupertino(BuildContext context) {
  return [
    CupertinoDialogAction(
      onPressed: () => NavigationService.popDialog(context),
      child: Text(
        tr(context).oK,
        style: TextStyles.cupertinoDialogAction(context),
        textAlign: TextAlign.center,
      ),
    ),
  ];
}
