import 'package:cinebox/ui/auth/commands/login_with_google_command.dart';
import 'package:cinebox/ui/auth/login_view_model.dart';
import 'package:cinebox/ui/auth/widgets/sign_in_google_button.dart';
import 'package:cinebox/ui/core/themes/resource.dart';
import 'package:cinebox/ui/core/widgets/loader_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScream extends ConsumerStatefulWidget {
  const LoginScream({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreamState();
}

class _LoginScreamState extends ConsumerState<LoginScream>
    with LoaderAndMessage {
  @override
  Widget build(BuildContext context) {
    ref.listen(loginWithGoogleCommandProvider, (_, state) {
      state.whenOrNull(
        data: (_) {
          Navigator.pushReplacementNamed(context, '/home');
        },
        error: (_, _) {
          showErroSnackBar('Erro ao efetuar login');
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
          Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.only(top: 108),
            child: Column(
              spacing: 48,
              children: [
                Image.asset(R.ASSETS_IMAGES_LOGO_PNG),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch(loginWithGoogleCommandProvider);
                      return SignInGoogleButton(
                        isLoading: state.isLoading,
                        onPressed: () {
                          final viewModel = ref.read(loginViewModelProvider);
                          viewModel.googleLogin();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
