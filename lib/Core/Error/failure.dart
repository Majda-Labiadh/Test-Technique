import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List props = const []]) : super();
}

class ServerFailure extends Failure {
  final String message;

  const ServerFailure({required this.message}) : super();

  @override
  List<Object> get props => [message];
}
