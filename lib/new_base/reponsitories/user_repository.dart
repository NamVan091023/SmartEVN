import 'package:pollution_environment/new_base/network/api_client.dart';

abstract class IUserRepository {
  void getUserInfo();
}

class UserRepository extends IUserRepository {
  ApiClient apiClient;

  UserRepository(this.apiClient);

  @override
  void getUserInfo() {

  }
}


class UserFireBaseRepository extends IUserRepository {
  @override
  void getUserInfo() {
    // TODO: implement getUserInfo
  }

}
