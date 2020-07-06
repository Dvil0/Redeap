import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class News extends Equatable {
  final String newsCode;
  final String reportCode;
  final String radioCode;
  final int hourDate;
  final String unitCode;
  final String message;
  final int updateDate;
  final String unitCreate;

  News({
    @required this.newsCode,
    @required this.reportCode,
    @required this.radioCode,
    @required this.hourDate,
    @required this.unitCode,
    this.message,
    @required this.updateDate,
    @required this.unitCreate
  }) : super( [ newsCode, reportCode, radioCode, hourDate, unitCode, message, updateDate, unitCreate ] );
}