import 'package:tdd_clean_archetecture/feature/product_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDatasource {

   Future<NumberTriviaModel> getRandomnumberTrivia();
  Future<NumberTriviaModel> getConcritNumberTrivia(int? number);
}