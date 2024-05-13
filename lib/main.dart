import 'package:bloc_cubit/blocs/counter_bloc/counter_bloc.dart';
import 'package:bloc_cubit/blocs/visibility_bloc/bloc/visibility_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/counter_bloc/counter_event.dart';
import 'blocs/counter_bloc/counter_state.dart';
import 'blocs/visibility_bloc/bloc/visibility_event.dart';
import 'blocs/visibility_bloc/bloc/visibility_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: ((context) => CounterBloc()),
          ),
          BlocProvider(
            create: ((context) => VisibilityBloc()),
          ),
        ],
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterBloc, CounterState>(listener: (context, state) {
              if (state.count == 3) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Counter value is ${state.count}")));
              }
            }, builder: (context, state) {
              return Text(
                state.count.toString(),
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            BlocBuilder<VisibilityBloc, VisibilityState>(
                builder: (context, state) {
              return Visibility(
                visible: state.show,
                child: Container(
                  color: Colors.blue,
                  width: 200,
                  height: 200,
                ),
              );
            }),
            BlocListener<CounterBloc, CounterState>(
              listener: (context, state) {
                if (state.count == 3) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Cunter value is ${state.count}")));
                }
              },
              child: const Text("Block Listener"),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: (() {
              context.read<CounterBloc>().add(CounterIncrementEvent());
            }),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: (() {
              context.read<CounterBloc>().add(CounterDecrementEvent());
            }),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: (() {
              context.read<VisibilityBloc>().add(VisibilityShowEvent());
            }),
            child: const Text("Show"),
          ),
          FloatingActionButton(
            onPressed: (() {
              context.read<VisibilityBloc>().add(VisibilityHideEvent());
            }),
            child: const Text("Hide"),
          ),
        ],
      ),
    );
  }
}
