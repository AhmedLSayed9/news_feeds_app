import 'package:flutter/material.dart';

@immutable
class ClipShadow extends StatelessWidget {
  const ClipShadow({
    required this.boxShadow,
    required this.clipper,
    required this.child,
    super.key,
  });

// A list of shadows cast by this box behind the box.
  final List<BoxShadow> boxShadow;

  /// If non-null, determines which clip to use.
  final CustomClipper<Path> clipper;

  /// The [Widget] below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowPainter(
        clipper: clipper,
        boxShadow: boxShadow,
      ),
      child: ClipPath(
        clipper: clipper,
        child: child,
      ),
    );
  }
}

class _ClipShadowPainter extends CustomPainter {
  const _ClipShadowPainter({required this.clipper, required this.boxShadow});

  final CustomClipper<Path> clipper;
  final List<BoxShadow> boxShadow;

  @override
  void paint(Canvas canvas, Size size) {
    for (final shadow in boxShadow) {
      final spreadSize = Size(
        size.width + shadow.spreadRadius * 2,
        size.height + shadow.spreadRadius * 2,
      );
      final clipPath = clipper.getClip(spreadSize).shift(
            Offset(
              shadow.offset.dx - shadow.spreadRadius,
              shadow.offset.dy - shadow.spreadRadius,
            ),
          );
      final paint = shadow.toPaint();
      canvas.drawPath(clipPath, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
