import 'package:flutter/material.dart';

bool chipMatcher(Widget widget, String name) {
  if (widget is ChoiceChip) {
    final chipText = widget.label as Text;
    return chipText.data == name;
  }
  return false;
}
