import 'package:flutter/widgets.dart';

import '../../core/init/app_locator.dart';
import 'base_screen_controller.dart';
import 'base_screen_view.dart';

mixin BaseScreenWidgetMixin<C extends BaseScreenController> on Widget {
  C getController(BuildContext context) {
    final State? ancestorBaseViewState = context.findAncestorStateOfType<State<BaseScreenView<C>>>();
    assert(ancestorBaseViewState != null, '\n\ncontext.findAncestorStateOfType could not find the state of ${BaseScreenWidgetMixin<C>}.'
        // '\n\nMake sure you use ${BaseScreenView<C, BaScreenArgs} before using any ${BaseScreenWidgetMixin<C>}\n',
        );

    return ControllerLocator.get<C>(ancestorBaseViewState.hashCode);
  }
}
