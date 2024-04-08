part of 'filter_map_cubit.dart';

class FilterMapState extends Equatable {
  final LoadStatus loadDataStatus;

  const FilterMapState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  FilterMapState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return FilterMapState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
