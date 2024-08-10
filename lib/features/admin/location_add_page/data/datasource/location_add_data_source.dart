import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/exception/exceptions.dart';
import '../../../../../core/internet/connection_checker.dart';

abstract interface class LocationAddDataSource {
  Future<String> addLocation({
    required String country,
    required String state,
    required String district,
    required String city,
  });
}

class LocationAddDatasourceImpl implements LocationAddDataSource {
  final ConnectionChecker internet;
  final FirebaseFirestore firestore;
  LocationAddDatasourceImpl({required this.internet, required this.firestore});
  @override
  Future<String> addLocation(
      {required String country,
      required String state,
      required String district,
      required String city}) async {
    // TODO: implement addLocation
    try {
      if (!(await internet.isInternetConnected)) {
        throw ServerExceptions(
            'Internet Disconnected!! Please connect the internet.');
      }
      String response = "";
      await firestore.collection('location').add({
        'country': country,
        'state': state,
        'district': district,
        'city': city,
      }).then((value) => response = 'Successfully Registered');
      return response;
    } on FirebaseException catch (e) {
      throw ServerExceptions(e.code);
    } on ServerExceptions catch (e) {
      throw ServerExceptions(e.exception);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
