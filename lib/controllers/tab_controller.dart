import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabController = StateNotifierProvider<TabController, int>((ref) {
  return TabController();
});

class TabController extends StateNotifier<int> {
  TabController() : super(0);

  void setTabIndex(int index) {
    state = index;
  }
}
