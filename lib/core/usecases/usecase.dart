import 'package:dartz/dartz.dart';
import 'package:tdd_clean_archetecture/core/error/failuer.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failuere, Type>> call(Params params);
}