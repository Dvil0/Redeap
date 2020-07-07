import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redeap/features/manage_news/domain/repositories/news_repository.dart';
import 'package:redeap/features/manage_news/domain/usecases/update_news.dart';

class MockNewsRepository extends Mock
  implements NewsRepository {}

void main() {
  MockNewsRepository mockNewsRepository;
  UpdateNews usecase;

  setUp((){
    mockNewsRepository = MockNewsRepository();
    usecase = UpdateNews( mockNewsRepository );
  });

  final Params tParams = Params( newsCode: '1' );

  test('should return null when news has been update',
    () async{
    // arrange
    when( mockNewsRepository.updateNews( any ) )
        .thenAnswer((_) async => Right(null) );
    // act
    final result = await usecase( tParams );
    // assert
    expect( result, equals( Right(null) ) );
    verify( mockNewsRepository.updateNews( tParams.newsCode ) );
    verifyNoMoreInteractions( mockNewsRepository );
  });
}