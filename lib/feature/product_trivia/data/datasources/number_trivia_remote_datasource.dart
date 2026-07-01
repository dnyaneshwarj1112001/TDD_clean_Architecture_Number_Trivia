import 'dart:convert';

import 'package:tdd_clean_archetecture/core/error/exeptions.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDatasource {
  Future<NumberTriviaModel> getRandomnumberTrivia();
  Future<NumberTriviaModel> getConcritNumberTrivia(int? number);
}

class NumberTriviaRemoteDatasourceImpl implements NumberTriviaRemoteDatasource {
  final http.Client client;
  NumberTriviaRemoteDatasourceImpl({required this.client});
  @override
  Future<NumberTriviaModel> getConcritNumberTrivia(int? number) =>
      _getTrivia('http://www.number-trivia.com/$number');

  @override
  Future<NumberTriviaModel> getRandomnumberTrivia() =>
      _getTrivia('http://www.number-trivia.com/random/trivia');

  Future<NumberTriviaModel> _getTrivia(String url) async {
    final response = await client.get(
      Uri.parse(url),

      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromjson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
