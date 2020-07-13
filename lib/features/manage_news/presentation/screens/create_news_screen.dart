import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_bloc.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_event.dart';

class CreateNewsScreen extends StatefulWidget {

  @override
  _CreateNewsScreenState createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  String newsCode;
  String reportCode;
  String radioCode;
  final int hourDate = DateTime.now().millisecondsSinceEpoch;
  String unitCode;
  String message;
  final int updateDate = DateTime.now().millisecondsSinceEpoch;
  final String unitCreate = 'Genesis2';

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody( BuildContext context ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Novedad'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNews,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
            _rowInput(
                'Codigo Reporte',
                TextField(
                    keyboardType: TextInputType.number,
                    onChanged: ( value ) => reportCode = value
                  )
            ),
            _rowInput(
                'Codigo Radio',
                TextField(
                    keyboardType: TextInputType.text,
                    onChanged: ( value ) {
                      radioCode = value;
                    })
            ),
            _rowInput(
                'Unidad reportada',
                TextField(
                    keyboardType: TextInputType.text,
                    onChanged: ( value ) {
                      unitCode = value;
                    })
            ),
            _rowInput(
                'Detalle',
                TextField(
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    onChanged: ( value ) {
                      message = value;
                    })
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowInput(String text, Widget textField) {
    return ListTile(
      title: Text( text ),
      subtitle: textField,
    );
  }

  void _saveNews() {
    BlocProvider.of<NewsBloc>( context ).dispatch(
        CreateNewsForUser(
            newsCode: newsCode,
            reportCode: reportCode,
            radioCode: radioCode,
            hourDate: hourDate,
            unitCode: unitCode,
            message: message,
            updateDate: updateDate,
            unitCreate: unitCreate
        )
    );
    Navigator.pop(context);
  }
}