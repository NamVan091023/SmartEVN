part of 'pollution_detail_cubit.dart';

class PollutionDetailState extends Equatable {
  final LoadStatus loadDataStatus;
  final UserModel? userInfo;
  final PollutionModel? pollutionInfo;
  final UserModel? currentUser;
  final List<PollutionModel>? pollutions;
  final WAQIIpResponse? aqiGPS;
  final int? reCommentType;
  final String? recommend;

  const PollutionDetailState({
    this.loadDataStatus = LoadStatus.initial,
    this.userInfo,
    this.pollutionInfo,
    this.currentUser,
    this.pollutions,
    this.aqiGPS,
    this.reCommentType,
    this.recommend,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        userInfo,
        pollutionInfo,
        currentUser,
        pollutions,
        aqiGPS,
        reCommentType,
        recommend,
      ];

  PollutionDetailState copyWith({
    LoadStatus? loadDataStatus,
    UserModel? userInfo,
    PollutionModel? pollutionInfo,
    UserModel? currentUser,
    List<PollutionModel>? pollutions,
    WAQIIpResponse? aqiGPS,
    int? reCommentType,
    String? recommend,
  }) {
    return PollutionDetailState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      userInfo: userInfo ?? this.userInfo,
      pollutionInfo: pollutionInfo ?? this.pollutionInfo,
      currentUser: currentUser ?? this.currentUser,
      pollutions: pollutions ?? this.pollutions,
      aqiGPS: aqiGPS ?? this.aqiGPS,
      reCommentType: reCommentType ?? this.reCommentType,
      recommend: recommend ?? this.recommend,
    );
  }
}
