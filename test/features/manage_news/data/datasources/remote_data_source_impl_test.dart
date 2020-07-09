import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redeap/core/api/cloud_fire_store_api.dart';
import 'package:redeap/core/error/exceptions.dart';
import 'package:redeap/features/manage_news/data/datasources/remote_data_source.dart';
import 'package:redeap/features/manage_news/data/models/news_model.dart';

class MockCloudFireStoreApi extends Mock
    implements CloudFireStoreApi {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot {}



void main() {
  MockCloudFireStoreApi cloudFireStoreApi;
  RemoteDataSourceImpl remoteDataSourceImpl;

  setUp((){
    cloudFireStoreApi = MockCloudFireStoreApi();
    remoteDataSourceImpl = RemoteDataSourceImpl( cloudFireStoreApi: cloudFireStoreApi );
  });

  group('createNews',(){

    final String tNewsCode = '1';
    final String tReportCode = '1';
    final String tRadioCode = '5.20';
    final int tHourDate = 750000;
    final String tUnitCode = 'Does1';
    final String tMessage = 'Desplazamiento';
    final int tUpdateDate = 750000;
    final String tUnitCreate = 'Genesis2';

    test('should throws ServerException when api have error',() async {
      // arrange
      when( cloudFireStoreApi.addDocument( any ) )
          .thenThrow( Exception() );
      try{
        // act
        await remoteDataSourceImpl.createNews(tNewsCode, tReportCode,
            tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate);
      } catch( exception ) {
        // assert
        expect( exception , isA<ServerException>() );
      }
    });

    final tNewsModel = NewsModel(
        newsCode: tNewsCode,
        reportCode: tReportCode,
        radioCode: tRadioCode,
        hourDate: tHourDate,
        unitCode: tUnitCode,
        message: tMessage,
        updateDate: tUpdateDate,
        unitCreate: tUnitCreate
    );

    test('should convert data in JSON when api doesn\'t have error',() async {
      // act
      await remoteDataSourceImpl.createNews(tNewsCode, tReportCode,
          tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate);
      // assert
      verify( cloudFireStoreApi.addDocument( tNewsModel.toJson() ) );
    });
  });

  group('deleteNews', (){
    final String tNewsCode = '1';

    test('should throw ServerException when the api is unsuccessful',() async {
     try{
        // arrange
        when( cloudFireStoreApi.removeDocument( any ) )
            .thenThrow( Exception() );
        // act
        await remoteDataSourceImpl.deleteNews( tNewsCode );

      } catch( exception ) {
        // assert
        expect( exception , isA<ServerException>() );
      }
    });

    test('should finish when api is successful ',() async{
      // arrange
      when( cloudFireStoreApi.removeDocument( any ) )
          .thenAnswer((_) async => null);
      // act
      await remoteDataSourceImpl.deleteNews( tNewsCode );
      // assert
      verify( cloudFireStoreApi.removeDocument( tNewsCode ) );
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

    final tNewsModel = NewsModel(
        newsCode: tNewsCode,
        reportCode: tReportCode,
        radioCode: tRadioCode,
        hourDate: tHourDate,
        unitCode: tUnitCode,
        message: tMessage,
        updateDate: tUpdateDate,
        unitCreate: tUnitCreate
    );

    test('should throws ServerException when api have error', () async {
      try{
        // arrange
        when( cloudFireStoreApi.updateDocument( any, any ) )
            .thenThrow( Exception() );
        // act
        await remoteDataSourceImpl.updateNews(tNewsCode, tReportCode,
            tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate);
      } catch( exception ) {
        // assert
        expect( exception, isA<ServerException>() );
      }

    });

    test('should convert data to JSON and finish when api is successful',() async {
      // arrange
      when( cloudFireStoreApi.updateDocument( any, any ) )
          .thenAnswer((_) async => null);
      // act
      await remoteDataSourceImpl.updateNews(tNewsCode, tReportCode,
          tRadioCode, tHourDate, tUnitCode, tMessage, tUpdateDate, tUnitCreate);
      // assert
      verify( cloudFireStoreApi.updateDocument( tNewsModel.toJson(), tNewsCode ) );
    });
  });

  group('getNews', (){
    final String tReportCode = '1';
    final String tUnitCreate = '1';
    final int tDateCreate = 70000;

    final NewsModel tNewsModel = NewsModel(
      newsCode: '1',
      reportCode: '1',
      radioCode: '5.20',
      hourDate: 750000,
      unitCode: 'Does1',
      message: 'Desplazamiento',
      updateDate: 750000,
      unitCreate: 'Genesis2'
    );

    final List<NewsModel> tNewsModelList = <NewsModel>[
      tNewsModel
    ];

    test('should throw ServerException when api is unsuccessful',() async {
      try{
        // arrange
        when( cloudFireStoreApi.getDocuments( any, any, any ) )
            .thenThrow( Exception() );
        // act
        await remoteDataSourceImpl.getNews( tReportCode, tUnitCreate, tDateCreate);
      } catch( exception ) {
        // assert
        expect( exception, isA<ServerException>() );
      }
    });

    final MockQuerySnapshot mockQuerySnapshot = MockQuerySnapshot();
    final MockDocumentSnapshot mockDocumentSnapshot = MockDocumentSnapshot();
    test('should return News list and complete when api is successful',() async{
      // arrange
      when( cloudFireStoreApi.getDocuments( any, any, any ) )
        .thenAnswer((_) async => mockQuerySnapshot );
      when( mockQuerySnapshot.documents ).thenReturn( [mockDocumentSnapshot] );
      when( mockDocumentSnapshot.data ).thenReturn( tNewsModel.toJson() );
      // act
      final result = await remoteDataSourceImpl.getNews(tReportCode, tUnitCreate, tDateCreate );
      // assert
      expect( result, equals( tNewsModelList ) );
      verify( cloudFireStoreApi.getDocuments(tReportCode, tUnitCreate, tDateCreate ) );
    });

  });
}