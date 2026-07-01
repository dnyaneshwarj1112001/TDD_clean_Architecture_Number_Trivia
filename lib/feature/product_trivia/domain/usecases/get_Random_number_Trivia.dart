import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean_archetecture/core/error/failuer.dart';
import 'package:tdd_clean_archetecture/core/usecases/usecase.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/repositories/NumberTriviaRepository.dart';

class GetRandomNumberTrivia implements Usecase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;
  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failuere, NumberTrivia>> call(NoParams noparams) async {
    return await repository.getRandomnumberTrivia();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
