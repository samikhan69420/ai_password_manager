import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:password_manager/features/ai/domain/usecases/get_password_usecase.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  final GetAiPasswordUsecase getAiPasswordUsecase;

  AiCubit({required this.getAiPasswordUsecase}) : super(AiInitial());

  void getAiPassword(String prompt) async {
    emit(AiLoading());
    try {
      final String response = await getAiPasswordUsecase.call(prompt);
      emit(AiLoaded(response: response));
    } catch (e) {
      debugPrint(e.toString());
      emit(AiError(errorMsg: e.toString()));
    }
  }
}
