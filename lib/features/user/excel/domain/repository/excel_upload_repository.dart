import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:newtok_weather/core/failure/failures.dart';

abstract interface class ExcelUploadRepository {
  Future<Either<Failures, String>> addExcel({
    required File? file,
  });
}
