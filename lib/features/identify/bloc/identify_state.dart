part of 'identify_bloc.dart';

sealed class IdentifyState extends Equatable {
  const IdentifyState();

  @override
  List<Object> get props => [];
}

final class IdentifyInitial extends IdentifyState {
  @override
  List<Object> get props => [];
}

final class IdentifyLoaded extends IdentifyState {
  final PlantEntity plant;

  const IdentifyLoaded({required this.plant});

  @override
  List<Object> get props => [plant];
}

final class IdentifyLoading extends IdentifyState {
  @override
  List<Object> get props => [];
}

final class IdentifyError extends IdentifyState {
  final String message;

  const IdentifyError({required this.message});

  @override
  List<Object> get props => [message];
}
