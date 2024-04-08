import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pollution_environment/new_base/models/entities/pollution_response.dart';
import 'package:pollution_environment/new_base/models/entities/user_response.dart';
import 'package:pollution_environment/new_base/models/entities/waqi_ip_model.dart';
import 'package:pollution_environment/new_base/models/enums/load_status.dart';
import 'package:pollution_environment/services/commons/recommend.dart';


part 'pollution_detail_state.dart';
//
// class PollutionDetailCubit extends Cubit<PollutionDetailState> {
//
//   PollutionDetailCubit() : super(const PollutionDetailState());
//
//   Future<void> getCurrentUser() async {
//     state.copyWith(
//       currentUser: UserStore().getAuth()?.user,
//     );
//   }
//
//   Future<void> getPollution() async {
//     pollutionModel.value = await PollutionApi().getOnePollution(id: pollutionId);
//     if (pollutionModel.value?.lat != null &&
//         pollutionModel.value?.lng != null) {
//       aqiGPS.value = await WaqiAPI().getAQIByGPS(pollutionModel.value!.lat!, pollutionModel.value!.lng!);
//       recommend.value =
//           RecommendAQI.effectHealthy(aqiGPS.value?.data?.aqi ?? 0);
//       final GoogleMapController controller = await mapController.future;
//
//       controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//           target: LatLng(
//             pollutionModel.value!.lat!,
//             pollutionModel.value!.lng!,
//           ),
//           zoom: 13)));
//     }
//
//     getUser();
//     getHistoryPollution();
//   }
//
//   void changeRecommend(int recommendId) {
//     if (recommendId == 0) {
//       // Sức khỏe
//       state.copyWith(
//         reCommentType: 0,
//         recommend: RecommendAQI.effectHealthy(
//           state.aqiGPS?.data?.aqi ?? 0,
//         ),
//       );
//     } else if (recommendId == 1) {
//       // Người bình thường
//       state.copyWith(
//         reCommentType: 1,
//         recommend: RecommendAQI.actionNormalPeople(
//           state.aqiGPS?.data?.aqi ?? 0,
//         ),
//       );
//     } else {
//       state.copyWith(
//         recommend: RecommendAQI.actionSensitivePeople(
//           state.aqiGPS?.data?.aqi ?? 0,
//         ),
//       );
//     }
//   }
// }
