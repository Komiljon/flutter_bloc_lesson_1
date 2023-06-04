import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(2) {
    on<CounterSetNull>(_onSetNull);
    on<CounterIncEvent>(_onIncrement);
    on<CounterDecEvent>(_onDecrement);
  }

  _onSetNull(CounterSetNull event, Emitter<int> emit) {
    emit(0);
  }

  _onIncrement(CounterIncEvent event, Emitter<int> emit) {
    if (state >= 5) return;
    emit(state + 1);
  }

  _onDecrement(CounterDecEvent event, Emitter<int> emit) {
    if (state <= 0) return;
    emit(state - 1);
  }
}

abstract class CounterEvent {}

class CounterSetNull extends CounterEvent {}

class CounterIncEvent extends CounterEvent {}

class CounterDecEvent extends CounterEvent {}
