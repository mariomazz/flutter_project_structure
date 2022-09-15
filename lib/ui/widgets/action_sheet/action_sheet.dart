import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';

class ActionSheet {
  static Future<void> open(BuildContext context, Widget title,
      List<BottomSheetAction> actions) async {
    return showAdaptiveActionSheet<void>(
      context: context,
      title: title,
      androidBorderRadius: 30,
      actions: actions,
      cancelAction: CancelAction(
        title: const Text('Annulla'),
      ),
    );
  }
}
