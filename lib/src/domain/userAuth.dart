import 'package:dart_secure/dart_secure.dart';
import 'package:flutter/material.dart';
import 'package:sapura_tm/src/presentation/Modules/Home/HomePage.dart';

import '../presentation/Modules/Authentication/AuthenticationLayout.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return userAuthMonitor(
      authenticatedUserPage: const HomePage(),
      unAuthenticatedUserPage: const SignLayout(),
    );
  }
}
