import 'dart:math';
import 'package:flutter/widgets.dart';

/// Applies a [Transform.rotate] to [child], using an angle in degrees.
class ZRotatedWidget extends StatelessWidget {
  const ZRotatedWidget({required this.child, required this.angleInDegrees});

  final Widget child;
  final double angleInDegrees;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _degreesToRadians(angleInDegrees),
      child: child,
    );
  }

  double _degreesToRadians(double degrees) => (pi / 180) * degrees;
}
