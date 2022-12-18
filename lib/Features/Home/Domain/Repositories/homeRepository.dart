import 'package:dartz/dartz.dart';
import 'package:test_tech/Core/Error/failure.dart';
import 'package:test_tech/Features/Home/Domain/Entities/offertsEntity.dart';

abstract class HomeRepository {
  Future<Either<Failure, DataInformation?>> getData(
      DataInformation? dataInformation);
}
