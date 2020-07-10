import 'package:get_it/get_it.dart';
import 'package:redeap/core/api/cloud_fire_store_api.dart';
import 'package:redeap/features/manage_news/data/datasources/remote_data_source.dart';
import 'package:redeap/features/manage_news/data/repositories/news_repository_impl.dart';
import 'package:redeap/features/manage_news/domain/repositories/news_repository.dart';
import 'package:redeap/features/manage_news/domain/usecases/create_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/delete_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/get_news.dart';
import 'package:redeap/features/manage_news/domain/usecases/update_news.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  await _initNews();
}

Future<void> _initNews() async {
  // Bloc
  di.registerFactory(() => NewsBloc(
    create: di(),
    update: di(),
    get: di(),
    delete: di()
  ));
  
  // Use Cases
  di.registerLazySingleton(() => CreateNews( di() ) );
  di.registerLazySingleton(() => UpdateNews( di() ) );
  di.registerLazySingleton(() => GetNews( di() ) );
  di.registerLazySingleton(() => DeleteNews( di() ) );

  // Repository
  di.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
    remoteDataSource: di()
  ));

  // Data Source
  di.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
    cloudFireStoreApi: di()
  ));

  // External
  di.registerLazySingleton<CloudFireStoreApi>(() => CloudFireStoreApiImpl(
    path: 'news'
  ));
}