import 'package:test_tech/Features/Home/Domain/Entities/offertsEntity.dart';

abstract class HomeRemoteDataSource {
  Future<DataInformation> getData(DataInformation? dataInformation);
}
