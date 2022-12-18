part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent([List props = const <dynamic>[]]) : super();
}

class GoToHomeEvent extends HomeEvent {
  final DataInformation? dataInformation;

  GoToHomeEvent({
    required this.dataInformation,
  }) : super([dataInformation]);
  @override
  List<Object?> get props => [dataInformation];
}

class GoToLoadingEvent extends HomeEvent {
  GoToLoadingEvent() : super([]);
  @override
  List<Object?> get props => [];
}

class GetDataEvent extends HomeEvent {
  final DataInformation? dataInformation;

  GetDataEvent({
    required this.dataInformation,
  }) : super([dataInformation]);
  @override
  List<Object?> get props => [];
}

class GoToDetailDisplayEvent extends HomeEvent {
  final Data? data;
  final DataInformation? dataInformation;
  final bool isToday;
  GoToDetailDisplayEvent(
      {required this.data,
      required this.dataInformation,
      required this.isToday})
      : super([data]);
  @override
  List<Object?> get props => [data];
}
