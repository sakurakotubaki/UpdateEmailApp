# email_update
メールアドレスの変更を行うデモアプリ

## 公式のコード
```dart
await user?.updateEmail("janeq@example.com");
```

## 今回作成したメソッド
currentUserには、?か!とつけないとエラーになる!
```dart
// ユーザーのメールアドレスの変更.
  Future<void> emailUpdate(String emailC) async {
    final ref =
        await _ref.read(firebaseAuthProvider).currentUser?.updateEmail(emailC);
  }
```