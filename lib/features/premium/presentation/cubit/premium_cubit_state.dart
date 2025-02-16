part of 'premium_cubit_cubit.dart';

sealed class PremiumCubitState extends Equatable {
  const PremiumCubitState();

  @override
  List<Object> get props => [];
}

final class PremiumCubitInitial extends PremiumCubitState {}

final class PremiumCubitLoading extends PremiumCubitState {}

final class PremiumCubitLoaded extends PremiumCubitState {
  final double credits;

  const PremiumCubitLoaded({required this.credits});
  @override
  List<Object> get props => [credits];
}

final class PremiumCubitFailure extends PremiumCubitState {}
