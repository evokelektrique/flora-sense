part of 'identify_bloc.dart';

sealed class IdentifyEvent extends Equatable {
  const IdentifyEvent();

  @override
  List<Object> get props => [];
}

class LoadIdentifyEvent extends IdentifyEvent {
  const LoadIdentifyEvent();

  @override
  List<Object> get props => [];
}

class IdentifyServerStatusEvent extends IdentifyEvent {
  const IdentifyServerStatusEvent();

  @override
  List<Object> get props => [];
}
