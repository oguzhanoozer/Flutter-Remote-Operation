import 'package:flutter/widgets.dart';

import '../../core/models/rx.dart';

@optionalTypeArgs
final class Obx<T extends RxBase> extends StatelessWidget {
  const Obx._({
    super.key,
    required this.listenable,
    required this.builder,
    this.child,
  });

  factory Obx(
    T value, {
    Key? key,
    required Widget Function(BuildContext context, T value, Widget? child) builder,
    Widget? child,
  }) {
    return Obx._(
      key: key,
      listenable: value,
      builder: (BuildContext context, Widget? child) => builder(context, value, child),
      child: child,
    );
  }

  factory Obx.multiple(
    List<RxBase> values, {
    Key? key,
    required Widget Function(BuildContext context, Widget? child) builder,
    Widget? child,
  }) {
    return Obx._(
      key: key,
      listenable: Listenable.merge(values),
      builder: builder,
      child: child,
    );
  }

  final Listenable listenable;
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: listenable,
      builder: builder,
      child: child,
    );
  }
}
