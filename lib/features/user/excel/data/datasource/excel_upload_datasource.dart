import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';

import '../../../../../core/exception/exceptions.dart';
import '../../../../../core/internet/connection_checker.dart';

abstract interface class ExcelUploadDataSource {
  Future<String> excelUpload({
    required File? file,
  });
}

class ExcelUploadDatasourceImpl implements ExcelUploadDataSource {
  final ConnectionChecker internet;
  final FirebaseFirestore firestore;
  ExcelUploadDatasourceImpl({required this.internet, required this.firestore});
  @override
  Future<String> excelUpload({
    required File? file,
  }) async {
    try {
      if (!(await internet.isInternetConnected)) {
        throw ServerExceptions(
            'Internet Disconnected!! Please connect the internet.');
      }
      if (file == null) {
        throw ServerExceptions('File is missing');
      } else {
        var bytes = file.readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);
        for (var table in excel.tables.keys) {
          var sheet = excel.tables[table];
          if (sheet != null) {
            for (var row in sheet.rows) {
              // Assuming the first row contains headers, you may want to skip it
              if (row == sheet.rows.first) continue;

              // Retrieve data from each cell in the row
              String? country = row[0]?.value.toString();
              String? state = row[1]?.value.toString();
              String? district = row[2]?.value.toString();
              String? city = row[3]?.value.toString();
              await firestore.collection('location').add({
                'country': country,
                'state': state,
                'district': district,
                'city': city,
              });
              // Add to the list of locations
            }
          }
        }
      }
      return 'Successfully Registered';
    } on FirebaseException catch (e) {
      throw ServerExceptions(e.code);
    } on ServerExceptions catch (e) {
      throw ServerExceptions(e.exception);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
