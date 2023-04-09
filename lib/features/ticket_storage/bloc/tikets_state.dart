// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tickets_bloc.dart';

class TicketsState {
  final List<Ticket> tickets;

  TicketsState(this.tickets);

  TicketsState copyWith({
    List<Ticket>? tickets,
  }) {
    return TicketsState(
      tickets ?? this.tickets,
    );
  }
}
