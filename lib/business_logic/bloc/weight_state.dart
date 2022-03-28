part of 'weight_bloc.dart';


@immutable
abstract class WeightState extends Equatable{

}

class WeightInitialState extends WeightState {
  List<Object> get props => [];
}

class WeightLoadingState extends WeightState {
  List<Object> get props => [];
}

class WeightLoadedState extends WeightState {
  Weight weight ;
  WeightLoadedState(this.weight);
  @override
  List<Object> get props => [];
}

class WeightErrorState extends WeightState {
  String message;
  WeightErrorState(this.message);
  List<Object> get props => [];
}
