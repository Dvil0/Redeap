import 'package:dartz/dartz.dart';
import 'package:redeap/core/error/failures.dart';
import 'package:redeap/features/manage_news/domain/entities/news.dart';

abstract class NewsRepository {
  Future<Either<Failure, void>> createNews(
    String newsCode,
    String reportCode,
    String radioCode,
    int hourDate,
    String unitCode,
    String message,
    int updateDate,
    String unitCreate,
  );

  Future<Either<Failure, List<News> >> getNews( String reportCode, String unitCreate, int dateCreate );

  Future<Either<Failure, void>> deleteNews( String newsCode );

  Future<Either<Failure, void>> updateNews(
      String newsCode,
      String reportCode,
      String radioCode,
      int hourDate,
      String unitCode,
      String message,
      int updateDate,
      String unitCreate,
    );
}