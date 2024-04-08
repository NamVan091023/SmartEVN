import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:pollution_environment/new_base/models/enums/load_status.dart';


part 'forgot_pasword_state.dart';

class ForgotPaswordCubit extends Cubit<ForgotPaswordState> {

  ForgotPaswordCubit() : super(const ForgotPaswordState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e, s) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
