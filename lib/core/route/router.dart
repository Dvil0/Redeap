import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redeap/features/manage_news/presentation/screens/create_news_screen.dart';
import 'package:redeap/features/manage_news/presentation/screens/show_news_screen.dart';

class Router {
  static Route<dynamic> generateRoute( RouteSettings settings ) {
    switch( settings.name ){
      case '/' :
        return MaterialPageRoute(
            builder: (_) => ShowNewsScreen()
        );
      case 'createNews' :
        return MaterialPageRoute(
            builder: (context) => CreateNewsScreen()
        );
      default:
        return MaterialPageRoute(
            builder: (_) =>
              Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              )
        );
    }
  }
}