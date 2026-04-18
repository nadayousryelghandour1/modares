import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

Future<void> loadLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final code = prefs.getString('lang');

  if (code != null) {
    _locale = Locale(code);
  } else {
    // 👇 ياخد لغة السيستم
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    _locale = Locale(systemLocale.languageCode);
  }

  notifyListeners();
}
}