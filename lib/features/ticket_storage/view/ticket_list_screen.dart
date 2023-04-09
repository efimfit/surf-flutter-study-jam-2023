import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/tickets_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/view/components/ticket_item.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/view/components/add_link_bottom_sheet.dart';

class TicketListScreen extends StatelessWidget {
  const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Хранение билетов'),
      ),
      body: BlocBuilder<TicketBloc, TicketsState>(
        builder: (context, state) {
          return state.tickets.isEmpty
              ? const Center(
                  child: Text('Здесь пока ничего нет'),
                )
              : ListView.builder(
                  itemCount: state.tickets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TicketItem(state.tickets[index]);
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) {
              return AddLinkBottomSheet(ticketBloc: context.read<TicketBloc>());
            },
          );
        },
        label: const Text('Добавить'),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
