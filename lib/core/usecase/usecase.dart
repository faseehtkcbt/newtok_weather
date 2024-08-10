import 'package:fpdart/fpdart.dart';

import '../failure/failures.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failures, SuccessType>> call(Params params);
}

class NoParam {}
