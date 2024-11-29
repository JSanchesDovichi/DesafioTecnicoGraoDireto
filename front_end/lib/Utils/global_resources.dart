import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Resources {
  static final Resources _singleton = Resources._internal();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  static bool isDark = false;
  static final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light);

  factory Resources() {
    return _singleton;
  }

  Resources._internal();
}
