import 'package:email_update/utils/auth_provider.dart';
import 'package:email_update/utils/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailRest extends ConsumerWidget {
  const EmailRest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailC = ref.watch(emailProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                ref.read(authStateProvider.notifier).userSignOut(context);
              },
              icon: Icon(Icons.logout))
        ],
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
              ElevatedButton(
                  child: const Text('メールアドレスを変更する'),
                  onPressed: () async {
                    ref
                        .read(authStateProvider.notifier)
                        .emailUpdate(emailC.text);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
