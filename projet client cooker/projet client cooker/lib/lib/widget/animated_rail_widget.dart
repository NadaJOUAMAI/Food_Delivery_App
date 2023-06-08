import 'package:flutter/material.dart';

class AnimatedRailWidget extends StatelessWidget {
  final Widget child;

  const AnimatedRailWidget({   //affiche un bouton flottant avec une animation en 
                                     //utilisant la fonctionnalité de NavigationRail
    required this.child,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = NavigationRail.extendedAnimation(context);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Container(
        height: 56,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.red,
            label: child!,
            isExtended: animation.status != AnimationStatus.dismissed,
            onPressed: () {},
          ),
        ),
      ),
      child: child,
    );
  }
}
