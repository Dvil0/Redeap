import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:redeap/core/error/failures.dart';
import 'package:redeap/core/usecase/usecase.dart';
import 'package:redeap/features/manage_news/domain/repositories/news_repository.dart';
import 'package:meta/meta.dart';

class DeleteNews implements UseCase<void, Params> {
  final NewsRepository repository;

  DeleteNews( this.repository );

  @override
  Future<Either<Failure, void>> call( Params params ) async {
    return await repository.deleteNews( params.newsCode );
  }
}

class Params extends Equatable {
  final String newsCode;

  Params({ @required this.newsCode }) : super( [ newsCode ] );
}