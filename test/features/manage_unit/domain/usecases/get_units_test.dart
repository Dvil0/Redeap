import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redeap/features/manage_unit/domain/repositories/unit_repository.dart';
import 'package:redeap/features/manage_unit/domain/usecases/get_units.dart';

class MockUnitRepository extends Mock
  implements UnitRepository {}

void main() {
  MockUnitRepository unitRepository;
  GetUnits usecase;

  setUp((){
    unitRepository = MockUnitRepository();
    usecase = GetUnits( repository: unitRepository );
  });

  test('should',(){

  });
  test('should',(){

  });
  test('should',(){

  });
}