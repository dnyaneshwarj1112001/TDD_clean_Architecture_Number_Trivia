import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_archetecture/core/error/exeptions.dart';
import 'package:tdd_clean_archetecture/core/error/failuer.dart';
import 'package:tdd_clean_archetecture/core/platform/network_info.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/datasources/number_trivia_loacal_dataSource.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/repositories/number_Trivia_repository_impl.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/entities/number_trivia.dart';

import '../../domain/usecases/getConcfrete_Numbertrivia_test.dart';
import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([
  NumberTriviaRemoteDatasource,
  NumberTriviaLoacalDatasource,
  NetworkInfo,
])
void main() {
  // inicialization
  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaRemoteDatasource mockRemoteDataSource;
  late MockNumberTriviaLoacalDatasource mockLocaleDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockNumberTriviaRemoteDatasource();
    mockLocaleDataSource = MockNumberTriviaLoacalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      loacalDatasource: mockLocaleDataSource,
      remotedatasource: mockRemoteDataSource,
      networkinfo: mockNetworkInfo,
    );
  });
  void runoffline(Function body) {
    group("device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  void runonline(Function body) {
    group("device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group("get concrit Number Trivia", () {
    final tNumber = 1;
    final tNumberTriviamodel = NumberTriviaModel(
      number: tNumber,
      text: "test Trivia",
    );
    final NumberTrivia tnumberTrivia = tNumberTriviamodel;
    runonline(() {
      test(
        ' should return remote data when the call to  remote data source successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getConcritNumberTrivia(any),
          ).thenAnswer((_) async => tNumberTriviamodel);
          // act
          final result = await repository.getConcritNumberTrivia(
            tNumber,
          ); // for witch method actually ypu wanted to test
          // assert
          verify(mockRemoteDataSource.getConcritNumberTrivia(tNumber));
          expect(result, equals(right(tnumberTrivia)));
        },
      );

      test(
        ' should cache the data locally  when the call to  remote data source successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getConcritNumberTrivia(any),
          ).thenAnswer((_) async => tNumberTriviamodel);
          // act
          await repository.getConcritNumberTrivia(tNumber);
          // assert
          verify(mockRemoteDataSource.getConcritNumberTrivia(tNumber));
          verify(mockLocaleDataSource.cacheNumberTrivia(tNumberTriviamodel));
        },
      );

      test(
        ' should return server failuer when remote data source is Unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getConcritNumberTrivia(any),
          ).thenThrow(ServerExeption());
          // act
          final result = await repository.getConcritNumberTrivia(tNumber);
          // assert
          verify(mockRemoteDataSource.getConcritNumberTrivia(tNumber));
          verifyZeroInteractions(mockLocaleDataSource);
          expect(result, equals(Left(ServerFailuer())));
        },
      );
    });

    runoffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          when(
            mockLocaleDataSource.getLastNumberTrivia(),
          ).thenAnswer((_) async => tNumberTriviamodel);
          // act
          final result = await repository.getConcritNumberTrivia(tNumber);
          // assert
          expect(result, equals(right(tnumberTrivia)));
          verify(mockLocaleDataSource.getLastNumberTrivia());
          verifyNoMoreInteractions(mockLocaleDataSource);
        },
      );

      test(
        'should return chacheFailuer when theare is no chached data present',
        () async {
          when(
            mockLocaleDataSource.getLastNumberTrivia(),
          ).thenThrow(CachExeption());
          // act
          final result = await repository.getConcritNumberTrivia(tNumber);
          // assert
          expect(result, equals(left(CachFailuer())));
          verify(mockLocaleDataSource.getLastNumberTrivia());
          verifyNoMoreInteractions(mockLocaleDataSource);
        },
      );
    });
  });

  group("get Random Number Trivia", () {
    final tNumberTriviamodel = NumberTriviaModel(
      number: 123,
      text: "test Trivia",
    );
    final NumberTrivia tnumberTrivia = tNumberTriviamodel;
    runonline(() {
      test(
        ' should return remote data when the call to  remote data source successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getRandomnumberTrivia(),
          ).thenAnswer((_) async => tNumberTriviamodel);
          // act
          final result = await repository
              .getRandomnumberTrivia(); // for witch method actually ypu wanted to test
          // assert
          verify(mockRemoteDataSource.getRandomnumberTrivia());
          expect(result, equals(right(tnumberTrivia)));
        },
      );

      test(
        ' should cache the data locally  when the call to  remote data source successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getRandomnumberTrivia(),
          ).thenAnswer((_) async => tNumberTriviamodel);
          // act
          await repository.getRandomnumberTrivia();
          // assert
          verify(mockRemoteDataSource.getRandomnumberTrivia());
          verify(mockLocaleDataSource.cacheNumberTrivia(tNumberTriviamodel));
        },
      );

      test(
        ' should return server failuer when remote data source is Unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getRandomnumberTrivia(),
          ).thenThrow(ServerExeption());
          // act
          final result = await repository.getRandomnumberTrivia();
          // assert
          verify(mockRemoteDataSource.getRandomnumberTrivia());
          verifyZeroInteractions(mockLocaleDataSource);
          expect(result, equals(Left(ServerFailuer())));
        },
      );
    });

    runoffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          when(
            mockLocaleDataSource.getLastNumberTrivia(),
          ).thenAnswer((_) async => tNumberTriviamodel);
          // act
          final result = await repository.getRandomnumberTrivia();
          // assert
          expect(result, equals(right(tnumberTrivia)));
          verify(mockLocaleDataSource.getLastNumberTrivia());
          verifyNoMoreInteractions(mockLocaleDataSource);
        },
      );

      test(
        'should return chacheFailuer when theare is no chached data present',
        () async {
          when(
            mockLocaleDataSource.getLastNumberTrivia(),
          ).thenThrow(CachExeption());
          // act
          final result = await repository.getRandomnumberTrivia();
          // assert
          expect(result, equals(left(CachFailuer())));
          verify(mockLocaleDataSource.getLastNumberTrivia());
          verifyNoMoreInteractions(mockLocaleDataSource);
        },
      );
    });
  });
}
