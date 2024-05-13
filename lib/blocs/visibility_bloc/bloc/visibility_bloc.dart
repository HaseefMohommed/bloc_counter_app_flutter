import 'package:bloc/bloc.dart';
import 'package:bloc_cubit/blocs/visibility_bloc/bloc/visibility_event.dart';
import 'package:bloc_cubit/blocs/visibility_bloc/bloc/visibility_state.dart';


class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(VisibilityState(show: true)) {
    on<VisibilityShowEvent>((event, emit) {
      emit(VisibilityState(show: true));
    });

    on<VisibilityHideEvent>((event, emit) {
      emit(VisibilityState(show: false));
    });
  }
}
