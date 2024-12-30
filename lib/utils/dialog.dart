import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class DialogUtils {
  static void showBottomToast(String message) {
    SmartDialog.showToast(
      message,
      displayType: SmartToastType.onlyRefresh,
      alignment: const Alignment(0, 0.8),
    );
  }
}
