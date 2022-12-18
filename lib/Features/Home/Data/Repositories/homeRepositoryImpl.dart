import 'package:dartz/dartz.dart';
import 'package:test_tech/Core/Error/exceptions.dart';
import 'package:test_tech/Core/Error/failure.dart';
import 'package:test_tech/Core/Network/networkInfo.dart';
import 'package:test_tech/Features/Home/Data/Datasource/homeRemoteDatasource.dart';
import 'package:test_tech/Features/Home/Domain/Entities/offertsEntity.dart';
import 'package:test_tech/Features/Home/Domain/Repositories/homeRepository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  // ignore: prefer_typing_uninitialized_variables
  var response;
  @override
  Future<Either<Failure, DataInformation?>> getData(
      DataInformation? resetPasswordParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.getData(resetPasswordParams);
      if (response is DataInformation?) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption {
      return const Left(ServerFailure(message: ''));
    }
  }
}
