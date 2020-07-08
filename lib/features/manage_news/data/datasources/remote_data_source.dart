import 'dart:developer';

import 'package:redeap/core/api/cloud_fire_store_api.dart';
import 'package:redeap/core/error/exceptions.dart';
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

class RemoteDataSourceImpl implements RemoteDataSource {

  CloudFireStoreApi cloudFireStoreApi;

  RemoteDataSourceImpl({ this.cloudFireStoreApi });

  @override
  Future<void> createNews(String newsCode, String reportCode, String radioCode, int hourDate, String unitCode, String message, int updateDate, String unitCreate) async {
    NewsModel newsModel;

    try {
      newsModel = NewsModel(
          newsCode: newsCode,
          reportCode: reportCode,
          radioCode: radioCode,
          hourDate: hourDate,
          unitCode: unitCode,
          message: message,
          updateDate: updateDate,
          unitCreate: unitCreate
      );
      await cloudFireStoreApi.addDocument( newsModel.toJson() );
    } catch( exception ) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteNews(String newsCode) async {
    try{
      await cloudFireStoreApi.removeDocument( newsCode );
    } catch( exception ) {
      throw ServerException();
    }
  }

  @override
  Future<List<NewsModel>> getNews(String reportCode, String unitCreate, int dateCreate) async{
    try{
      final result = await cloudFireStoreApi.getDocuments(reportCode, unitCreate, dateCreate);
      final List<NewsModel> newsModelList = result.documents
        .map( ( doc ) => NewsModel.fromJson( doc.data ) )
        .toList();
      return newsModelList;
    } catch( exception ) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateNews(String newsCode, String reportCode, String radioCode, int hourDate, String unitCode, String message, int updateDate, String unitCreate) async {
    NewsModel newsModel;
    try{
      newsModel = NewsModel(
          newsCode: newsCode,
          reportCode: reportCode,
          radioCode: radioCode,
          hourDate: hourDate,
          unitCode: unitCode,
          message: message,
          updateDate: updateDate,
          unitCreate: unitCreate
      );
      await cloudFireStoreApi.updateDocument( newsModel.toJson(), newsCode );

    }catch( exception ) {
      throw ServerException();
    }
  }

}