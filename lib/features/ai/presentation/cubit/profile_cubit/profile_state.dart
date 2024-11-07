part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileLoaded extends ProfileState {
  UserEntity userEntity;
  ProfileLoaded({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

final class ProfileError extends ProfileState {
  String errorMsg;
  ProfileError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
