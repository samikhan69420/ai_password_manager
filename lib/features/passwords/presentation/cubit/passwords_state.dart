part of 'passwords_cubit.dart';

sealed class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object> get props => [];
}

final class PasswordInitial extends PasswordState {
  @override
  List<Object> get props => [];
}

final class PasswordLoading extends PasswordState {
  @override
  List<Object> get props => [];
}

final class PasswordLoaded extends PasswordState {
  Stream<List<PasswordEntity>> streamResponse;

  PasswordLoaded({required this.streamResponse});
  @override
  List<Object> get props => [streamResponse];
}

final class PasswordError extends PasswordState {
  final String? errorMsg;

  const PasswordError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg ?? "ukeer"];
}
