part of 'forgot_pasword_cubit.dart';

class ForgotPaswordState extends Equatable {
  final LoadStatus loadDataStatus;

  const ForgotPaswordState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  ForgotPaswordState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return ForgotPaswordState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
