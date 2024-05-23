import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../exceptions/api_exception.dart';
import '../../../models/auth/api/login_request_model.dart';
import '../../../models/result.dart';
import '../../../utils/app_logger.dart';

final class AuthClient {
  const AuthClient();

  Future<Result<Nothing, ApiException>> login(LoginRequestModel requestModel) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: requestModel.username, password: requestModel.password);
      AppLogger.debug(userCredential.user?.email);
      return Success.nothing();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          AppLogger.debug('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          AppLogger.debug('Wrong password provided for that user.');
        }
      }
      return Failure(ApiException.from(e.message));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<Nothing, ApiException>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return Success.nothing();
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }
}
