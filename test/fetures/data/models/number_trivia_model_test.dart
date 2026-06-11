import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/entities/number_trivia.dart';

import '../../fixtures/fexture_reder.dart';

void main() {
  final tNumberTriviamodel = NumberTriviaModel(number: 5, text: "text");
  // assine the or initialise the actual class what you have to write test

  test('should be a subclass of NumberTrivia Entity ', () async {
    // arrange
    // act

    // assert
    expect(tNumberTriviamodel, isA<NumberTrivia>());
  });

  group("fromjson", () {
    test(
      'should return a valid model when the json number is an intiger',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = jsonDecode(fixture('trivia.json'));
        // read the file and convert it i meen decode it to the Map String dynamic
        // act
        final result = NumberTriviaModel.fromjson(jsonMap);
        // assert
        expect(result, tNumberTriviamodel);
      },
    );

    test(
      'should return a valid model when the json number is an double',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = jsonDecode(
          fixture('trivia_double.json'),
        );
        // read the file and convert it i meen decode it to the Map String dynamic
        // act
        final result = NumberTriviaModel.fromjson(jsonMap);
        // assert
        expect(result, tNumberTriviamodel);
      },
    );
  });

  group('tojson', () {
    test('should return a json map and return propper data', () async {
      // act
      final result = tNumberTriviamodel.tojson();

      // assert
      final expectedMap = {"text": "text", "number": 5};
      expect(result, expectedMap);
    });
  });
}
