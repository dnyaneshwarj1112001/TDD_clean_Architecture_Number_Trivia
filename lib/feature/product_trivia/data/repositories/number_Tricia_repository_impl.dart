import 'package:dartz/dartz.dart';
import 'package:tdd_clean_archetecture/core/error/exeptions.dart'; // Make sure to import your Exception classes
import 'package:tdd_clean_archetecture/core/error/failuer.dart';
import 'package:tdd_clean_archetecture/core/platform/network_info.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/datasources/number_trivia_loacal_dataSource.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/repositories/numberTriviarepository.dart';

class NumberTriviaRepositoryImpl implements Numbertriviarepository {
  final NumberTriviaRemoteDatasource remotedatasource;
  final NumberTriviaLoacalDatasource loacalDatasource;
  final NetworkInfo networkinfo;

  NumberTriviaRepositoryImpl({
    required this.remotedatasource,
    required this.loacalDatasource,
    required this.networkinfo,
  });

  @override
  Future<Either<Failuere, NumberTrivia>> getConcritNumberTrivia(
    int? number,
  ) async {
    networkinfo.isConnected;
    try {
      final remoteTrivia = await remotedatasource.getConcritNumberTrivia(
        number,
      );
      loacalDatasource.cacheNumberTrivia(remoteTrivia);

      return right(remoteTrivia);
    } on ServerExeption {
      return Left(ServerFailuer());
    }
  }

  @override
  Future<Either<Failuere, NumberTrivia>> getRandomnumberTrivia() async {
    if (await networkinfo.isConnected) {
      try {
        final remotetrivia = await remotedatasource.getRandomnumberTrivia();
        await loacalDatasource.cacheNumberTrivia(remotetrivia);
        return Right(remotetrivia);
      } on ServerExeption {
        return left(ServerFailuer());
      }
    } else {
      try {
        final localTrivia = await loacalDatasource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CachExeption {
        return Left(CachFailuer());
      }
    }
  }
}
