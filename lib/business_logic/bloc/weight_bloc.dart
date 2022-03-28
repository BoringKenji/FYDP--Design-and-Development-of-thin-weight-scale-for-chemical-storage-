import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fydp_app/data/models/weight.dart';
import 'package:meta/meta.dart';
import '../../data/models/weight.dart';
import '../../data/repositories/weight_repository.dart';

part 'weight_event.dart';
part 'weight_state.dart';

class WeightBloc extends Bloc<WeightEvent, WeightState> {
  WeightRepository repository;

  WeightBloc(this.repository) : super(WeightInitialState()) {
    on<WeightEvent>((event, emit) {
      // TODO: implement event handler
      Stream <WeightState> mapEventToState(WeightEvent event) async*{
        if(event is FetchWeightEvent){
          yield WeightLoadingState();

          try{
            Weight weight = await repository.getLastWeightData();
            yield WeightLoadedState(weight);
          }catch(e){
            yield WeightErrorState(e.toString());
          }
        }
      }
    });
  }
}
