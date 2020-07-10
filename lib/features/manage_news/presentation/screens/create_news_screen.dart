import 'package:flutter/material.dart';

class CreateNewsScreen extends StatefulWidget {
  @override
  _CreateNewsScreenState createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  String newsCode;
  String reportCode;
  String radioCode;
  String hourDate;
  String unitCode;
  String message;
  String dateUpdate;
  String unitCreate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Novedad'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.save ),
            onPressed: _saveNews,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              _rowInput( text: 'Cod Novedad', data: newsCode),
              _rowInput( text: 'Cod Reporte', data: reportCode),
              _rowInput( text: 'Cod Radio', data: radioCode),
              _rowInput( text: 'Fecha', data: hourDate),
              _rowInput( text: 'Unid reportada', data: unitCode),
              _rowInput( text: 'Mensaje', data: message),
              _rowInput( text: 'Ult Fecha', data: dateUpdate),
              _rowInput( text: 'Unid Actual', data: unitCreate),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowInput({String text, String data}) {
    return Row(
      children: <Widget>[
        Text( text ),
        SizedBox(width: 20,),
        Flexible(
          child: TextField(
            onChanged: ( value ) {
              data = value;
            },
          ),
        ),
      ],
    );
  }

  void _saveNews() {
    Navigator.pop(context);
  }
}