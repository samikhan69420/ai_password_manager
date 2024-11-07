part of 'ai_cubit.dart';

sealed class AiState extends Equatable {
  const AiState();

  @override
  List<Object> get props => [];
}

final class AiInitial extends AiState {
  @override
  List<Object> get props => [];
}

final class AiLoading extends AiState {
  @override
  List<Object> get props => [];
}

final class AiLoaded extends AiState {
  final String response;

  const AiLoaded({required this.response});
  @override
  List<Object> get props => [response];
}

final class AiError extends AiState {
  final String? errorMsg;

  const AiError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg ?? "Unexpected Error"];
}
