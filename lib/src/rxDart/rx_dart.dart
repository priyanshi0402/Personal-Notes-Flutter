import 'package:rxdart/rxdart.dart';

class CounterBloc {
  int initialCount =
      0; //if the data is not passed by paramether it initializes with 0
  BehaviorSubject<int> _subjectCounter = BehaviorSubject();

  CounterBloc({required this.initialCount}) {
    _subjectCounter = BehaviorSubject<int>.seeded(
        initialCount); //initializes the subject with element already
  }

  Stream<int> get counterObservable => _subjectCounter.stream;

  void increment() {
    initialCount++;
    _subjectCounter.sink.add(initialCount);
  }

  void decrement() {
    if (initialCount == 0) {
      return;
    }
    initialCount--;
    _subjectCounter.sink.add(initialCount);
  }

  void dispose() {
    _subjectCounter.close();
  }
}
