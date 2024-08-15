import 'package:flora_sense/features/identify/bloc/identify_bloc.dart';
import 'package:flora_sense/features/identify/widgets/identify_container.dart';
import 'package:flora_sense/features/network/bloc/network_bloc.dart';
import 'package:flora_sense/features/theme/cubit/theme_cubit.dart';
import 'package:flora_sense/main.dart';
import 'package:flora_sense/features/identify/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdentifyScreen extends StatefulWidget {
  const IdentifyScreen({Key? key}) : super(key: key);

  @override
  _IdentifyScreenState createState() => _IdentifyScreenState();
}

class _IdentifyScreenState extends State<IdentifyScreen> {
  final IdentifyBloc identifyBloc = serviceLocator<IdentifyBloc>();
  final ThemeCubit themeCubit = serviceLocator<ThemeCubit>();

  @override
  void initState() {
    super.initState();
    identifyBloc.add(const IdentifyServerStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar(themeCubit: themeCubit),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BlocListener<IdentifyBloc, IdentifyState>(
            listener: (context, state) {
              String? message;

              if (state is IdentifyImageDiscardedState) {
                message = 'Camera capture canceled';
              } else if (state is IdentifyEmptyImageState) {
                message = 'Image is empty';
              }

              if (message != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      message,
                      style: Theme.of(context).snackBarTheme.contentTextStyle,
                    ),
                  ),
                );
              }
            },
            child: Container(),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<NetworkBloc, NetworkState>(
                    builder: (context, networkState) {
                      if (networkState is NetworkConnected) {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IdentifyContainer(identifyBloc: identifyBloc),
                            ],
                          ),
                        );
                      } else if (networkState is NetworkDisconnected) {
                        return Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.cloud_off,
                                color: Theme.of(context).disabledColor,
                              ),
                              Text(
                                'No internet connection',
                                style: TextStyle(
                                    color: Theme.of(context).disabledColor),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
