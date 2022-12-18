import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_tech/Core/Utils/loadingWidget.dart';
import 'package:test_tech/Features/Home/Domain/Entities/offertsEntity.dart';
import 'package:test_tech/Features/Home/Presentation/Widgets/HomeComponents/DetailDisplay.dart';
import 'package:test_tech/Features/Home/Presentation/Widgets/homeDisplay.dart';
import 'package:test_tech/Features/Home/Presentation/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  final DataInformation? dataInformation;

  const HomePage({Key? key, required this.dataInformation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is EmptyHomeState) {
        BlocProvider.of<HomeBloc>(context).add(
          GetDataEvent(dataInformation: dataInformation),
        );
        // return HomeDisplay(
        //   dataInformation: dataInformation,
        // );
      }

      if (state is GoToLoadingState) {
        return LoadingWidget();
      }
      if (state is GoToHomeState) {
        return HomeDisplay(
          dataInformation: state.dataInformation,
        );
      }
      if (state is GoToDetailDisplayState) {
        return DetailDisplay(
          data: state.data,
          dataInformation: state.dataInformation,
          isToday: state.isToday,
        );
      }
      return HomeDisplay(
        dataInformation: dataInformation,
      );
    });
  }
}
