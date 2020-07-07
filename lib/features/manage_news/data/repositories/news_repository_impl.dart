import 'package:dartz/dartz.dart';
import 'package:redeap/core/error/exceptions.dart';
import 'package:redeap/core/error/failures.dart';
import 'package:redeap/features/manage_news/data/datasources/remote_data_source.dart';
import 'package:redeap/features/manage_news/domain/entities/news.dart';
import 'package:redeap/features/manage_news/domain/repositories/news_repository.dart';

typedef Future<dynamic> _DataSourceOutput();

class NewsRepositoryImpl implements NewsRepository{
  final RemoteDataSource remoteDataSource;

  NewsRepositoryImpl({ this.remoteDataSource });

  @override
  Future<Either<Failure, void>> createNews(String newsCode, String reportCode, String radioCode, int hourDate, String unitCode, String message, int updateDate, String unitCreate) async {
    return await _runDataSource(() => remoteDataSource.createNews(newsCode, reportCode, radioCode, hourDate, unitCode, message, updateDate, unitCreate));
  }

  @override
  Future<Either<Failure, void>> deleteNews(String newsCode)  async {
    return await _runDataSource(() => remoteDataSource.deleteNews( newsCode ) );
  }

  @override
  Future<Either<Failure, List<News>>> getNews(String reportCode, String unitCreate, int dateCreate) async {
//    return await _runDataSource(() => remoteDataSource.getNews(reportCode, unitCreate, dateCreate) );
    try{
      final result = await remoteDataSource.getNews(reportCode, unitCreate, dateCreate);
      return Right( result );
    } on ServerException {
      return Left( ServerFailure() );
    }
  }

  @override
  Future<Either<Failure, void>> updateNews(String newsCode, String reportCode, String radioCode, int hourDate, String unitCode, String message, int updateDate, String unitCreate) async {
    return await _runDataSource(() => remoteDataSource.updateNews(newsCode, reportCode, radioCode, hourDate, unitCode, message, updateDate, unitCreate));
  }

  Future<Either<Failure, dynamic>> _runDataSource(
      _DataSourceOutput execute
  ) async {
    try{
      final result = await execute();
      return Right( result );
    } on ServerException {
      return Left( ServerFailure() );
    }
  }
}