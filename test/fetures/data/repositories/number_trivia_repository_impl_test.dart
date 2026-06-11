import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_archetecture/core/platform/network_info.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/datasources/number_trivia_loacal_dataSource.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:tdd_clean_archetecture/feature/product_trivia/data/repositories/number_Tricia_repository_impl.dart';

import '../../domain/usecases/getConcfrete_Numbertrivia_test.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDatasource {}

class MockLocaleDataSource extends Mock
    implements NumberTriviaLoacalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  // object creation and dependancy injection
  NumberTriviaRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocaleDataSource mockLocaleDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocaleDataSource = MockLocaleDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
     loacalDatasource: mockLocaleDataSource,
     remotedatasource: mockRemoteDataSource,
     networkinfo: mockNetworkInfo,
    );
  });
}
