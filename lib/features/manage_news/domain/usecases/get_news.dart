import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:redeap/core/error/failures.dart';
import 'package:redeap/core/usecase/usecase.dart';
import 'package:redeap/features/manage_news/domain/entities/news.dart';
import 'package:meta/meta.dart';
import 'package:redeap/features/manage_news/domain/repositories/news_repository.dart';

class GetNews implements UseCase<List<News>, GetParams> {

  final NewsRepository repository;

  GetNews( this.repository );

  @override
  Future<Either<Failure, List<News>>> call( GetParams params ) async {
    return await repository.getNews( params.reportCode, params.unitCreate, params.dateCreate );
  }
}

class GetParams extends Equatable {
  final String reportCode;
  final String unitCreate;
  final int dateCreate;

  GetParams({
    @required this.reportCode,
    @required this.unitCreate,
    @required this.dateCreate
  }) : super( [ reportCode, unitCreate, dateCreate ] );
}