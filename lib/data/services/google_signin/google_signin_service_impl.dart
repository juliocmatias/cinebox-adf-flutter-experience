import 'dart:developer';

import 'package:cinebox/core/result/result.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './google_signin_service.dart';

class GoogleSigninServiceImpl implements GoogleSigninService {
  @override
  Future<Result<String>> isSign() async {
    try {
      final logged = await GoogleSignIn.instance
          .attemptLightweightAuthentication();

      if (logged case GoogleSignInAccount(
        authentication: GoogleSignInAuthentication(:final idToken?),
      )) {
        return Success(idToken);
      }
      return Failure(Exception('User is not signed in google'));
    } on Exception catch (e, s) {
      log(
        'User is not signed in google',
        name: 'GoogleSignInService',
        error: e,
        stackTrace: s,
      );
      return Failure(Exception('User is not signed in google'));
    }
  }

  @override
  Future<Result<String>> signIn() async {
    try {
      final auth = await GoogleSignIn.instance.authenticate(
        scopeHint: ['email', 'profile', 'openid'],
      );

      if (auth.authentication case GoogleSignInAuthentication(
        idToken: final idToken?,
      )) {
        return Success(idToken);
      }
      return Failure(
        Exception('Failed to active ID Token from Google Sign-In'),
      );
    } on Exception catch (e, s) {
      log(
        'Failed to active ID Token from Google Sign-In',
        name: 'GoogleSignInService',
        error: e,
        stackTrace: s,
      );
      return Failure(
        Exception('Failed to active ID Token from Google Sign-In'),
      );
    }
  }

  @override
  Future<Result<Unit>> signOut() async {
    try {
      await GoogleSignIn.instance.signOut();
      return successOfUnit();
    } on Exception catch (e, s) {
      log(
        'Failed Sign-Out from Google',
        name: 'GoogleSignInService',
        error: e,
        stackTrace: s,
      );
      return Failure(Exception('Failed Sign-Out from Google'));
    }
  }
}
