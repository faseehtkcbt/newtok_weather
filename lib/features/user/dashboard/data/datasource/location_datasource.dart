import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtok_weather/features/user/dashboard/data/model/location_model.dart';

import '../../../../../core/exception/exceptions.dart';
import '../../../../../core/internet/connection_checker.dart';

abstract interface class LocationDatasource {
  Future<List<LocationModel>> getLocations();
}

class LocationDatasourceImpl implements LocationDatasource {
  final ConnectionChecker internet;
  final FirebaseFirestore firestore;
  LocationDatasourceImpl({required this.internet, required this.firestore});
  @override
  Future<List<LocationModel>> getLocations() async {
    try {
      if (!(await internet.isInternetConnected)) {
        throw ServerExceptions(
            'Internet Disconnected!! Please connect the internet.');
      }
      final QuerySnapshot response =
          await firestore.collection('location').get();
      List<LocationModel> result = [];
      for (var i in response.docs) {
        result.add(LocationModel.fromJson(i.data() as Map<String, dynamic>));
      }
      return result;
    } on FirebaseException catch (e) {
      throw ServerExceptions(e.code);
    } on ServerExceptions catch (e) {
      throw ServerExceptions(e.exception);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
