import 'package:flora_sense/features/identify/bloc/identify_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdentifyContainer extends StatelessWidget {
  const IdentifyContainer({
    super.key,
    required this.identifyBloc,
  });

  final IdentifyBloc identifyBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdentifyBloc, IdentifyState>(
      builder: (context, identifyState) {
        if (identifyState is IdentifyLoadingState) {
          return identifyLoadingWidget();
        } else if (identifyState is IdentifyLoadedState) {
          return identifyLoadedWidget(identifyState, context);
        } else if (identifyState is IdentifyErrorState) {
          return identifyErrorWidget(identifyState, context);
        } else {
          return identifyInitialWidget(context);
        }
      },
    );
  }

  Center identifyLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  ElevatedButton identifyInitialWidget(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(24.0),
      ),
      onPressed: () {
        identifyBloc.add(const LoadIdentifyEvent());
      },
      child: Icon(
        Icons.photo_camera_rounded,
        size: 48.0,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Column identifyErrorWidget(
      IdentifyErrorState identifyState, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          identifyState.message,
          style: const TextStyle(color: Colors.red),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () {
            identifyBloc.add(const LoadIdentifyEvent());
          },
          child: Icon(
            Icons.photo_camera_rounded,
            size: 48.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Column identifyLoadedWidget(
      IdentifyLoadedState identifyState, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Identified Plant: ${identifyState.plant.scientificNameWithoutAuthor}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () {
            identifyBloc.add(const LoadIdentifyEvent());
          },
          child: Icon(
            Icons.photo_camera_rounded,
            size: 48.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
