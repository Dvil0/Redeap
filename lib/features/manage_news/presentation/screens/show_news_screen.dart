import 'package:flutter/material.dart';
import 'package:redeap/core/widgets/my_app_bar.dart';
import 'package:redeap/core/widgets/my_drawer.dart';

class ShowNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        onPressed: () => Navigator.pushNamed(context, 'createNews'),
      ),
    );
  }

}