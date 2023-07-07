import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_event.dart';
part 'counter_state.dart';
part 'counter_bloc.freezed.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int counter = 0;
  CounterBloc() : super(_Initial()) {
    on<CounterEvent>((event, emit) {
      if (event is _Increment) {
        emit(_Success(++counter));
      } else if (event is _Decrement) {
        if (counter == 0) {
          return;
        }
        emit(_Success(--counter));
      } else {
        emit(_Success(counter));
      }
    });
  }
}
