import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = CounterBloc()..add(CounterSetNull());
    return BlocProvider<CounterBloc>(
      create: (context) => bloc,
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                bloc.add(CounterIncEvent());
              },
              icon: const Icon(Icons.plus_one),
            ),
            IconButton(
              onPressed: () {
                bloc.add(CounterDecEvent());
              },
              icon: const Icon(Icons.exposure_minus_1),
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<CounterBloc, int>(
            bloc: bloc,
            builder: (context, state) {
              return Center(child: Text(state.toString(), style: const TextStyle(fontSize: 33)));
            },
          ),
        ),
      ),
    );
  }
}
