import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:redeap/core/error/failures.dart';
import 'package:redeap/features/manage_news/domain/usecases/create_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/delete_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/get_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/update_news.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_event.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_state.dart';
import 'package:meta/meta.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

typedef Future<Either<Failure, dynamic>> _FailureOrData();
class NewsBloc extends Bloc<NewsEvent, NewsState> {

  final GetNews getNews;
  final CreateNews createNews;
  final UpdateNews updateNews;
  final DeleteNews deleteNews;

  NewsBloc({
    @required GetNews get,
    @required CreateNews create,
    @required UpdateNews update,
    @required DeleteNews delete
  }) : getNews = get,
      createNews = create,
      updateNews = update,
      deleteNews = delete;

  @override
  NewsState get initialState => Empty();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if( event is CreateNewsForUser ) {

      final createParams = CreateParams(
        newsCode: event.newsCode,
        reportCode: event.reportCode,
        radioCode: event.radioCode,
        hourDate: event.hourDate,
        unitCode: event.unitCode,
        message: event.message,
        updateDate: event.updateDate,
        unitCreate: event.unitCreate
      );
      yield* _runEvent(() => createNews( createParams ) );

      final getParams = GetParams(
          reportCode: event.reportCode,
          dateCreate: event.hourDate,
          unitCreate: event.unitCreate
      );
      yield* _getNewsStates(getParams);

    } else if ( event is UpdateNewsForUser ) {

      final updateParams = UpdateParams(
          newsCode: event.newsCode,
          reportCode: event.reportCode,
          radioCode: event.radioCode,
          hourDate: event.hourDate,
          unitCode: event.unitCode,
          message: event.message,
          updateDate: event.updateDate,
          unitCreate: event.unitCreate
      );
      yield* _runEvent(() => updateNews( updateParams ));

      final getParams = GetParams(
          reportCode: event.reportCode,
          dateCreate: event.hourDate,
          unitCreate: event.unitCreate
      );

      yield* _getNewsStates(getParams);

    } else if ( event is GetNewsForUser ) {

      final getParams = GetParams(
        reportCode: event.reportCode,
        unitCreate: event.unitCreate,
        dateCreate: event.dateCreate
      );
      yield Loading();
      yield* _getNewsStates(getParams);

    } else if ( event is DeleteNewsForUser ) {

      final deleteParams = DeleteParams( newsCode: event.newsCode );
      yield* _runEvent(() => deleteNews( deleteParams ));

      final getParams = GetParams(
          reportCode: event.reportCode,
          unitCreate: event.unitCreate,
          dateCreate: event.dateCreate
      );
      yield* _getNewsStates(getParams);

    }
  }

  Stream<NewsState> _getNewsStates( GetParams getParams ) async* {
    final getEither = await getNews( getParams );
    yield getEither.fold(
      ( failure ){
        return Error( message: SERVER_FAILURE_MESSAGE );
      }, ( newsList ) {
        return Loaded( newsList: newsList );
      }
    );
  }

  Stream<NewsState> _runEvent(
      _FailureOrData useCase
  ) async* {
    final result = await useCase();
    yield result.fold(
      ( failure ){
        return Error( message: SERVER_FAILURE_MESSAGE );
      }, (_) {
       return Loading();
      }
    );
  }
}