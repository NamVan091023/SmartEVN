import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/model/favorite_model.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/model/waqi/waqi_ip_model.dart';
import 'package:pollution_environment/src/network/apis/waqi/waqi.dart';

class HomeController extends GetxController {
  Rx<UserModel>? currentUser = UserStore().getAuth()?.user?.obs;
  Rxn<WAQIIpResponse> currentAQI = Rxn<WAQIIpResponse>();

  RxList<WAQIIpResponse> favoriteAqis = RxList<WAQIIpResponse>();
  @override
  void onInit() {
    getCurrentAQI();
    getFavorite();
    super.onInit();
  }

  void getCurrentAQI() async {
    currentAQI.value = await WaqiAPI().getAQIByIP();
  }

  void getFavorite() async {
    Box box = Hive.box(HIVEBOX);
    List<Favorite> favorites = box.get(KEY_FAVORITE);
    favorites.forEach((fav) {
      WaqiAPI()
          .getAQIByGPS(fav.lat, fav.lng)
          .then((value) => favoriteAqis.add(value));
    });
  }
}
