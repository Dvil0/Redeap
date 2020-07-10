import 'package:flutter/material.dart';
import 'package:redeap/core/route/router.dart';

void main() {
  runApp( Redeap() );
}

class Redeap extends StatelessWidget {
  @override
  Widget build( BuildContext context ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Red de Apoyo',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.orange
      ),
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
    );
  }
}