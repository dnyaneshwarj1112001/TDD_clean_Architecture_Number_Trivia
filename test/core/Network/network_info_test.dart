import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tdd_clean_archetecture/core/Network/network_info.dart';

import '../../fetures/data/repositories/number_trivia_repository_impl_test.mocks.dart';
import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late MockInternetConnectionChecker mockDataConnectionchecker;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockDataConnectionchecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionchecker);
  });

  group("isConnected", () {
    test(
      'should forward the call to Data Connection checker.hasConnection',
      () async {
        // arrange
        when(
          mockDataConnectionchecker.hasConnection,
        ).thenAnswer((_) async => true);
        // act
        final result = await networkInfo.isConnected;
        // assert
        verify(mockDataConnectionchecker.hasConnection);
        expect(result, true);
      },
    );
  });
}
