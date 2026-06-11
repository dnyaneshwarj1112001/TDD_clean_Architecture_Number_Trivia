import 'package:tdd_clean_archetecture/feature/product_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLoacalDatasource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviatoCache);
  
}
