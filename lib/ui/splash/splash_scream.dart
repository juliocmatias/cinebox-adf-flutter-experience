import 'package:cinebox/ui/core/themes/resource.dart';
import 'package:cinebox/ui/core/widgets/loader_messages.dart';
import 'package:cinebox/ui/splash/command/check_user_logged_command.dart';
import 'package:cinebox/ui/splash/splash_scream_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScream extends ConsumerStatefulWidget {
  const SplashScream({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreamState();
}

class _SplashScreamState extends ConsumerState<SplashScream>
    with LoaderAndMessage {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashScreamViewModelProvider).checkLoginAndRedirect();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(checkUserLoggedCommandProvider, (_, next) {
      next.whenOrNull(
        data: (data) {
          final path = switch (data) {
            true => '/home',
            false => '/login',
            _ => '',
          };
          if (path.isNotEmpty && context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              path,
              (route) => false,
            );
          }
        },
        error: (_, _) {
          if (context.mounted) {
            showErroSnackBar('Erro ao verificar o Login');
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => true,
            );
          }
        },
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            R.ASSETS_IMAGES_BG_LOGIN_PNG,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            constraints: BoxConstraints.expand(),
            color: Colors.black.withAlpha(140),
          ),
          Center(
            child: Image.asset(R.ASSETS_IMAGES_LOGO_PNG),
          ),
        ],
      ),
    );
  }
}
