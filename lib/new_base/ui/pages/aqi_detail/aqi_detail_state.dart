part of 'aqi_detail_cubit.dart';

class AqiDetailState extends Equatable {
  final LoadStatus loadDataStatus;
  final int reCommentType;
  final String? recommend;
  final WAQIIpResponse? wAqiIpResponse;

  const AqiDetailState({
    this.loadDataStatus = LoadStatus.initial,
    this.reCommentType = 0,
    this.recommend,
    this.wAqiIpResponse,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        reCommentType,
        recommend,
    wAqiIpResponse,
      ];

  AqiDetailState copyWith({
    LoadStatus? loadDataStatus,
    int? reCommentType,
    String? recommend,
    WAQIIpResponse? wAqiIpResponse,
  }) {
    return AqiDetailState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      reCommentType: reCommentType ?? this.reCommentType,
      recommend: recommend ?? this.recommend,
      wAqiIpResponse: wAqiIpResponse ?? this.wAqiIpResponse,
    );
  }
}
