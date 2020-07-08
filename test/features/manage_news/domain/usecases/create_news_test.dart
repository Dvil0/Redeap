import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redeap/features/manage_news/domain/repositories/news_repository.dart';
import 'package:redeap/features/manage_news/domain/usecases/create_news.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  CreateNews usecase;
  MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    usecase = CreateNews(mockNewsRepository);
  });

  CreateParams tParams = CreateParams(
      newsCode: '1',
      reportCode: '1',
      radioCode: '5.20',
      hourDate: 750000,
      unitCode: 'Does1',
      message: 'Desplazamiento',
      updateDate: 750000,
      unitCreate: 'Genesis2');

  test('should connect data from repository', () {
    // arrange
    when(mockNewsRepository.createNews(any, any, any, any, any, any, any, any))
        .thenAnswer((_) async => Right(null));
    // act
    usecase(tParams);
    // assert
    verify( mockNewsRepository.createNews(any, any, any, any, any, any, any, any) );
  });

  test('should return null with news is created',() async {
    // arrange
    when(mockNewsRepository.createNews(any, any, any, any, any, any, any, any))
        .thenAnswer((_) async => Right(null));
    // act
    final result = await usecase( tParams );
    // assert
    expect( result, equals( Right(null) ) );
    verify(mockNewsRepository.createNews( tParams.newsCode, tParams.reportCode, tParams.radioCode, tParams.hourDate, tParams.unitCode, tParams.message, tParams.updateDate, tParams.unitCreate) );
    verifyNoMoreInteractions(mockNewsRepository);
  });
}
