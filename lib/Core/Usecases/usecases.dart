import 'package:dartz/dartz.dart';
import 'package:test_tech/Core/Error/failure.dart';

abstract class Usescases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
