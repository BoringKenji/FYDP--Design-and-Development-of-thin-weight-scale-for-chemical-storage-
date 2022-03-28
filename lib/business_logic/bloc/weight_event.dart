part of 'weight_bloc.dart';

@immutable
abstract class WeightEvent extends Equatable{

}

class FetchWeightEvent extends WeightEvent{
  FetchWeightEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
