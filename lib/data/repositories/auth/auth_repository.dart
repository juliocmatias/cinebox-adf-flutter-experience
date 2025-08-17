import 'package:cinebox/core/result/result.dart';

abstract interface class AuthRepository {
  Future<Result<Unit>> signInWithGoogle();
  Future<Result<Unit>> signOutWithGoogle();
  Future<Result<bool>> isLogged();
}
