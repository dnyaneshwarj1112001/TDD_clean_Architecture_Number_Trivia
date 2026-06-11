import 'package:flutter/foundation.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required int number, required String text})
    : super(number: number, text: text);

  factory NumberTriviaModel.fromjson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      number: (json['number'] as num).toInt(),
      text: json['text'],
    );
  }
Map<String, dynamic> tojson(){
  return {
    'text':text,
    'number':number
  };
}

}
