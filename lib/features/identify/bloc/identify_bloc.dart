import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flora_sense/features/identify/entities/plant_entity.dart';
import 'package:flora_sense/features/identify/exceptions.dart';
import 'package:flora_sense/features/identify/repositories/identify_repository.dart';
import 'package:flora_sense/features/identify/services/plant_identification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'identify_event.dart';
part 'identify_state.dart';

class IdentifyBloc extends Bloc<IdentifyEvent, IdentifyState> {
  final PlantIdentificationService plantIdentificationService;
  final IdentifyRepository identifyRepository;

  IdentifyBloc(
      {required this.plantIdentificationService,
      required this.identifyRepository})
      : super(IdentifyInitialState()) {
    on<LoadIdentifyEvent>(loadIdentify);
    on<IdentifyServerStatusEvent>(identifyServerStatus);
  }

  FutureOr<void> identifyServerStatus(
      IdentifyServerStatusEvent event, Emitter<IdentifyState> emit) async {
    log('IdentifyServerStatus called');

    try {
      final bool serverStatus = await identifyRepository.serverStatus();
      emit(IdentifyServerStatusState(status: serverStatus));
    } catch (e) {
      emit(const IdentifyServerStatusState(status: false));
    }
  }

  FutureOr<void> loadIdentify(
      LoadIdentifyEvent event, Emitter<IdentifyState> emit) async {
    log('Load Identify called');

    emit(IdentifyLoadingState());

    try {
      final PlantEntity? plant =
          await plantIdentificationService.identifyPlantFromCamera();
      if (plant != null) {
        emit(IdentifyLoadedState(plant: plant));
      } else {
        emit(const IdentifyErrorState(
            message: 'Failed to identify: Plant Not Found.'));
      }
    } on IdentifyImageDiscardedException catch (e) {
      emit(IdentifyImageDiscardedState(message: e.message));
    } on IdentifyEmptyImageException catch (e) {
      emit(IdentifyEmptyImageState(message: e.message));
    } on IdentifyApiException catch (e) {
      emit(IdentifyErrorState(message: e.message));
    } catch (e) {
      emit(IdentifyErrorState(message: 'Failed to identify: $e'));
    }
  }
}
