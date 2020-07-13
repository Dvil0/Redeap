import 'package:flutter/material.dart';
import 'package:redeap/core/route/router.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
        accentColor: Colors.orange,
//        brightness: Brightness.dark
      ),
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
    );
  }
}