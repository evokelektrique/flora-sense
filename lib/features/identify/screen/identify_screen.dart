import 'package:flora_sense/features/identify/bloc/identify_bloc.dart';
import 'package:flora_sense/features/network/bloc/network_bloc.dart';
import 'package:flora_sense/features/network/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class IdentifyScreen extends StatefulWidget {
  const IdentifyScreen({Key? key}) : super(key: key);

  @override
  _IdentifyScreenState createState() => _IdentifyScreenState();
}

class _IdentifyScreenState extends State<IdentifyScreen> {
  late final IdentifyBloc identifyBloc;

  @override
  void initState() {
    super.initState();
    identifyBloc = GetIt.instance<IdentifyBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identify Screen',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await NetworkHelper.checkInternetConnectionAsync()) {
            identifyBloc.add(const LoadIdentify());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text('No internet connection')));
          }
        },
        child: const Text('Identify'),
      ),
      body: Column(
        children: <Widget>[
          BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              if (state is NetworkConnected) {
                return const Text('Connected to the internet');
              } else if (state is NetworkDisconnected) {
                return const Text('No internet connection');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          BlocBuilder<IdentifyBloc, IdentifyState>(
            builder: (context, state) {
              if (state is IdentifyInitial) {
                return const Text('Press the button to identify');
              } else if (state is IdentifyLoading) {
                return const CircularProgressIndicator();
              } else if (state is IdentifyLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Scientific name: ${state.plant.scientificName}'),
                  ],
                );
              } else if (state is IdentifyError) {
                return Text('Error: ${state.message}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
