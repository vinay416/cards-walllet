import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_application/secure_application.dart';
import 'package:security/add_card/add_card_view.dart';
import 'package:security/all_cards/all_cards_view.dart';
import 'package:security/src/biometric_auth.dart';

import 'view_model/cards_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          colorScheme: ColorScheme.light(primary: Colors.brown),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.dark(primary: Colors.brown),
        ),
        home: const AllCardsView(),
        builder: (context, child) {
          return SecureApplication(
            child: child!,
          );
        },
      ),
    );
  }
}
