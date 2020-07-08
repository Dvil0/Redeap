import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:redeap/features/manage_news/domain/entities/news.dart';

@immutable
abstract class NewsState extends Equatable {
  NewsState( [List proper = const <dynamic>[]] ) : super( [proper] );
}

class Empty extends NewsState {}

class Loading extends NewsState {}

class Loaded extends NewsState {
  final List<News> newsList;

  Loaded({@required this.newsList}) : super([newsList]);
}

class Error extends NewsState {
  final String message;

  Error({@required this.message}) : super([message]);
}
