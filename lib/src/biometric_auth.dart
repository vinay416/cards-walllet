// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class BiometricAuth {
  BiometricAuth._();
  static final BiometricAuth _instance = BiometricAuth._();
  factory BiometricAuth() => _instance;

  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> get isAvailable async {
    return await _auth.isDeviceSupported();
  }

  Future<bool> checkJailBreak() async {
    final jailBreak = await FlutterJailbreakDetection.jailbroken;
    log("FlutterJailbreakDetection.jailbroken $jailBreak");
    if (jailBreak) log("Device jailbreaked");
    return jailBreak;
  }

  Future<bool> auth() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Cards Wallet',
        authMessages: [
          const AndroidAuthMessages(
            signInTitle: 'Biometric authentication required!',
            cancelButton: 'No thanks',
          ),
          const IOSAuthMessages(
            cancelButton: 'No thanks',
          ),
        ],
        options: const AuthenticationOptions(
          sensitiveTransaction: false,
        ),
      );
    } catch (e) {
      log("Error while auth $e");
      return false;
    }
  }
}
