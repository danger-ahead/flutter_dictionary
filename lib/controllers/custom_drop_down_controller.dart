import 'package:flutter_riverpod/flutter_riverpod.dart';

final customDropDownController =
    StateNotifierProvider<CustomDropDownController, String?>((ref) {
  return CustomDropDownController();
});

class CustomDropDownController extends StateNotifier<String?> {
  CustomDropDownController() : super(null);

  void setValue(String? value) {
    state = value;
  }
}
