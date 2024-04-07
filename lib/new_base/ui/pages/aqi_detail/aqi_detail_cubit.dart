import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pollution_environment/new_base/models/entities/waqi_ip_model.dart';
import 'package:pollution_environment/new_base/models/enums/load_status.dart';
import 'package:pollution_environment/new_base/repositories/aqi_repository.dart';
import 'package:pollution_environment/services/commons/recommend.dart';

part 'aqi_detail_state.dart';

class AqiDetailCubit extends Cubit<AqiDetailState> {
  late AqiRepository aqiRepository;

  AqiDetailCubit(
    this.aqiRepository,
  ) : super(const AqiDetailState());

  Future<void> getAqi(int id) async {
    emit(
      state.copyWith(
        loadDataStatus: LoadStatus.loading,
      ),
    );
    try {
      final result = await aqiRepository.getAQIById(id);

      if (result != null) {
        emit(
          state.copyWith(
            loadDataStatus: LoadStatus.success,
            recommend: RecommendAQI.effectHealthy(result.data?.aqi ?? 0),
          ),
        );
      } else {
        emit(state.copyWith(loadDataStatus: LoadStatus.failure));
      }
    } catch (error) {
      emit(state.copyWith(
        loadDataStatus: LoadStatus.failure,
      ));
    }
  }

  void changeRecommend(int recommendId) {
    if (recommendId == 0) {
      // Sức khỏe
      state.copyWith(
        reCommentType: 0,
        recommend: RecommendAQI.effectHealthy(
          state.wAqiIpResponse?.data?.aqi ?? 0,
        ),
      );
    } else if (recommendId == 1) {
      // Người bình thường
      state.copyWith(
        reCommentType: 1,
        recommend: RecommendAQI.actionNormalPeople(
          state.wAqiIpResponse?.data?.aqi ?? 0,
        ),
      );
    } else {
      state.copyWith(
        recommend: RecommendAQI.actionSensitivePeople(
          state.wAqiIpResponse?.data?.aqi ?? 0,
        ),
      );
    }
  }
}
