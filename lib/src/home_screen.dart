import 'package:flutter/material.dart';
import 'package:secure_application/secure_application.dart';
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

  void setLoader(bool status) {
    authLoader = status;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final secureApplicationController = SecureApplicationProvider.of(context);
    return SecureGate(
      lockedBuilder: (context, secureApplicationController) {
        return Center(
          child: authLoader
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setLoader(true);
                    final success = await BiometricAuth().auth();
                    setLoader(false);
                    if (success) {
                      secureApplicationController?.authSuccess(unlock: true);
                    } else {
                      secureApplicationController?.authFailed();
                    }
                  },
                  child: const Text("UNLOCK"),
                ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Security"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("ACCOUNT NO."),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () => secureApplicationController?.lock(),
                child: const Text("LOCK"),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  secureApplicationController?.secured ?? false
                      ? secureApplicationController?.open()
                      : secureApplicationController?.secure();
                  setState(() {});
                },
                child: secureApplicationController?.secured ?? false
                    ? const Text("UNSECURE")
                    : const Text("SECURE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
