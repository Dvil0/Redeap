import 'package:flutter/material.dart';

class MyDrawer extends Drawer {
  MyDrawer() : super(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Opciones'),
          decoration: BoxDecoration(
            color: Colors.white30
          ),
        ),
        ListTile(
          title: Text('Home'),
          onTap: () => null,
        ),
        ListTile(
          title: Text('Reportes'),
          onTap: () => null,
        ),
        ListTile(
          title: Text('Unidades'),
          onTap: () => null,
        )
      ],
    )
  );
}