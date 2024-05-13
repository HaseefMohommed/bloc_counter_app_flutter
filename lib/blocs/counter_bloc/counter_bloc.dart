import 'package:bloc/bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 0)) {
    on<CounterIncrementEvent>((event, emit) {
      emit(CounterState(count: state.count + 1));
    });

    on<CounterDecrementEvent>((event, emit) {
      emit(CounterState(count: state.count - 1));
    });
  }
}
