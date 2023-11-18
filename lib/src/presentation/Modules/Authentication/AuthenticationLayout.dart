import 'package:flutter/material.dart';
import 'package:sapura_tm/src/config/utils/styles/app_colors.dart';

import '../../Shared/Components.dart';
import 'Login/LoginPage.dart';

class SignLayout extends StatefulWidget {
  const SignLayout({super.key});

  @override
  State<SignLayout> createState() => _SignLayoutState();
}

class _SignLayoutState extends State<SignLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(color: AppColors.primaryLight),
            child: Column(
              children: [
                logoContainer(context),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                    child: const Login(),
                  ),
                ),
              ],
            )));
  }
}
