import 'package:dio/dio.dart';
import 'package:pollution_environment/src/model/all_polltion.dart';
import 'package:pollution_environment/src/model/facebook_response.dart';
import 'package:pollution_environment/src/model/notification_model.dart';
import 'package:pollution_environment/src/model/pollution_position_model.dart';
import 'package:pollution_environment/src/model/province_data.dart';
import 'package:pollution_environment/src/model/report_response.dart';
import 'package:pollution_environment/src/model/simple_respone.dart';
import 'package:pollution_environment/src/model/user_response.dart';

class PollutionNetwork {
  final client = Dio();
  final url = 'https://60b094c61f26610017ffe81d.mockapi.io/';

  Future<DataFacebook?> getData() async {
    try {
      final response = await client.post(url + 'getDataFacebook');
      if (response.statusCode == 201) {
        return DataFacebook.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<SimpleResult?> loginUser() async {
    try {
      final response = await client.post(url + 'loginUser');
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<SimpleResult?> registerUser() async {
    try {
      final response = await client.post(url + 'registerUser');
      if (response.statusCode == 201) {
        return SimpleResult.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<SimpleResult?> updateUserInfor() async {
    try {
      final response = await client.post(url + 'updateUserInfor');
      if (response.statusCode == 201) {
        return SimpleResult.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<SimpleResult?> removeReport() async {
    try {
      final response = await client.post(url + 'removeReport');
      if (response.statusCode == 201) {
        return SimpleResult.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<PollutionPositionModel?> getPollutionPosition() async {
    try {
      final response = await client.post(url + 'getPollutionPositon');
      if (response.statusCode == 201) {
        return PollutionPositionModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<NotificationModel?> getNotification() async {
    try {
      final response = await client.post(url + 'getNotification');
      if (response.statusCode == 201) {
        return NotificationModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<ReportModel?> getReport() async {
    try {
      final response = await client.post(url + 'getReport');
      if (response.statusCode == 201) {
        return ReportModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<PollutionModel?> getAllInforPollution() async {
    try {
      final response = await client.post(url + 'getAllInforPollution');
      if (response.statusCode == 201) {
        return PollutionModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<SimpleResult?> createReport() async {
    try {
      final response = await client.post(url + 'getReport');
      if (response.statusCode == 201) {
        return SimpleResult.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<ProvinceData?> getAirVisualData(String province) async {
    try {
      final response = await client.get(
          "http://api.airvisual.com/v2/city?city=${province}&state=Hanoi&country=Vietnam&key=05c2b979-364d-4827-8c13-cdac8a5b5b8f");

      if (response.statusCode == 200) {
        return ProvinceData.fromJson(response.data);
      } else {}
    } catch (error) {
      print(error);
    }
  }
}
