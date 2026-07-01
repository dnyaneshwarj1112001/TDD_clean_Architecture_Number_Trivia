import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean_archetecture/core/error/failuer.dart';
import 'package:tdd_clean_archetecture/core/usecases/usecase.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/repositories/NumberTriviaRepository.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/entities/number_trivia.dart';

class GetConcritNumberTrivia implements Usecase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;
  GetConcritNumberTrivia(this.repository);

  @override
  Future<Either<Failuere, NumberTrivia>> call(Params params) async {
    return await repository.getConcritNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({required this.number});

  @override
  List<Object?> get props => [number];
}
