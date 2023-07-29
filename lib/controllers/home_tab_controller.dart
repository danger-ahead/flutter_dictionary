import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tab_controller.g.dart';

@riverpod
class Counter extends _$Counter {
  /// Classes annotated by `@riverpod` **must** define a [build] function.
  /// This function is expected to return the initial state of your shared state.
  /// It is totally acceptable for this function to return a [Future] or [Stream] if you need to.
  /// You can also freely define parameters on this method.
  @override
  int build() => 0;

  void increment() => state++;
}
