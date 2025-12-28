// lib/src/state/language_controller.dart
import 'package:flutter/material.dart';

class LanguageController extends ValueNotifier<bool> {
  LanguageController({bool initialIsArabic = false}) : super(initialIsArabic);

  bool get isArabic => value;

  void toggle() => value = !value;

  String t(String en, String ar) => isArabic ? ar : en;
}

class LanguageScope extends InheritedNotifier<LanguageController> {
  const LanguageScope({
    super.key,
    required LanguageController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static LanguageController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LanguageScope>();
    assert(scope != null, 'LanguageScope not found. Wrap MaterialApp with LanguageScope.');
    return scope!.notifier!;
  }
}
