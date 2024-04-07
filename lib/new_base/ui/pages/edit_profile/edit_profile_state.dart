part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final LoadStatus loadDataStatus;

  const EditProfileState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  EditProfileState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return EditProfileState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
