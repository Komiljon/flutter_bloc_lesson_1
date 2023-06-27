part of 'stores_bloc.dart';

class StoresEvent {}

class StoresListEvent extends StoresEvent {
  final String query;

  StoresListEvent(this.query);
}
