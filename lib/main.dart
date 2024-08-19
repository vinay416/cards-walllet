import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_application/secure_application.dart';
import 'package:security/add_card/add_card_view.dart';
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
        home: const AddCardView(),
        builder: (context, child) {
          return SecureApplication(
            child: child!,
            onNeedUnlock: (secureApplicationStateNotifier) async {
              // var authResult = await auth(
              //       askValidation: () => askValidation(context, child),
              //       validationForFaceOnly: false);
              // if (false) {
              //   // secureApplicationStateNotifier?.authSuccess(unlock: true);
              // } else {
              //   // secureApplicationStateNotifier?.authFailed(unlock: false);
              //   return SecureApplicationAuthenticationStatus.FAILED;
              //   // secureApplicationStateNotifier?.open();
              // }
              return null;
            },
          );
        },
      ),
    );
  }
}
