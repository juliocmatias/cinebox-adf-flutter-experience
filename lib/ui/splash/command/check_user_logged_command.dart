import 'package:cinebox/core/result/result.dart';
import 'package:cinebox/data/repositories/repositories_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_user_logged_command.g.dart';

@riverpod
class CheckUserLoggedCommand extends _$CheckUserLoggedCommand {
  @override
  Future<bool?> build() async => null;

  void execute() async {
    state = AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    final isLoggedUser = await authRepository.isLogged();

    state = switch (isLoggedUser) {
      Success(:final value) => AsyncData(value),
      Failure(:final error) => AsyncError(error, StackTrace.current),
    };
  }
}
