import 'package:cinebox/ui/splash/command/check_user_logged_command.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_scream_view_model.g.dart';

class SplashScreamViewModel {
  final CheckUserLoggedCommand _checkUserLoggedCommand;

  SplashScreamViewModel({
    required CheckUserLoggedCommand checkUserLoggedCommand,
  }) : _checkUserLoggedCommand = checkUserLoggedCommand;

  void checkLoginAndRedirect() => _checkUserLoggedCommand.execute();
}

@riverpod
SplashScreamViewModel splashScreamViewModel(Ref ref) {
  return SplashScreamViewModel(
    checkUserLoggedCommand: ref.read(
      checkUserLoggedCommandProvider.notifier,
    ),
  );
}
