import 'dart:convert';

import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_archetecture/core/error/exeptions.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/datasources/number_trivia_loacal_dataSource.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/models/number_trivia_model.dart';

import '../../fixtures/fexture_reder.dart';
import 'number_trivia_loacal_dataSource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late NumberTriviaLoacalDatasourceImpl datasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = NumberTriviaLoacalDatasourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group("getLastNumberTrivia", () {
    final tNumberTriviamodel = NumberTriviaModel.fromjson(
      json.decode(fixture('trivia_chache.json')),
    );
    test(
      'should return a NumberTrivia from sharedPrefrences when thear is one in cache',
      () async {
        // arrange
        when(
          mockSharedPreferences.getString(any),
        ).thenReturn(fixture('trivia_chache.json'));
        // act
        final result = await datasource.getLastNumberTrivia();
        // assert
        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(tNumberTriviamodel));
      },
    );

    test('should throw a CachExeption when there is no cached value', () async {
      // 1. arrange
      when(
        mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA),
      ).thenThrow(CachExeption());

      // 2. act & assert
      await expectLater(
        () => datasource.getLastNumberTrivia(),
        throwsA(isA<CachExeption>()),
      );
    });
  });

  group("cacheNumberTrivia", () {
    test('should call shared prefreences to cache the data ', () async {
      final tNumbertriviamodel = NumberTriviaModel(
        number: 1,
        text: 'test trivia',
      );
      final expectedjsonString = json.encode(tNumbertriviamodel.tojson());
      // act
      datasource.cacheNumberTrivia(tNumbertriviamodel);
      // assert
      verify(
        mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA, 
          expectedjsonString,
        ),
      );
    });
  });
}
