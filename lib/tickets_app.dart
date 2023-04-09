import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/tickets_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/repositories/repository.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/view/ticket_list_screen.dart';

class TicketsApp extends StatelessWidget {
  const TicketsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            TicketBloc(ticketRepository: context.read<TicketsRepository>()),
        child: const TicketListScreen());
  }
}
