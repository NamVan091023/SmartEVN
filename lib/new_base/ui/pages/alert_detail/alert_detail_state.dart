part of 'alert_detail_cubit.dart';

class AlertDetailState extends Equatable {
  final LoadStatus loadDataStatus;

  const AlertDetailState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  AlertDetailState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return AlertDetailState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}