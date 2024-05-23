import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/configs/constants/app_size.dart';
import '../../core/routing/app_navigation.dart';

const double _kRadius = 8;
const double _kElevation = 0;

abstract base class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    this.routeName,
  });

  final String? routeName;

  double get radius => _kRadius;

  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: _kElevation,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppSize.padding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: builder(context),
    );
  }

  void pop(BuildContext context, [void Function()? f]) {
    Navigator.of(context).pop<void>();
    f?.call();
  }

  Future<void> show([BuildContext? context, bool dismissible = true]) async {
    context = AppNavigation.rootNavigatorKey.currentState?.context;

    if (context != null && context.mounted) {
      await showDialog(
        context: context,
        barrierDismissible: dismissible,
        useRootNavigator: false,
        routeSettings: RouteSettings(name: routeName),
        builder: (BuildContext context) => this,
      );
    }
  }
}
