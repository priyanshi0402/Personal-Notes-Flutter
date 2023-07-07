import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_notes/src/provider/counter/bloc/counter_bloc.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // final CounterBloc _counterBloc = CounterBloc(initialCount: 0);
  final CounterBloc _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _counterBloc,
      child: Scaffold(
        body: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text('0')),
              success: (counter) {
                print(counter);
                return Center(child: Text('$counter'));
              },
            );
          },
        )

        // StreamBuilder<Object>(
        //     stream: _counterBloc.counterObservable,
        //     builder: (context, snapshot) {
        //       return Center(child: Text('${snapshot.data}'));
        //     }),
        ,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: () {
                  _counterBloc.add(const CounterEvent.increment());
                  // _counterBloc.increment();
                },
                child: const Icon(Icons.add),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                _counterBloc.add(const CounterEvent.decrement());
                // _counterBloc.decrement();
              },
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
