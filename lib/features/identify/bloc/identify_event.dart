part of 'identify_bloc.dart';

sealed class IdentifyEvent extends Equatable {
  const IdentifyEvent();

  @override
  List<Object> get props => [];
}

class LoadIdentify extends IdentifyEvent {
  const LoadIdentify();

  @override
  List<Object> get props => [];
}