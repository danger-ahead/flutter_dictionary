import 'package:flutter_dictionary/services/package_info_respository_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final packageInfoRepositoryController =
    StateNotifierProvider<PackageInfoRepositoryController, bool>(
        (ref) => PackageInfoRepositoryController());

class PackageInfoRepositoryController extends StateNotifier<bool> {
  PackageInfoRepositoryController() : super(false);

  Future<PackageInfo> getPackageInfo(FutureProviderRef ref) async {
    final data =
        await ref.watch(packageInfoRepositoryProvider).fetchPackageInfo();
    return data;
  }
}
