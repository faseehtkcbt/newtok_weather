import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtok_weather/core/model/user_model.dart';
import '../../../../../../core/exception/exceptions.dart';
import '../../../../../../core/internet/connection_checker.dart';

abstract interface class UserListDatasource {
  Future<List<UserModel>> getUsers();
}

class UserListDatasourceImpl implements UserListDatasource {
  final ConnectionChecker internet;
  final FirebaseFirestore firestore;
  UserListDatasourceImpl({required this.internet, required this.firestore});
  @override
  Future<List<UserModel>> getUsers() async {
    try {
      if (!(await internet.isInternetConnected)) {
        throw ServerExceptions(
            'Internet Disconnected!! Please connect the internet.');
      }
      final QuerySnapshot response =
      await firestore.collection('users').where('role',isEqualTo: 'User').get();
      List<UserModel> result = [];
      for (var i in response.docs) {
        result.add(UserModel.fromJson(i.data() as Map<String, dynamic>));
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
