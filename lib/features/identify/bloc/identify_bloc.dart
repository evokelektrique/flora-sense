import 'package:equatable/equatable.dart';
import 'package:flora_sense/features/identify/entities/plant_entity.dart';
import 'package:flora_sense/features/identify/repositories/identify_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'identify_event.dart';
part 'identify_state.dart';

class IdentifyBloc extends Bloc<IdentifyEvent, IdentifyState> {
  final IdentifyRepository identifyRepository;
  
  IdentifyBloc(this.identifyRepository) : super(IdentifyInitial()) {
    on<LoadIdentify>((event, emit) async {
      emit(IdentifyLoading());

      try {
        final plant = await identifyRepository.identify();
        emit(IdentifyLoaded(plant: plant));
      } catch (e) {
        emit(IdentifyError(message: 'Failed to identify: $e'));
      }
    });
  }
}
