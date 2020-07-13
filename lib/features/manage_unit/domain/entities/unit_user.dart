import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UnitUser extends Equatable {
  final String unitName;
  final String unitNumber;
  final int dateCreate;

  UnitUser({
    @required this.unitName,
    @required this.unitNumber,
    @required this.dateCreate
  }) : super( [ unitName, unitNumber, dateCreate ] );

}