import 'package:flutter/material.dart';
import 'package:secure_application/secure_application.dart';
import 'package:security/all_cards/all_cards_view.dart';
import 'package:security/src/biometric_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool authLoader = false;
  SecureApplicationController? secureApplicationController;

  @override
  void didChangeDependencies() {
    secureApplicationController = SecureApplicationProvider.of(context);
    secureApplicationController?.secure();
    super.didChangeDependencies();
  }

  void setLoader(bool status) {
    authLoader = status;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SecureGate(
      lockedBuilder: (context, secureApplicationController) {
        return Center(
          child: authLoader
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.brown),
                  ),
                  onPressed: onUnlock,
                  child: const Text(
                    "UNLOCK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        );
      },
      child: const AllCardsView(),
    );
  }

  void onUnlock() async {
    setLoader(true);
    final success = await BiometricAuth().auth();
    setLoader(false);
    if (success) {
      secureApplicationController?.authSuccess(unlock: true);
    } else {
      secureApplicationController?.authFailed();
    }
  }

  @override
  void dispose() {
    secureApplicationController?.dispose();
    super.dispose();
  }
}
