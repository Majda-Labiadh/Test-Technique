import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_tech/Features/Home/Domain/Entities/offertsEntity.dart';
import 'package:test_tech/Features/Home/Presentation/Pages/homePage.dart';
import 'package:test_tech/Features/Home/Presentation/bloc/home_bloc.dart';
import 'package:test_tech/injection_container.dart';

class HomeProvider extends StatelessWidget {
  final DataInformation? dataInformation;
  const HomeProvider({Key? key, required this.dataInformation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocProvider(
          create: (_) => sl<HomeBloc>(),
          child: HomePage(
            dataInformation: dataInformation,
          ),
        ),
      ),
    );
  }
}
