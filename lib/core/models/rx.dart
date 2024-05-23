import 'package:flutter/foundation.dart';

final class Rx<T> extends RxBase<T> {
  Rx(super.value);
}

final class Rxn<T> extends RxBase<T?> {
  Rxn([super.value]);
}

@optionalTypeArgs
abstract final class RxBase<T> extends ValueNotifier<T> {
  RxBase(super.value);

  /// ```
  /// final Rx<List<int>> numbers = Rx<List<int>>(<int>[]);
  /// numbers.add(5);
  /// numbers.refresh();
  /// ```
  void refresh() {
    notifyListeners();
  }

  /// ```
  /// final class UserModel {
  ///   int age;
  ///
  ///   UserModel({required this.age});
  /// }
  ///
  /// final Rx<UserModel> user = Rx<UserModel>(UserModel(age: 20));
  /// user.update((UserModel user) {
  ///   user.age = 25;
  ///   return user;
  /// });
  /// ```
  void update(T Function(T value) f) {
    value = f(value);
    refresh();
  }

  /// ```
  /// final Rxn<int> counter = Rxn<int>(10);
  ///
  /// print(counter.value); // Prints 10.
  /// print(counter()); // Prints 10.
  ///
  /// counter(set: () => 15);
  /// print(counter.value); // Prints 15.
  /// print(counter()); // Prints 15.
  ///
  /// final int? a = counter(); // a is 15.
  /// final int? b = counter(set: () => 20); // b is 20.
  /// ```
  T call({T Function()? set}) {
    if (set != null) {
      value = set();
    }
    return value;
  }
}
