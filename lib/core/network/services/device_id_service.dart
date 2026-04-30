// device_id.dart

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

const _key = 'deviceId_v1';
const _storage = FlutterSecureStorage();

// ─── Layer 1: SharedPreferences ────────────────────────────────────────────

Future<String?> _readFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_key);
}


Future<String?> _readFromSecureStorage() async {
  try {
    return await _storage.read(key: _key);
  } catch (_) {
    return null;
  }
}


Future<void> _persistId(String id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_key, id);
  try {
    await _storage.write(key: _key, value: id);
  } catch (_) {}
}


Future<String> _computeFingerprint() async {
  final deviceInfo = DeviceInfoPlugin();
  final signals = StringBuffer();

  try {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final info = await deviceInfo.androidInfo;
      signals.writeAll([
        info.brand,
        info.model,
        info.device,
        info.hardware,
        info.id,             // Build fingerprint
        info.version.sdkInt,
      ], '||');
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final info = await deviceInfo.iosInfo;
      signals.writeAll([
        info.model,
        info.utsname.machine,
        info.identifierForVendor ?? '',
        info.systemVersion,
      ], '||');
    }
  } catch (_) {}

  final bytes = utf8.encode(signals.toString());
  final hash  = sha256.convert(bytes).toString();
  return 'fp_$hash';
}


Future<String> getDeviceId() async {
  final fromPrefs = await _readFromPrefs();
  if (fromPrefs != null) return fromPrefs;

  final fromSecure = await _readFromSecureStorage();
  if (fromSecure != null) {
    await _persistId(fromSecure); 
    return fromSecure;
  }

  final fp  = await _computeFingerprint();
  final id  = 'dev_${const Uuid().v4()}_${fp.substring(3, 11)}';
  await _persistId(id);
  return id;
}


Future<String> getFingerprint() => _computeFingerprint();