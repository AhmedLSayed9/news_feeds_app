import 'package:flutter/material.dart';

class RRectClipper extends CustomClipper<Path> {
  const RRectClipper({this.borderRadius = BorderRadius.zero});

  final BorderRadius borderRadius;

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomRight: borderRadius.bottomRight,
      bottomLeft: borderRadius.bottomLeft,
    );
    return Path()..addRRect(rrect);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
