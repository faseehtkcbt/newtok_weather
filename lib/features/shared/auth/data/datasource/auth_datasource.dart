import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/exception/exceptions.dart';
import '../../../../../core/internet/connection_checker.dart';
import '../../../../../core/model/user_model.dart';

abstract interface class AuthDataSource {
  Future<String> registerUser(
      {required String email,
      required String password,
      required String username,required String role});
  Future<UserModel> loginUser(
      {required String email, required String password});
}

class AuthDatasourceImpl implements AuthDataSource {
  final ConnectionChecker internet;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  AuthDatasourceImpl(this.firebaseAuth, this.firestore, this.internet);
  @override
  Future<UserModel> loginUser(
      {required String email, required String password,}) async {
    try {
      if (!(await internet.isInternetConnected)) {
        throw ServerExceptions(
            'Internet Disconnected!! Please connect the internet.');
      }
      final UserModel user;
      final response = await firebaseAuth.signInWithEmailAndPassword(
        password: password,
        email: email,
      );
      if (response.user?.uid == null) {
        throw ServerExceptions("Invalid User");
      } else {
        final value =
            await firestore.collection('users').doc(response.user?.uid).get();
        user = UserModel(
            photoUrl: value.data()!['photoUrl'],
            name: value.data()!['username'],
            id: value.data()!['uid'],
            email: value.data()!['email'],
            role: value.data()!['role']);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerExceptions(e.code);
    } on FirebaseException catch (e) {
      throw ServerExceptions(e.code);
    } on ServerExceptions catch (e) {
      throw ServerExceptions(e.exception);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<String> registerUser(
      {required String email,
      required String password,
      required String username,
      required String role}) async {
    try {
      if (!(await internet.isInternetConnected)) {
        throw ServerExceptions(
            'Internet Disconnected!! Please connect the internet.');
      }
      String response = "";
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        await firestore.collection('users').doc(user.user?.uid).set({
          'uid': user.user?.uid,
          'email': user.user?.email,
          'username': username,
          'photoUrl': "",
          'role':role
        }).then((value) => response = 'Successfully Registered');
      });
      return response;
    } on FirebaseAuthException catch (e) {
      throw ServerExceptions(e.code);
    } on FirebaseException catch (e) {
      throw ServerExceptions(e.code);
    } on ServerExceptions catch (e) {
      throw ServerExceptions(e.exception);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
