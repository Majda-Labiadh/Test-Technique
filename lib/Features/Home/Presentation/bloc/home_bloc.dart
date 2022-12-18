import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_tech/Features/Home/Domain/Entities/offertsEntity.dart';
import 'package:test_tech/Features/Home/Domain/Usecases/getData.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetData getData;

  HomeBloc({
    required this.getData,
  }) : super(EmptyHomeState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GoToHomeEvent) {
      yield GoToHomeState(
        dataInformation: event.dataInformation,
      );
    }
    if (event is GetDataEvent) {
      yield GoToLoadingState();
      final failureOrToken = await getData(event.dataInformation);
      yield* failureOrToken.fold((failure) async* {
        yield GoToHomeState(
          dataInformation: event.dataInformation,
        );
      }, (dataInformation) async* {
        yield GoToHomeState(
          dataInformation: dataInformation,
        );
      });
    }
    if (event is GoToDetailDisplayEvent) {
      yield GoToDetailDisplayState(
          data: event.data,
          dataInformation: event.dataInformation,
          isToday: event.isToday);
    }
  }
}
