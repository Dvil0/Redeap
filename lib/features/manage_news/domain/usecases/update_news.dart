import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:redeap/core/error/failures.dart';
import 'package:redeap/core/usecase/usecase.dart';
import 'package:meta/meta.dart';
import 'package:redeap/features/manage_news/domain/repositories/news_repository.dart';

class UpdateNews implements UseCase<void, UpdateParams> {
  final NewsRepository repository;

  UpdateNews( this.repository );

  @override
  Future<Either<Failure, void>> call( UpdateParams params) async {
    return await repository.updateNews(
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

class UpdateParams extends Equatable {
  final String newsCode;
  final String reportCode;
  final String radioCode;
  final int hourDate;
  final String unitCode;
  final String message;
  final int updateDate;
  final String unitCreate;

  UpdateParams(
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