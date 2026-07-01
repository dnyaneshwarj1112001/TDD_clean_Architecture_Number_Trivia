import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_archetecture/core/error/exeptions.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLoacalDatasource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviatoCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLoacalDatasourceImpl implements NumberTriviaLoacalDatasource {
  final SharedPreferences sharedPreferences;
  NumberTriviaLoacalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromjson(jsonDecode(jsonString!)));
    } else {
      throw CachExeption();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviatoCache) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      jsonEncode(triviatoCache.tojson()),
    );
  }
}
