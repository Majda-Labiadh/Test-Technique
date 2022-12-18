import 'package:dartz/dartz.dart';
import 'package:test_tech/Core/Error/failure.dart';
import 'package:test_tech/Core/Usecases/usecases.dart';
import 'package:test_tech/Features/Home/Domain/Entities/offertsEntity.dart';
import 'package:test_tech/Features/Home/Domain/Repositories/homeRepository.dart';

class GetData implements Usescases<DataInformation?, DataInformation?> {
  final HomeRepository homeRepository;

  GetData(this.homeRepository);

  @override
  Future<Either<Failure, DataInformation?>> call(
      DataInformation? dataInformation) async {
    return await homeRepository.getData(dataInformation);
  }
}
