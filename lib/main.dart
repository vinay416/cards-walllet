import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_application/secure_application.dart';
import 'package:security/src/biometric_auth.dart';
import 'package:security/src/home_screen.dart';

import 'core/cards_local_storage.dart';
import 'view_model/cards_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CardsLocalStorage().loadCardKeys();
  log('BiometricAuth().isAvailable -> ${await BiometricAuth().isAvailable}');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardsViewModel(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: Colors.black),
        ),
        darkTheme: ThemeData(
          colorScheme: const ColorScheme.dark(primary: Colors.white),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return SecureApplication(
            onNeedUnlock: (secureApplicationController) async {
              final success = await BiometricAuth().auth();
              if (success) {
                secureApplicationController?.authSuccess(unlock: true);
              } else {
                secureApplicationController?.authFailed();
              }
              return null;
            },
            child: child!,
          );
        },
      ),
    );
  }
}
