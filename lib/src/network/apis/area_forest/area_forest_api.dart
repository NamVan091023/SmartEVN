import 'package:dio/dio.dart';
import 'package:pollution_environment/src/model/area_forest_model.dart';
import 'package:pollution_environment/src/model/base_response.dart';
import 'package:pollution_environment/src/network/api_service.dart';

class AreaForestAPIPath {
  static String getAreaForest = "/area-forest";
}

class AreaForestAPI {
  late APIService apiService;

  AreaForestAPI() {
    apiService = APIService();
  }

  Future<List<AreaForestModel>> getAreaForest() async {
    Response response;
    try {
      response = await apiService.request(
        method: APIMethod.GET,
        endPoint: AreaForestAPIPath.getAreaForest,
      );

      BaseArrayResponse baseResponse;
      baseResponse = BaseArrayResponse.fromJson(response.data);
      if (baseResponse.data == null) {
        throw Exception(baseResponse.message);
      } else {
        List<AreaForestModel> data = <AreaForestModel>[];
        baseResponse.data?.forEach((v) {
          data.add(new AreaForestModel.fromJson(v));
        });
        return data;
      }
    } on DioError catch (e) {
      throw (e);
    }
  }
}
