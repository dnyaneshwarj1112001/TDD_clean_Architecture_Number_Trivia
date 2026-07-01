import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_archetecture/core/error/failuer.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/entities/number_trivia.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/repositories/NumberTriviaRepository.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/repositories/NumberTriviaRepository.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/usecases/GetConcrfeteNumberTrivia.dart';
import 'getConcfrete_Numbertrivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late GetConcritNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcritNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: tNumber, text: "tet1");

  test('should get Number from the repository', () async {
    // arrange

    when(
      mockNumberTriviaRepository.getConcritNumberTrivia(any),
    ).thenAnswer((_) async => Right(tNumberTrivia));

    // act
    final result = await usecase(Params(number: tNumber));

    // assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcritNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
