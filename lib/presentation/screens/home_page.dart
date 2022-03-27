import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fydp_app/business_logic/cubit/weight_cubit.dart';
import 'home_screens.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [CounterCubit] instance to the [CounterView].
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro counter_page}
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeightCubit(),
      child: HomeScreen(),
    );
  }
}
