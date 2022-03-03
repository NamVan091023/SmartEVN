import 'package:get/get.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/pollution/pollution_api.dart';
import 'package:pollution_environment/src/network/apis/users/user_api.dart';

class DetailPollutionController extends GetxController {
  late String pollutionId = Get.arguments;
  Rxn<UserModel> user = Rxn<UserModel>();
  Rxn<PollutionModel> pollutionModel = Rxn<PollutionModel>();
  @override
  void onInit() {
    super.onInit();
    getPollution();
  }

  void getPollution() async {
    pollutionModel.value =
        await PollutionApi().getOnePollution(id: pollutionId);
    getUser();
  }

  void getUser() async {
    if (pollutionModel.value?.user != null) {
      user.value = await UserAPI().getUserById(pollutionModel.value!.user!);
    }
  }
}
