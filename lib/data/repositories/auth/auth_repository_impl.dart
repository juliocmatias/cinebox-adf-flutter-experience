import 'dart:developer';

import 'package:cinebox/core/result/result.dart';
import 'package:cinebox/data/exceptions/data_exception.dart';
import 'package:cinebox/data/services/auth/auth_service.dart';
import 'package:cinebox/data/services/google_signin/google_signin_service.dart';
import 'package:cinebox/data/services/local_storage/local_storage_service.dart';
import 'package:dio/dio.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSigninService _googleSigninService;
  final LocalStorageService _localStorageService;
  final AuthService _authService;

  AuthRepositoryImpl({
    required GoogleSigninService googleSigninService,
    required LocalStorageService localStorageService,
    required AuthService authService,
  }) : _googleSigninService = googleSigninService,
       _localStorageService = localStorageService,
       _authService = authService;

  @override
  Future<Result<bool>> isLogged() async {
    final resultToken = await _localStorageService.getIdToken();
    return switch (resultToken) {
      Success<String>() => Success(true),
      Failure<String>() => Success(false),
    };
  }

  @override
  Future<Result<Unit>> signInWithGoogle() async {
    final result = await _googleSigninService.signIn();
    switch (result) {
      case Success<String>(:final value):
        try {
          await _localStorageService.saveIdToken(value);
          await _authService.auth();
          return successOfUnit();
        } on DioException catch (e, s) {
          log(
            'Erro ao autenticar usuário no backend',
            name: 'AuthRepository',
            stackTrace: s,
            error: e,
          );
          return Failure(
            DataException(message: 'Erro ao realizar login no backend'),
          );
        }
      case Failure<String>(:final error):
        log(
          'Erro ao realizar login com o google',
          name: 'AuthRepository',
          error: error,
        );
        return Failure(DataException(message: 'Erro ao realizar o login'));
    }
  }

  @override
  Future<Result<Unit>> signOutWithGoogle() async {
    final result = await _googleSigninService.signOut();
    switch (result) {
      case Success<Unit>():
        final removeResult = await _localStorageService.removeIdToken();
        switch (removeResult) {
          case Success<Unit>():
            return successOfUnit();
          case Failure<Unit>(:final error):
            log(
              'Erro ao remover o token do LocalStorage',
              name: 'AuthRepository',
              error: error,
            );
            return Failure(error);
        }
      case Failure<Unit>(:final error):
        log(
          'Erro ao realizar login com o google',
          name: 'AuthRepository',
          error: error,
        );
        return Failure(DataException(message: 'Erro ao sair do aplicativo'));
    }
  }
}
