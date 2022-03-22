import 'package:get/get.dart';
import 'package:pollution_environment/src/model/area_forest_model.dart';
import 'package:pollution_environment/src/network/apis/area_forest/area_forest_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IQAirController extends GetxController {
  Rx<RefreshController> refreshController = RefreshController().obs;

  RxList<AreaForestModel> areaForests = RxList<AreaForestModel>();

  @override
  void onInit() {
    getAreaForest();
    super.onInit();
  }

  Future<void> getAreaForest() async {
    AreaForestAPI().getAreaForest().then((value) {
      value.sort((a, b) {
        var intA = int.tryParse(a.rank ?? "0") ?? 0;
        var intB = int.tryParse(b.rank ?? "0") ?? 0;
        return intA - intB;
      });
      areaForests.addAll(value);
    });
  }

  Future<void> refresh() async {
    areaForests.value = [];
    await getAreaForest();
  }

  void onRefresh() async {
    await refresh();
    refreshController.value.refreshCompleted();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
