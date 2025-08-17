import 'package:cinebox/core/result/result.dart';

abstract interface class LocalStorageService {
  Future<Result<Unit>> saveIdToken(String token);
  Future<Result<Unit>> removeIdToken();
  Future<Result<String>> getIdToken();
}
