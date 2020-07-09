import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redeap/core/error/failures.dart';
import 'package:redeap/features/manage_news/domain/entities/news.dart';
import 'package:redeap/features/manage_news/domain/usecases/create_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/delete_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/get_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/update_news.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_bloc.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_event.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_state.dart';

class MockGetNews extends Mock
  implements GetNews {}

class MockCreateNews extends Mock
  implements CreateNews {}

class MockUpdateNews extends Mock
  implements UpdateNews {}

class MockDeleteNews extends Mock
  implements DeleteNews {}

void main() {
  NewsBloc newsBloc;
  MockGetNews getNews;
  MockCreateNews createNews;
  MockUpdateNews updateNews;
  MockDeleteNews deleteNews;

  setUp((){
    getNews = MockGetNews();
    createNews = MockCreateNews();
    updateNews = MockUpdateNews();
    deleteNews = MockDeleteNews();
    newsBloc = NewsBloc(
      get: getNews,
      create: createNews,
      update: updateNews,
      delete: deleteNews
    );
  });

  test('should be empty when bloc is initialized',(){
    // assert
    expect( newsBloc.initialState, equals( Empty() ) );
  });

  group('CreateNewsForUser',(){
    final String tNewsCode = '1';
    final String tReportCode = '1';
    final String tRadioCode = '5.20';
    final int tHourDate = 750000;
    final String tUnitCode = 'Does1';
    final String tMessage = 'Desplazamiento';
    final int tUpdateDate = 750000;
    final String tUnitCreate = 'Genesis2';

    test('should emit [Error] when use case is unsuccessful',() async {
      // arrange
      when( createNews( any ) )
        .thenAnswer((_) async => Left( ServerFailure() ) );

      final expected = [
        Empty(),
        Error( message: SERVER_FAILURE_MESSAGE )
      ];
      // assert
      expectLater( newsBloc.state, emitsInOrder( expected ) );
      // act
      newsBloc.dispatch( CreateNewsForUser() );
    });

    final News tNews = News(
        newsCode: tNewsCode,
        reportCode: tReportCode,
        radioCode: tRadioCode,
        hourDate: tHourDate,
        unitCode: tUnitCode,
        message: tMessage,
        updateDate: tUpdateDate,
        unitCreate: tUnitCreate
    );

    final GetParams tGetParams = GetParams(
        reportCode: tReportCode,
        dateCreate: tHourDate,
        unitCreate: tUnitCreate
    );
    final tNewsList = [ tNews ];

    test('should emits [Error] when retrieve news list after unsuccessful use case',() async {
      // arrange
      when( createNews( any ))
          .thenAnswer((_) async => Right(null));
      when( getNews( any ) )
          .thenAnswer((_) async => Left(ServerFailure()) );
      // assert
      final expected = [
        Empty(),
        Loading(),
        Error( message: SERVER_FAILURE_MESSAGE )
      ];
      expectLater( newsBloc.state, emitsInOrder( expected ) );
      // act
      newsBloc.dispatch( CreateNewsForUser(
          newsCode: tNewsCode,
          reportCode: tReportCode,
          radioCode: tRadioCode,
          hourDate: tHourDate,
          unitCode: tUnitCode,
          message: tMessage,
          updateDate: tUpdateDate,
          unitCreate: tUnitCreate
        )
      );
      await untilCalled( getNews(any) );
      verify( getNews( tGetParams ));
    });

    test('should get newsList and emit [Loading, Loaded] when use case is successful',() async {
      // arrange
      when( createNews( any ) )
          .thenAnswer((_) async => Right( null ));
      when( getNews( any ) )
          .thenAnswer( (_) async => Right(tNewsList) );
      // assert
      final expected = [
        Empty(),
        Loading(),
        Loaded( newsList: tNewsList )
      ];
      expectLater( newsBloc.state, emitsInOrder( expected ) );
      // act
      newsBloc.dispatch( CreateNewsForUser(
          newsCode: tNewsCode,
          reportCode: tReportCode,
          radioCode: tRadioCode,
          hourDate: tHourDate,
          unitCode: tUnitCode,
          message: tMessage,
          updateDate: tUpdateDate,
          unitCreate: tUnitCreate
        )
      );
      await untilCalled( getNews( any ));
      verify( getNews( tGetParams ));
    });
  });

  group('UpdateNewsForUser',(){
    final String tNewsCode = '1';
    final String tReportCode = '1';
    final String tRadioCode = '5.20';
    final int tHourDate = 750000;
    final String tUnitCode = 'Does1';
    final String tMessage = 'Desplazamiento';
    final int tUpdateDate = 750000;
    final String tUnitCreate = 'Genesis2';

    test('should emits [Error] when use case is unsuccessful',() async {
      // arrange
      when( updateNews( any ) )
          .thenAnswer((_) async => Left( ServerFailure() ) );
      // assert
      final expected = [
        Empty(),
        Error( message: SERVER_FAILURE_MESSAGE )
      ];
      expectLater( newsBloc.state, emitsInOrder( expected ));
      // act
      newsBloc.dispatch( UpdateNewsForUser() );
    });

    test('should emits [Loading] when use case is successful',() async {
      // arrange
      when( updateNews( any ) )
          .thenAnswer((_) async => Right( null ) );
      // assert
      final expected = [
        Empty(),
        Loading()
      ];
      expectLater( newsBloc.state, emitsInOrder( expected ));
      // act
      newsBloc.dispatch( UpdateNewsForUser() );
    });

    final News tNews = News(
        newsCode: tNewsCode,
        reportCode: tReportCode,
        radioCode: tRadioCode,
        hourDate: tHourDate,
        unitCode: tUnitCode,
        message: tMessage,
        updateDate: tUpdateDate,
        unitCreate: tUnitCreate
    );

    final GetParams tGetParams = GetParams(
        reportCode: tReportCode,
        dateCreate: tHourDate,
        unitCreate: tUnitCreate
    );
    final tNewsList = [ tNews ];

    test('should emit [Loading, Error] when retrieve news list after successful use case',()async {
      // arrange
      when( updateNews( any ) )
          .thenAnswer((_) async => Right(null));
      when( getNews( any ) )
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert
      final expected = [
        Empty(),
        Loading(),
        Error( message: SERVER_FAILURE_MESSAGE )
      ];
      expectLater( newsBloc.state, emitsInOrder(expected));
      // act
      newsBloc.dispatch( UpdateNewsForUser(
          newsCode: tNewsCode,
          reportCode: tReportCode,
          radioCode: tRadioCode,
          hourDate: tHourDate,
          unitCode: tUnitCode,
          message: tMessage,
          updateDate: tUpdateDate,
          unitCreate: tUnitCreate
        )
      );
    });

    test('should emits [Loading, Loaded] when retrieve news list after successful use case',() async{
      // arrange
      when( updateNews( any ) )
          .thenAnswer((_) async => Right(null));
      when( getNews( any ) )
          .thenAnswer((_) async => Right( tNewsList ));
      // assert
      final expected = [
        Empty(),
        Loading(),
        Loaded( newsList: tNewsList )
      ];
      expectLater( newsBloc.state, emitsInOrder(expected));
      // act
      newsBloc.dispatch( UpdateNewsForUser(
          newsCode: tNewsCode,
          reportCode: tReportCode,
          radioCode: tRadioCode,
          hourDate: tHourDate,
          unitCode: tUnitCode,
          message: tMessage,
          updateDate: tUpdateDate,
          unitCreate: tUnitCreate
        )
      );
      await untilCalled( getNews( any ) );
      verify( getNews( tGetParams ));
    });
  });

  group('GetNewsForUser',(){
    final String tReportCode = '1';
    final String tUnitCreate = 'Genesis2';
    final int tDateCreate = 750000;

    final tNewsList = <News>[ News(
        newsCode: '1',
        reportCode: '1',
        radioCode: '5.20',
        hourDate: 750000,
        unitCode: 'Does1',
        message: 'Desplazamiento',
        updateDate: 750000,
        unitCreate: 'Genesis2') ];

    final tParams = GetParams( reportCode: '1', unitCreate: 'Genesis2', dateCreate: 750000 );

    test('should emits [Loading, Error] when use case is unsuccessful',() async {
      // arrange
      when( getNews( any ) )
          .thenAnswer((_) async => Left( ServerFailure() ) );
      // assert
      final expected = [
        Empty(),
        Loading(),
        Error( message: SERVER_FAILURE_MESSAGE )
      ];
      expectLater( newsBloc.state, emitsInOrder( expected ) );
      // act
      newsBloc.dispatch( GetNewsForUser() );
    });

    test('should emits [Loading, Loaded] when use case is successful',() async {
      // arrange
      when( getNews( any ) )
          .thenAnswer((_) async => Right( tNewsList ) );
      // assert
      final expected = [
        Empty(),
        Loading(),
        Loaded( newsList: tNewsList )
      ];
      expectLater( newsBloc.state, emitsInOrder( expected ) );
      // act
      newsBloc.dispatch( GetNewsForUser( reportCode: tReportCode, dateCreate: tDateCreate, unitCreate: tUnitCreate ) );
      await untilCalled( getNews( any ) );
      verify( getNews( tParams ));
    });
  });

  group('DeleteForUser',(){
    final String tNewsCode = '1';
    final String tReportCode = '1';
    final String tUnitCreate = 'Genesis2';
    final int tDateCreate = 750000;

    test('should emits [Error] when use case is unsuccessful',() async {
      // arrange
      when( deleteNews( any ) )
          .thenAnswer((realInvocation) async => Left(ServerFailure()) );
      // assert
      final expected = [
        Empty(),
        Error( message: SERVER_FAILURE_MESSAGE )
      ];
      expectLater( newsBloc.state, emitsInOrder( expected ) );
      // act
      newsBloc.dispatch( DeleteNewsForUser() );
    });

    test('should emits [Loading, Error] when retrieve news list after successful use case',() async {
      // arrange
      when( deleteNews( any ) )
          .thenAnswer((_) async => Right(null) );
      when( getNews( any ) )
          .thenAnswer((_) async => Left( ServerFailure() ) );
      // assert
      final expected = [
        Empty(),
        Loading(),
        Error( message: SERVER_FAILURE_MESSAGE )
      ];
      expectLater( newsBloc.state, emitsInOrder( expected ) );
      // act
      newsBloc.dispatch( DeleteNewsForUser() );
    });

    final GetParams tGetParams = GetParams(
        reportCode: tReportCode,
        dateCreate: tDateCreate,
        unitCreate: tUnitCreate
    );
    final tNewsList = <News>[
      News(
          newsCode: '1',
          reportCode: '1',
          radioCode: '5.20',
          hourDate: 750000,
          unitCode: 'Does1',
          message: 'Desplazamiento',
          updateDate: 750000,
          unitCreate: 'Genesis2'
      )
    ];

    test('should emits [Loading, Loaded] when retrieve news list after successful use case',() async {
      // arrange
      when( deleteNews( any ) )
          .thenAnswer((_) async => Right(null) );
      when( getNews( any ) )
          .thenAnswer((_) async => Right( tNewsList ) );
      // assert
      final expected = [
        Empty(),
        Loading(),
        Loaded( newsList: tNewsList)
      ];
      expectLater( newsBloc.state, emitsInOrder( expected ) );
      // act
      newsBloc.dispatch( DeleteNewsForUser(
        newsCode: tNewsCode,
        reportCode: tReportCode,
        unitCreate: tUnitCreate,
        dateCreate: tDateCreate
        )
      );
      await untilCalled( getNews( any ) );
      verify( getNews( tGetParams ) );
    });

  });
}