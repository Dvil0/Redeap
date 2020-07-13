import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_bloc.dart';
import 'package:redeap/features/manage_news/presentation/screens/create_news_screen.dart';
import 'package:redeap/features/manage_news/presentation/screens/show_news_screen.dart';

class Router {

  static const String HOME = '/';
  static const String CREATE_NEWS = 'createNews';

  static Route<dynamic> generateRoute( RouteSettings settings ) {
    switch( settings.name ){
      case HOME :
        return MaterialPageRoute(
            builder: (_) => ShowNewsScreen()
        );
      case CREATE_NEWS :
        var newsBloc = settings.arguments as NewsBloc;
        return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                  value: newsBloc,
                  child: CreateNewsScreen(),
        )
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