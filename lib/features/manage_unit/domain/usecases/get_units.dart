import 'package:dartz/dartz.dart';
import 'package:redeap/core/error/failures.dart';
import 'package:redeap/core/usecase/usecase.dart';
import 'package:redeap/features/manage_unit/domain/entities/unit_user.dart';
import 'package:redeap/features/manage_unit/domain/repositories/unit_repository.dart';

class GetUnits implements UseCase<List<UnitUser>, NoParams> {
  final UnitRepository repository;

  GetUnits({this.repository});

  @override
  Future<Either<Failure, List<UnitUser>>> call(NoParams params) async {
    // TODO: implement call
    throw UnimplementedError();
  }
}