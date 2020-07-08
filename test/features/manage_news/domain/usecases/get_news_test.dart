import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redeap/features/manage_news/domain/entities/news.dart';
import 'package:redeap/features/manage_news/domain/repositories/news_repository.dart';
import 'package:redeap/features/manage_news/domain/usecases/get_news.dart';

class MockNewsRepository extends Mock
  implements NewsRepository {}

void main() {
  GetNews usecase;
  MockNewsRepository mockNewsRepository;

  setUp((){
    mockNewsRepository = MockNewsRepository();
    usecase = GetNews( mockNewsRepository );
  });

  final tNewsList = <News>[ News(
      newsCode: '1',
      reportCode: '1',
      radioCode: '5.20',
      hourDate: 750000,
      unitCode: 'Does1',
      message: 'Desplazamiento',
      updateDate: 750000,
      unitCreate: 'Genesis2') ];

  final tParams = GetParams( reportCode: '1', unitCreate: 'Genesis2', dateCreate: 70000 );

  test('should get news list from repository',
  () async {
    // arrange
    when( mockNewsRepository.getNews(any, any, any) )
    .thenAnswer((_) async => Right( tNewsList ) );
    // act
    final result = await usecase( tParams );
    // assert
    expect( result, equals( Right( tNewsList ) ) );
    verify( mockNewsRepository..getNews( tParams.reportCode, tParams.unitCreate, tParams.dateCreate ) );
    verifyNoMoreInteractions( mockNewsRepository );
  });

}