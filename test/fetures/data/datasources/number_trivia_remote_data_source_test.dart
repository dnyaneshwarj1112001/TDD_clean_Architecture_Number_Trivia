import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_clean_archetecture/core/error/exeptions.dart';

import 'package:tdd_clean_archetecture/feature/product_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/models/number_trivia_model.dart';

import '../../fixtures/fexture_reder.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late NumberTriviaRemoteDatasourceImpl datasource;
  setUp(() {
    mockClient = MockClient();
    datasource = NumberTriviaRemoteDatasourceImpl(client: mockClient);
  });

  void setUpMockHttpClintSucess200() {
    when(
      mockClient.get(any, headers: anyNamed('headers')),
    ).thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  group("getConcreteNumbertrivia", () {
    final int tNumber = 1;
    final tNumbertriviamodel = NumberTriviaModel.fromjson(
      json.decode(fixture('trivia.json')),
    );
    test(
      'Should perform a Get Request on URL with number being the end point and application/json header',
      () async {
        // arrange
        setUpMockHttpClintSucess200(); // act
        datasource.getConcritNumberTrivia(tNumber);
        // assert

        verify(
          mockClient.get(
            Uri.parse('http://www.number-trivia.com/$tNumber'),
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'Should return NumberTrivia when the responce code is 200 (Sucess)',
      () async {
        // arrange
        setUpMockHttpClintSucess200();
        // act
        final result = await datasource.getConcritNumberTrivia(1);
        // assert
        expect(result, tNumbertriviamodel);
      },
    );

    test(
      'should throw a serverEcxeption when the responce code is 404 or ther',
      () async {
        // arrange
        when(
          mockClient.get(any, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response('SomeThing is Wroung', 404));
        // act
        final call = datasource.getConcritNumberTrivia;
        // assert
        expect(() => call(tNumber), throwsA(isA<ServerException>()));
      },
    );
  });

  group("getRandomNumberTrivia", () {
    final tNumbertriviamodel = NumberTriviaModel.fromjson(
      json.decode(fixture('trivia.json')),
    );
    test(
      'Should perform a Get Request on URL with number being the end point and application/json header',
      () async {
        // arrange
        setUpMockHttpClintSucess200(); // act
        datasource.getRandomnumberTrivia;
        // assert

        verifyNever(
          mockClient.get(
            Uri.parse('http://www.number-trivia.com/random/trivia'),
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'Should return NumberTrivia when the responce code is 200 (Sucess)',
      () async {
        // arrange
        setUpMockHttpClintSucess200();
        // act
        final result = await datasource.getRandomnumberTrivia();
        // assert
        expect(result, tNumbertriviamodel);
      },
    );

    test(
      'should throw a serverEcxeption when the responce code is 404 or ther',
      () async {
        // arrange
        when(
          mockClient.get(any, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response('SomeThing is Wroung', 404));
        // act
        final call = datasource.getRandomnumberTrivia();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
