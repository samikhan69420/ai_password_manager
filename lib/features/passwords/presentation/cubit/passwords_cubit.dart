import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:password_manager/features/app/const/classes_functions/toast.dart';
import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';
import 'package:password_manager/features/passwords/domain/usecases/delete_password_usecase.dart';
import 'package:password_manager/features/passwords/domain/usecases/get_password_usecase.dart';
import 'package:password_manager/features/passwords/domain/usecases/create_password_usecase.dart';
import 'package:password_manager/features/passwords/domain/usecases/update_password_usecase.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

part 'passwords_state.dart';

class PasswordsCubit extends Cubit<PasswordState> {
  final CreatePasswordUsecase createPasswordUsecase;
  final GetPasswordUsecase getPasswordUsecase;
  final DeletePasswordUsecase deletePasswordUsecase;
  final UpdatePasswordUsecase updatePasswordUsecase;

  PasswordsCubit({
    required this.updatePasswordUsecase,
    required this.createPasswordUsecase,
    required this.getPasswordUsecase,
    required this.deletePasswordUsecase,
  }) : super(PasswordInitial());

  void createPassword(PasswordEntity passwordEntity) async {
    emit(PasswordLoading());
    try {
      createPasswordUsecase.call(passwordEntity);
      final streamResponse = getPasswordUsecase.call(null);
      emit(PasswordLoaded(streamResponse: streamResponse));
    } catch (e) {
      emit(PasswordError(errorMsg: e.toString()));
    }
  }

  void getAiPassword({String? passwordIdentifier}) {
    emit(PasswordLoading());
    try {
      final streamResponse = getPasswordUsecase.call(passwordIdentifier);
      emit(PasswordLoaded(streamResponse: streamResponse));
    } catch (e) {
      debugPrint(e.toString());
      emit(PasswordError(errorMsg: e.toString()));
    }
  }

  void deletePassword({String? passwordIdentifier}) async {
    emit(PasswordLoading());
    try {
      deletePasswordUsecase.call(passwordIdentifier!);
      final streamResponse = getPasswordUsecase.call(passwordIdentifier);
      emit(PasswordLoaded(streamResponse: streamResponse));
    } catch (e) {
      debugPrint(e.toString());
      emit(PasswordError(errorMsg: e.toString()));
    }
  }

  void updatePassword({required PasswordEntity newPassword}) {
    emit(PasswordLoading());
    try {
      updatePasswordUsecase.call(newPassword);
      final streamResponse =
          getPasswordUsecase.call(newPassword.passwordIdentifier);
      emit(PasswordLoaded(streamResponse: streamResponse));
      showToastification("Changes Saved");
    } catch (e) {
      debugPrint(e.toString());
      emit(PasswordError(errorMsg: e.toString()));
    }
  }
}
