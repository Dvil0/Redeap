import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:redeap/core/error/failures.dart';
import 'package:redeap/core/usecase/usecase.dart';
import 'package:meta/meta.dart';
import 'package:redeap/features/manage_news/domain/repositories/news_repository.dart';

class CreateNews implements UseCase<void, Params> {
  final NewsRepository repository;

  CreateNews(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.createNews(
        params.newsCode,
        params.reportCode,
        params.radioCode,
        params.hourDate,
        params.unitCode,
        params.message,
        params.updateDate,
        params.unitCreate);
  }
}

class Params extends Equatable {
  final String newsCode;
  final String reportCode;
  final String radioCode;
  final int hourDate;
  final String unitCode;
  final String message;
  final int updateDate;
  final String unitCreate;

  Params(
      {@required this.newsCode,
      @required this.reportCode,
      @required this.radioCode,
      @required this.hourDate,
      @required this.unitCode,
      this.message,
      @required this.updateDate,
      @required this.unitCreate})
      : super([newsCode, reportCode, radioCode, hourDate, unitCode, message, updateDate, unitCreate]);
}
