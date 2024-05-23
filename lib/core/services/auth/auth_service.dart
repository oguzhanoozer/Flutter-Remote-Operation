import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../exceptions/api_exception.dart';
import '../../models/auth/api/login_request_model.dart';
import '../../models/result.dart';
import '../api/clients/auth_client.dart';
import '../base_service.dart';

final class AuthService extends BaseService<AuthService> {
  const AuthService();

  Future<bool> isAuthenticated() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }
    return false;
  }

  Future<Result<Nothing, ApiException>> login({
    required String username,
    required String password,
    bool basic = true,
  }) async {
    final LoginRequestModel requestModel = LoginRequestModel(
      username: username,
      password: password,
    );
    return const AuthClient().login(requestModel).then(
      (Result<Nothing, ApiException> response) async {
        return await response.on(
          success: (Nothing data) async {
            return Success.nothing();
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<Nothing, ApiException>> logout() async {
    return await const AuthClient().logout().then(
      (Result<Nothing, ApiException> result) async {
        return await result.on(
          success: (_) async {
            return Success.nothing();
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }
}
