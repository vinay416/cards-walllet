import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

class JailbreakedUI extends StatelessWidget {
  const JailbreakedUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Jailbreak detected on this device.",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "To use this App device needs to be secure",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
              ),
              onPressed: () {
                FlutterExitApp.exitApp(iosForceExit: true);
              },
              child: const Text(
                "CLOSE APP",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
