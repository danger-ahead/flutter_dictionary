import 'package:flutter_riverpod/flutter_riverpod.dart';

final primaryViewController =
    StateNotifierProvider<PrimaryView, PrimaryViewState>((ref) {
  return PrimaryView();
});

class PrimaryViewState {
  PrimaryViewState({this.showClearButton = false});
  bool showClearButton;
}

class PrimaryView extends StateNotifier<PrimaryViewState> {
  PrimaryView() : super(PrimaryViewState());

  void setPrimaryViewState({bool? showClearButton}) {
    state = PrimaryViewState(showClearButton: showClearButton ?? false);
  }
}
