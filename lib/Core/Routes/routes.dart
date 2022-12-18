import 'package:flutter/material.dart';
import 'package:test_tech/Features/Home/Domain/Entities/offertsEntity.dart';
import 'package:test_tech/Features/Home/Presentation/Pages/homeProvider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/homeProvider':
        return MaterialPageRoute(
          builder: (_) => HomeProvider(
            dataInformation: settings.arguments as DataInformation?,
          ),
        );

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Error',
                    style: TextStyle(
                      fontSize: 80.0,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    '404 not found',
                    style: TextStyle(fontSize: 50.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
