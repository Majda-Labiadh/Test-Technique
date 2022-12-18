part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState([List props = const <dynamic>[]]) : super();
}

class EmptyHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class ErrorHomeState extends HomeState {
  final DataInformation? dataInformation;

  ErrorHomeState({
    required this.dataInformation,
  }) : super([dataInformation]);
  @override
  List<Object?> get props => [dataInformation];
}

class GoToHomeState extends HomeState {
  final DataInformation? dataInformation;

  GoToHomeState({
    required this.dataInformation,
  }) : super([dataInformation]);
  @override
  List<Object?> get props => [dataInformation];
}

class GoToLoadingState extends HomeState {
  GoToLoadingState() : super([]);
  @override
  List<Object?> get props => [];
}

class GoToDetailDisplayState extends HomeState {
  final Data? data;
  final DataInformation? dataInformation;
  final bool isToday;
  GoToDetailDisplayState(
      {required this.data,
      required this.dataInformation,
      required this.isToday})
      : super([data]);
  @override
  List<Object?> get props => [data];
}
