import 'dart:ui' as ui show TextDirection;

import 'package:flutter/widgets.dart';

extension TextEditingControllerDirection on TextEditingController {
  ui.TextDirection estimateDirection() {
    final value = text.trim();
    if (value.isEmpty) return ui.TextDirection.ltr;

    final firstStrong = _firstStrongDirection(value);
    return firstStrong == ui.TextDirection.rtl
        ? ui.TextDirection.rtl
        : ui.TextDirection.ltr;
  }

  ui.TextDirection _firstStrongDirection(String source) {
    final ltrChars = RegExp(r'[A-Za-z0-9]');
    final rtlChars = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]');
    if (rtlChars.hasMatch(source)) {
      final firstRtl = rtlChars.allMatches(source).first.start;
      final firstLtr = ltrChars.hasMatch(source)
          ? ltrChars.allMatches(source).first.start
          : source.length;
      return firstRtl < firstLtr ? ui.TextDirection.rtl : ui.TextDirection.ltr;
    }
    return ui.TextDirection.ltr;
  }
}
