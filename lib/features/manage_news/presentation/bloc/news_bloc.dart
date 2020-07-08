import 'package:bloc/bloc.dart';
import 'package:redeap/features/manage_news/domain/usecases/create_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/delete_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/get_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/update_news.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_event.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_state.dart';
import 'package:meta/meta.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
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

      CreateParams createParams = CreateParams(
        newsCode: event.newsCode,
        reportCode: event.reportCode,
        radioCode: event.radioCode,
        hourDate: event.hourDate,
        unitCode: event.unitCode,
        message: event.message,
        updateDate: event.updateDate,
        unitCreate: event.unitCreate
      );
      final result = await createNews( createParams );
      yield result.fold(
        ( failure ){
          return Error( message: SERVER_FAILURE_MESSAGE );
        }, (_) {
          return Loading();
        }
      );

      final getParams = GetParams(
          reportCode: event.reportCode,
          dateCreate: event.hourDate,
          unitCreate: event.unitCreate
      );
      final getEither = await getNews( getParams );
      yield getEither.fold(
        ( failure ){
          return Error( message: SERVER_FAILURE_MESSAGE );
        }, ( newsList ) {
          return Loaded( newsList: newsList );
        }
      );
    } else if ( event is UpdateNewsForUser ) {
      final result = await updateNews( UpdateParams() );
      yield result.fold(
        ( failure ){
          return Error( message: SERVER_FAILURE_MESSAGE );
        }, (_) {
          return Loading();
        }
      );
      final getParams = GetParams(
          reportCode: event.reportCode,
          dateCreate: event.hourDate,
          unitCreate: event.unitCreate
      );
      final getEither = await getNews( getParams );
      yield getEither.fold((l) => Error( message: SERVER_FAILURE_MESSAGE), ( newsList ) => Loaded( newsList: newsList ));
    }
  }

}