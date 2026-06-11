import 'package:equatable/equatable.dart';

abstract class Failuere extends Equatable {
  final List properties = <dynamic>[];
  Failuere([properties]);

  @override
  List<Object?> get props => [properties];
}
class ServerFailuer extends Failuere {}

class CachFailuer extends Failuere {}
