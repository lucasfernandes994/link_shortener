import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

extension ValueNotifierExtensions<T> on ValueNotifier<T> {
  void setValue(T value) {
    this.value = value;
  }

  void update(UpdateFunc<T> updateFunc) {
    final newValue = updateFunc(value);
    if (value != newValue) this.setValue(updateFunc(value));
  }
}

typedef UpdateFunc<T> = T Function(T);

extension ValueListenableExtensions<T> on ValueListenable<T> {
  Widget observer({required ValueWidgetBuilder<T> builder}) {
    return ValueListenableBuilder<T>(
      valueListenable: this,
      builder: builder,
    );
  }
}