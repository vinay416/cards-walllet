import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:security/view_model/cards_view_model.dart';

class CardsPaginationLoader extends StatelessWidget {
  const CardsPaginationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CardsViewModel, (bool, bool)>(
      builder: (context, values, child) {
        final bool paginating = values.$1;
        final bool allCardsLoaded = values.$2;

        if (allCardsLoaded) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("All Cards Loaded"),
            ),
          );
        }

        if (paginating) {
          return LoadingBouncingLine.circle(
            backgroundColor: Colors.white,
            size: 50,
          );
        }

        return const SizedBox.shrink();
      },
      selector: (p0, p1) => (p1.paginating, p1.allCardsLoaded),
    );
  }
}
