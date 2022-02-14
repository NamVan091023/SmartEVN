import 'package:dio/dio.dart';
import 'package:pollution_environment/src/model/address_model.dart';
import 'package:pollution_environment/src/network/api_service.dart';

class AddressAPIPath {
  static String getAddress = "/address";
}

class AddressApi {
  late APIService apiService;

  AddressApi() {
    apiService = APIService();
  }

  Future<AddressModel> getAllAddress() async {
    Response response;

    try {
      response = await apiService.request(
        method: APIMethod.GET,
        endPoint: AddressAPIPath.getAddress,
      );
      AddressModel data = AddressModel.fromJson(response.data!);
      return data;
    } on DioError catch (e) {
      throw (e);
    }
  }
}
