import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/model/favorite_model.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/model/waqi/waqi_ip_model.dart';
import 'package:pollution_environment/src/network/apis/waqi/waqi.dart';

class HomeController extends GetxController {
  Rx<UserModel>? currentUser = UserStore().getAuth()?.user?.obs;
  Rxn<WAQIIpResponse> currentAQI = Rxn<WAQIIpResponse>();

  RxMap<String, WAQIIpResponse> favoriteAqis = RxMap<String, WAQIIpResponse>();
  @override
  void onInit() {
    showLoading();
    Future.wait([
      getCurrentAQI(),
      getFavorite(),
    ]).then((value) {
      hideLoading();
    }, onError: (e) {
      hideLoading();
    });
    super.onInit();
  }

  Future<void> getCurrentAQI() async {
    currentAQI.value = await WaqiAPI().getAQIByIP();
  }

  Future<void> getFavorite() async {
    await Hive.openBox<Favorite>(KEY_FAVORITE);
    Box box = Hive.box<Favorite>(KEY_FAVORITE);
    List<Favorite> favorites = box.values.cast<Favorite>().toList();
    favorites.forEach((fav) {
      WaqiAPI().getAQIByGPS(fav.lat, fav.lng).then((value) => favoriteAqis
          .addAll({"${fav.ward}, ${fav.district}, ${fav.province}": value}));
    });
  }

  void removeFavorite(int index) async {
    await Hive.openBox<Favorite>(KEY_FAVORITE);
    Box box = Hive.box<Favorite>(KEY_FAVORITE);
    List<Favorite> favorites = box.values.cast<Favorite>().toList();
    var idx = favorites.indexWhere((fav) =>
        favoriteAqis.keys.toList()[index] ==
        "${fav.ward}, ${fav.district}, ${fav.province}");
    box.deleteAt(idx);
    favoriteAqis.remove(favoriteAqis.keys.toList()[index]);
    favoriteAqis.refresh();
  }
}
