part of 'tickets_bloc.dart';

abstract class TicketsEvent {}

class TicketAdded extends TicketsEvent {
  final String url;

  TicketAdded(this.url);
}

class TicketLoaded extends TicketsEvent {}
