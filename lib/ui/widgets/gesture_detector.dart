import 'package:flutter/widgets.dart';

class CustomGestureDetector extends StatefulWidget {
  const CustomGestureDetector({
    super.key,
    required this.child,
    this.onTap,
    this.hasOpacityAnimation = false,
  });

  final Widget child;
  final void Function()? onTap;
  final bool hasOpacityAnimation;

  @override
  State<CustomGestureDetector> createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  final Duration animationDuration = const Duration(milliseconds: 100);
  final double scaleRatio = 0.90;
  final double opacityRatio = 0.33;
  double scaleValue = 1;
  double opacityValue = 1;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: animationDuration);

    if (widget.onTap != null) {
      animationController.addListener(() {
        setState(() {
          if (widget.hasOpacityAnimation) {
            opacityValue = 1 - (animationController.value * (1 - opacityRatio));
          }
          scaleValue = 1 - (animationController.value) * (1 - scaleRatio);
        });
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => animationController.forward(),
      onPointerUp: (_) => animationController.reverse(),
      child: Transform.scale(
        scale: scaleValue,
        child: AnimatedOpacity(
          opacity: opacityValue,
          duration: animationDuration,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onTap,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
