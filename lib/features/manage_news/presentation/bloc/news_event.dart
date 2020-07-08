import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsEvent extends Equatable {
  NewsEvent( [ List proper = const <dynamic>[] ] ) : super( proper );
}

class GetNewsForUser extends NewsEvent {
  final String reportCode;
  final String unitCreate;
  final int dateCreate;

  GetNewsForUser({this.reportCode, this.unitCreate, this.dateCreate}) : super( [reportCode, unitCreate, dateCreate] );
}

class CreateNewsForUser extends NewsEvent {
  final String newsCode;
  final String reportCode;
  final String radioCode;
  final int hourDate;
  final String unitCode;
  final String message;
  final int updateDate;
  final String unitCreate;

  CreateNewsForUser({
    this.newsCode,
    this.reportCode,
    this.radioCode,
    this.hourDate,
    this.unitCode,
    this.message,
    this.updateDate,
    this.unitCreate
  }) : super([newsCode, reportCode, radioCode, hourDate, unitCode, message, updateDate, unitCreate]);
}

class UpdateNewsForUser extends NewsEvent {
  final String newsCode;
  final String reportCode;
  final String radioCode;
  final int hourDate;
  final String unitCode;
  final String message;
  final int updateDate;
  final String unitCreate;

  UpdateNewsForUser({
    this.newsCode,
    this.reportCode,
    this.radioCode,
    this.hourDate,
    this.unitCode,
    this.message,
    this.updateDate,
    this.unitCreate
  }) : super([newsCode, reportCode, radioCode, hourDate, unitCode, message, updateDate, unitCreate]);
}

class DeleteNewsForUser extends NewsEvent {
  final String newsCode;

  DeleteNewsForUser({this.newsCode}) : super([newsCode]);
}