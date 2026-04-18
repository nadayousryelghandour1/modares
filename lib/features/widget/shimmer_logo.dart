import 'package:flutter/material.dart';

class ShimmerLogo extends StatefulWidget {
  final Widget child;

  const ShimmerLogo({super.key, required this.child});

  @override
  State<ShimmerLogo> createState() => _ShimmerLogoState();
}

class _ShimmerLogoState extends State<ShimmerLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(
      begin: -1.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.3, 0.5, 0.7],
              colors: [
                Colors.transparent,
                Colors.white.withOpacity(0.6),
                Colors.transparent,
              ],
              transform: GradientRotation(1.5),
            ).createShader(
              Rect.fromLTWH(
                rect.width * _animation.value,
                0,
                rect.width,
                rect.height,
              ),
            );
          },
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
