import 'package:dartz/dartz.dart';
import 'package:redeap/core/error/failures.dart';
import 'package:redeap/features/manage_unit/domain/entities/unit_user.dart';

abstract class UnitRepository {
  Future<Either<Failure, List<UnitUser>>> getUnits();
}