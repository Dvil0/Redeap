import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class RadioCode extends Equatable {
  final String radioCode;
  final String description;
  final int dateCreate;
  final String userCreate;

  RadioCode({
    @required this.radioCode,
    @required this.description,
    @required this.dateCreate,
    @required this.userCreate
  }) : super( [ radioCode, description, dateCreate, userCreate ] );
}