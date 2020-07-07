import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redeap/core/error/exceptions.dart';
import 'package:redeap/core/error/failures.dart';
import 'package:redeap/features/manage_news/data/datasources/remote_data_source.dart';
import 'package:redeap/features/manage_news/data/models/news_model.dart';
import 'package:redeap/features/manage_news/data/repositories/news_repository_impl.dart';
import 'package:redeap/features/manage_news/domain/entities/news.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  MockRemoteDataSource remoteDataSource;
  NewsRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    repository = NewsRepositoryImpl( remoteDataSource: remoteDataSource );
  });

  group('createNews', () {
    final String tNewsCode = '1';
    final String tReportCode = '1';
    final String tRadioCode = '5.20';
    final int tHourDate = 750000;
    final String tUnitCode = 'Does1';
    final String tMessage = 'Desplazamiento';
    final int tUpdateDate = 750000;
    final String tUnitCreate = 'Genesis2';

    test('should return ServerFailure when on data source is unsuccessful.', () async {
      // arrange
      when(remoteDataSource.createNews(any, any, any, any, any, any, any, any))
          .thenThrow(ServerException());
      // act
      final result = await repository.createNews(tNewsCode, tReportCode,
          tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate);
      // asserts
      expect(result, equals(Left(ServerFailure())));
      verify( remoteDataSource.createNews(tNewsCode, tReportCode,
          tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate));
    });

    test('should return null when data source is successful',() async {
      // arrange
      when( remoteDataSource.createNews(any, any, any, any, any, any, any, any) )
          .thenAnswer((_) async => null);
      // act
      final result = await repository.createNews(tNewsCode, tReportCode,
          tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate);
      // assert
      expect( result, equals( Right( null ) ) );
      verify( remoteDataSource.createNews(tNewsCode, tReportCode,
          tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate));
    });
  });

  group('deleteNews',() {
    final String tNewsCode = '1';

    test('should return ServerFailure when data source is unsuccessful',() async {
      // arrange
      when( remoteDataSource.deleteNews( any ) )
          .thenThrow( ServerException() );
      // act
      final result = await repository.deleteNews( tNewsCode );
      // assert
      expect( result, equals(Left( ServerFailure() ) ) );
      verify( remoteDataSource.deleteNews( tNewsCode ) );
    });

    test('should return null when data source is successful',() async {
      // arrange
      when( remoteDataSource.deleteNews( any ) )
          .thenAnswer((_) async => null );
      // act
      final result = await repository.deleteNews( tNewsCode );
      // assert
      expect( result, equals(Right( null ) ) );
      verify( remoteDataSource.deleteNews( tNewsCode ) );
    });
  });

  group('updateNews',(){
    final String tNewsCode = '1';
    final String tReportCode = '1';
    final String tRadioCode = '5.20';
    final int tHourDate = 750000;
    final String tUnitCode = 'Does1';
    final String tMessage = 'Desplazamiento';
    final int tUpdateDate = 750000;
    final String tUnitCreate = 'Genesis2';

    test('should return ServerFailure when data source is unsuccessful',() async {
      // arrange
      when(remoteDataSource.updateNews(any, any, any, any, any, any, any, any))
          .thenThrow(ServerException());
      // act
      final result = await repository.updateNews(tNewsCode, tReportCode,
          tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate);
      // assert
      expect( result, equals( Left( ServerFailure() ) ) );
      verify( remoteDataSource.updateNews(tNewsCode, tReportCode,
          tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate) );
    });

    test('should return null when data source is successful',() async {
      // arrange
      when(remoteDataSource.updateNews(any, any, any, any, any, any, any, any))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.updateNews(tNewsCode, tReportCode,
          tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate);
      // assert
      expect( result, equals( Right(null) ) );
      verify( remoteDataSource.updateNews(tNewsCode, tReportCode,
          tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate) );
    });
  });

  group('getNews',(){
    final String tReportCode = '1';
    final String tUnitCreate = '1';
    final int tDateCreate = 70000;

    final List<NewsModel> tNewsModelList = <NewsModel>[
      NewsModel(
          newsCode: '1',
          reportCode: '1',
          radioCode: '5.20',
          hourDate: 750000,
          unitCode: 'Does1',
          message: 'Desplazamiento',
          updateDate: 750000,
          unitCreate: 'Genesis2')
    ];

    final List<News> tNewsList = tNewsModelList;

    test('should return ServerFailure when data source is unsuccessful',() async {
      // arrange
      when( remoteDataSource.getNews( any, any, any) )
        .thenThrow( ServerException() );
      // act
      final result = await repository.getNews(tReportCode, tUnitCreate, tDateCreate );
      // assert
      expect( result, equals( Left( ServerFailure() ) ) );
      verify( remoteDataSource.getNews(tReportCode, tUnitCreate, tDateCreate ) );
    });

    test('should return news list when data source is successful',() async {
      // arrange
      when( remoteDataSource.getNews( any, any, any) )
          .thenAnswer( (_) async => tNewsModelList );
      // act
      final result = await repository.getNews( tReportCode, tUnitCreate, tDateCreate );
      // assert
      expect( result, equals( Right( tNewsList ) ) );
      verify( remoteDataSource.getNews( tReportCode, tUnitCreate, tDateCreate ) );
    });
  });
}
