import 'package:dartz/dartz.dart';
import 'package:tdd_clean_archetecture/core/error/exeptions.dart'; // Make sure to import your Exception classes
import 'package:tdd_clean_archetecture/core/error/failuer.dart';
import 'package:tdd_clean_archetecture/core/Network/network_info.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/datasources/number_trivia_loacal_dataSource.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/domain/repositories/NumberTriviaRepository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
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
    return await _getTrivia(() {
      return remotedatasource.getConcritNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failuere, NumberTrivia>> getRandomnumberTrivia() async {
    return await _getTrivia(() {
      return remotedatasource.getRandomnumberTrivia();
    });
  }

  Future<Either<Failuere, NumberTrivia>> _getTrivia(
    Future<NumberTrivia> Function() getconcreteorrandom,
  ) async {
    if (await networkinfo.isConnected) {
      try {
        final remoteTrivia = await getconcreteorrandom();
        loacalDatasource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);

        return right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailuer());
      }
    } else {
      try {
        final localtrivia = await loacalDatasource.getLastNumberTrivia();
        return right(localtrivia);
      } on CachExeption {
        return Left(CachFailuer());
      }
    }
  }
}
