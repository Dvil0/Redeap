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

  final Params tParams = Params(
      newsCode: '1',
      reportCode: '1',
      radioCode: '5.20',
      hourDate: 750000,
      unitCode: 'Does1',
      message: 'Desplazamiento',
      updateDate: 750000,
      unitCreate: 'Genesis2');

  test('should return null when news has been update',
    () async{
    // arrange
    when( mockNewsRepository.updateNews(any, any, any, any, any, any, any, any) )
        .thenAnswer((_) async => Right(null) );
    // act
    final result = await usecase( tParams );
    // assert
    expect( result, equals( Right(null) ) );
    verify( mockNewsRepository.updateNews( tParams.newsCode, tParams.reportCode, tParams.radioCode, tParams.hourDate, tParams.unitCode, tParams.message, tParams.updateDate, tParams.unitCreate) );
    verifyNoMoreInteractions( mockNewsRepository );
  });
}