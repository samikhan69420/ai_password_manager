import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:password_manager/features/ai/domain/entities/user_entity.dart';
import 'package:password_manager/features/ai/domain/usecases/get_profile_usecase.dart';
import 'package:password_manager/features/ai/domain/usecases/set_profile_usecase.dart';
import 'package:password_manager/features/ai/domain/usecases/update_profile_usecase.dart';
import 'package:password_manager/features/app/const/classes_functions/toast.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUsecase getProfileUsecase;
  final UpdateProfileUsecase updateProfileUsecase;
  final SetProfileUsecase setProfileUsecase;

  ProfileCubit({
    required this.getProfileUsecase,
    required this.updateProfileUsecase,
    required this.setProfileUsecase,
  }) : super(ProfileInitial());

  void getProfile() {
    // try {
    final UserEntity userEntity = getProfileUsecase.call();
    emit(ProfileLoaded(userEntity: userEntity));
    // } catch (e) {
    // emit(ProfileError(errorMsg: e.toString()));
    // }
  }

  void setProfile(UserEntity userEntity) {
    // try {
    setProfileUsecase.call(userEntity);
    final UserEntity userEntityea = getProfileUsecase.call();
    emit(ProfileLoaded(userEntity: userEntityea));
    // } catch (e) {
    // emit(ProfileError(errorMsg: e.toString()));
    // }
  }

  void updateProfile(UserEntity userEntity) {
    // try {
    updateProfileUsecase.call(userEntity);
    final UserEntity userEntityea = getProfileUsecase.call();
    emit(ProfileLoaded(userEntity: userEntityea));
    showToastification('Changes Saved');
    // } catch (e) {
    // emit(ProfileError(errorMsg: e.toString()));
    // }
  }
}
