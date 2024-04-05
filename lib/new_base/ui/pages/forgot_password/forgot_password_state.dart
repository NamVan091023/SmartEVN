part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final LoadStatus loadDataStatus;

  const ForgotPasswordState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  ForgotPasswordState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return ForgotPasswordState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
