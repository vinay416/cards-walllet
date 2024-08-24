import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

mixin OverlayLoaderMixin {
  late OverlayEntry _overlayEntry;

  void showFullLoader(BuildContext context) {
    OverlayState overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Container(
          color: Colors.black54,
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: LoadingBouncingGrid.square(
              backgroundColor: Colors.white,
            ),
          ),
        );
      },
    );

    overlay.insert(_overlayEntry);
  }

  void hideFullLoader() => _overlayEntry.remove();
}
