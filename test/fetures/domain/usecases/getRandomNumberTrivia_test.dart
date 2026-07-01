import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_archetecture/core/error/failuer.dart';
import 'package:tdd_clean_archetecture/core/usecases/usecase.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/repositories/NumberTriviaRepository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/usecases/get_Random_number_Trivia.dart';

import 'getRandomNumberTrivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumberTrivia = NumberTrivia(number: 1, text: "tet1");

  test('should get trivia Number from the repository', () async {
    // arrange

    when(
      mockNumberTriviaRepository.getRandomnumberTrivia(),
    ).thenAnswer((_) async => Right(tNumberTrivia));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getRandomnumberTrivia()).called(1);
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
