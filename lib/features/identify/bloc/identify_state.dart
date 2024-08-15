part of 'identify_bloc.dart';

sealed class IdentifyState extends Equatable {
  const IdentifyState();

  @override
  List<Object> get props => [];
}

final class IdentifyInitialState extends IdentifyState {
  @override
  List<Object> get props => [];
}

final class IdentifyLoadedState extends IdentifyState {
  final PlantEntity plant;

  const IdentifyLoadedState({required this.plant});

  @override
  List<Object> get props => [plant];
}

final class IdentifyLoadingState extends IdentifyState {
  @override
  List<Object> get props => [];
}

final class IdentifyErrorState extends IdentifyState {
  final String message;

  const IdentifyErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class IdentifyImageDiscardedState extends IdentifyState {
  final String message;

  const IdentifyImageDiscardedState({required this.message});

  @override
  List<Object> get props => [message];
}

final class IdentifyEmptyImageState extends IdentifyState {
  final String message;

  const IdentifyEmptyImageState({required this.message});

  @override
  List<Object> get props => [message];
}

final class IdentifyServerStatusState extends IdentifyState {
  final bool status;

  const IdentifyServerStatusState({required this.status});

  @override
  List<Object> get props => [status];
}
