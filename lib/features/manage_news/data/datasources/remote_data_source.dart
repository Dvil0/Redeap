import 'package:redeap/features/manage_news/data/models/news_model.dart';

abstract class RemoteDataSource {

  /// Calls the 'add event' endpoint from FireStore
  /// Throws [ServerFailure] for all error codes.
  Future<void> createNews(
      String newsCode,
      String reportCode,
      String radioCode,
      int hourDate,
      String unitCode,
      String message,
      int updateDate,
      String unitCreate,
    );

  /// Calls the 'list documents' endpoint from FireStore
  /// Throws [ServerFailure] for all error codes.
  Future<List<NewsModel>> getNews( String reportCode, String unitCreate, int dateCreate );

  /// Calls the 'update event' endpoint from FireStore
  /// Throws [ServerFailure] for all error codes.
  Future<void> updateNews(
      String newsCode,
      String reportCode,
      String radioCode,
      int hourDate,
      String unitCode,
      String message,
      int updateDate,
      String unitCreate,
    );

  /// Calls the 'remove document' from FireStore
  /// Throws [ServerFailure] for all error codes.
  Future<void> deleteNews( String newsCode );
}