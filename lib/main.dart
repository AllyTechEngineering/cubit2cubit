import 'package:cubit2cubit/cubits/counter/counter_cubit.dart';
import 'package:cubit2cubit/cubits/color/color_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(create: (context) => ColorCubit()),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(
            colorCubit: context.read<ColorCubit>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'cubit2cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  } //Widget
} //class MyApp

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context
          .watch<ColorCubit>()
          .state
          .color, // backgroundColor is using the Bloc extenstion method to listen for color change
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text(
                'Change Color',
                style: TextStyle(fontSize: 24.0),
              ),
              onPressed: () {
                context
                    .read<ColorCubit>()
                    .changeColor(); // uses Bloc extension method to
                // context.read (provide) to the cubit the request for color state change
              },
            ),
            SizedBox(height: 20.0),
            Text(
              '${context.watch<CounterCubit>().state.counter}', // uses Bloc extension method context.watch to update the text for the counter.
              style: TextStyle(
                fontSize: 52.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text(
                'Increment Counter',
                style: TextStyle(fontSize: 24.0),
              ),
              onPressed: () {
                context.read<CounterCubit>().changeCounter();
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*
// *** This is the extension method with nested BlocProviders ***
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColorCubit(),
      child: BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(
          // two ways to handle this
          // this is the extension method
          colorCubit: context.read<ColorCubit>(),
        ),
        child: MaterialApp(
          title: 'cubit2cubit',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  } //Widget
} //class MyApp
*/
