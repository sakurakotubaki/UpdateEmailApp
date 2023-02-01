import 'package:email_update/utils/auth_provider.dart';
import 'package:email_update/utils/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailC = ref.watch(emailProvider);
    final passwordC = ref.watch(passwordProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // メールアドレス入力用テキストフィールド
              TextFormField(
                controller: emailC,
                decoration: const InputDecoration(labelText: 'メールアドレス'),
              ),
              // パスワード入力用テキストフィールド
              TextFormField(
                controller: passwordC,
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
              ),
              // ユーザ登録ボタン
              ElevatedButton(
                  child: const Text('ユーザ登録'),
                  onPressed: () async {
                    ref
                        .read(authStateProvider.notifier)
                        .userSignUp(emailC.text, passwordC.text, context);
                  }),
              // ログインボタン
              ElevatedButton(
                child: const Text('ログイン'),
                onPressed: () async {
                  ref
                      .read(authStateProvider.notifier)
                      .userSignIn(emailC.text, passwordC.text, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
