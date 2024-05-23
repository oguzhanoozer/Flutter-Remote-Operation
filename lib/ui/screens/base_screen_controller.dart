import 'package:flutter/widgets.dart';

import '../../core/models/rx.dart';
import '../../core/routing/app_navigation.dart';
import '../../core/utils/app_logger.dart';

abstract base class BaseScreenController with WidgetsBindingObserver {
  final ViewState viewState = ViewState();
  final Rxn<BuildContext> context = Rxn<BuildContext>();

  BaseScreenController();

  @mustCallSuper
  Future<void> onInitState() async {
    AppLogger.debug(runtimeType);
  }

  @mustCallSuper
  void onDispose() {
    AppLogger.debug(runtimeType);
  }

  void pop([void Function()? f]) {
    AppNavigation.popRoute(context()).then((_) => f?.call());
  }

  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}
}

final class ViewState {
  /// View has been created and appears on the screen.
  /// But it is inaccessible.
  /// There is a progress indicator layer at the top of stack.
  final Rx<bool> _busy = Rx<bool>(false);

  /// view may not have been created yed. A skeleton view appears on the screen.
  final Rx<bool> _loading = Rx<bool>(false);

  Rx<bool> get isBusy => _busy;
  void setBusy(bool status) => _busy(set: () => status);

  Rx<bool> get isLoading => _loading;
  void setLoading(bool status) => _loading(set: () => status);
}
