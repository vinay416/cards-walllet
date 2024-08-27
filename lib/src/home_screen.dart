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

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool authLoader = false;
  SecureApplicationController? secureApplicationController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    secureApplicationController = SecureApplicationProvider.of(context);
    secureApplicationController?.lock();
    super.didChangeDependencies();
  }

  void setLoader(bool status) {
    authLoader = status;
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        secureApplicationController?.lock();
        secureApplicationController?.secure();
        break;
      default:
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return SecureGate(
      lockedBuilder: (context, secureApplicationController) {
        return Center(
          child: authLoader
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: onUnlock,
                  child: const Text("UNLOCK"),
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
