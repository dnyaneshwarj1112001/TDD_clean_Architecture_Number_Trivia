import 'package:dartz/dartz.dart';
import 'package:tdd_clean_archetecture/core/error/failuer.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/usecases/GetConcrfeteNumberTrivia.dart';

abstract class Numbertriviarepository {
  Future<Either<Failuere, NumberTrivia>> getRandomnumberTrivia();
  Future<Either<Failuere, NumberTrivia>> getConcritNumberTrivia(int? number);
}
