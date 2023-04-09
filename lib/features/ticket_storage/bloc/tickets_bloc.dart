import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/models/ticket_model.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/repositories/repository.dart';

part 'tikets_event.dart';
part 'tikets_state.dart';

class TicketBloc extends HydratedBloc<TicketsEvent, TicketsState> {
  TicketBloc({required TicketsRepository ticketRepository})
      : _ticketRepository = ticketRepository,
        super(TicketsState(<Ticket>[])) {
    on<TicketAdded>(_onTicketAdded);
  }

  final TicketsRepository _ticketRepository;

  Future<void> _onTicketAdded(
      TicketAdded event, Emitter<TicketsState> emit) async {
    int lastIndex = event.url.lastIndexOf('/');
    String substring = event.url.substring(lastIndex + 1);

    final newTickets = state.tickets
      ..add(Ticket(title: substring, url: event.url));

    emit(state.copyWith(tickets: newTickets));
  }

  @override
  TicketsState? fromJson(Map<String, dynamic> json) {
    if (json['tickets'] != null) {
      final List<Ticket> tickets = (json['tickets'] as List)
          .map((ticketJson) => Ticket.fromJson(ticketJson))
          .toList();
      return TicketsState(tickets);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(TicketsState state) {
    return {'tickets': state.tickets.map((ticket) => ticket.toJson()).toList()};
  }
}
