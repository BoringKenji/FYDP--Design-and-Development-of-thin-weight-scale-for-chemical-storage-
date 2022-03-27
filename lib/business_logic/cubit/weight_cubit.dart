import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'weight_state.dart';

class WeightCubit extends Cubit<WeightState> {
  WeightCubit() : super(WeightInitial());
}
