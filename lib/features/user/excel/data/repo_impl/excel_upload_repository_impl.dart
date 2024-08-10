import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:newtok_weather/core/exception/exceptions.dart';
import 'package:newtok_weather/core/failure/failures.dart';

import '../../domain/repository/excel_upload_repository.dart';
import '../datasource/excel_upload_datasource.dart';

class ExcelUploadRepoImpl implements ExcelUploadRepository {
  final ExcelUploadDataSource dataSource;
  ExcelUploadRepoImpl({required this.dataSource});
  @override
  Future<Either<Failures, String>> addExcel({required File? file}) async {
    try {
      final result = await dataSource.excelUpload(file: file);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(Failures(message: e.exception));
    } catch (e) {
      return Left(Failures(message: e.toString()));
    }
  }
}
