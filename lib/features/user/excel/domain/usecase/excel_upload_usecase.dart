import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import 'package:newtok_weather/core/usecase/usecase.dart';

import '../repository/excel_upload_repository.dart';

class ExcelUploadUsecase implements Usecase<String, ExcelUploadParams> {
  final ExcelUploadRepository repo;
  ExcelUploadUsecase({required this.repo});
  @override
  Future<Either<Failures, String>> call(ExcelUploadParams params) async {
    return await repo.addExcel(file: params.file);
  }
}

class ExcelUploadParams {
  final File? file;
  ExcelUploadParams({required this.file});
}
