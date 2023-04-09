import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:surf_flutter_study_jam_2023/features/ticket_storage/repositories/repository.dart';
import 'package:surf_flutter_study_jam_2023/tickets_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  runApp(MaterialApp(
    title: 'Tickets App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      useMaterial3: true,
    ),
    home: RepositoryProvider(
      create: (context) => TicketsRepository(),
      child: const TicketsApp(),
    ),
  ));
}
