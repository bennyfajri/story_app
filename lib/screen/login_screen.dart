import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/models/login/login_request.dart';
import 'package:story_app/main.dart';
import 'package:story_app/util/constant.dart';

import '../provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  final Function() onLogin;
  final Function() onRegister;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordHide = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  appLocale.login,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return appLocale.email_error_msg;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: appLocale.email_hint,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  obscureText: isPasswordHide,
                  decoration: InputDecoration(
                    hintText:appLocale.password_hint,
                    suffixIcon: IconButton(
                      icon: isPasswordHide
                          ? const Icon(CupertinoIcons.eye_fill)
                          : const Icon(CupertinoIcons.eye_slash_fill),
                      onPressed: () {
                        setState(() {
                          isPasswordHide = !isPasswordHide;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return appLocale.password_error_msg;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                if (context.watch<AuthProvider>().isLoadingLogin)
                  const Center(child: CircularProgressIndicator())
                else
                  ElevatedButton(
                    onPressed: () async {
                      hideKeyboard();
                      if (formKey.currentState!.validate()) {
                        final loginRequest = LoginRequest(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        final authRead = context.read<AuthProvider>();
                        final result = await authRead.login(loginRequest);
                        if (result) {
                          widget.onLogin();
                        } else {
                          if (context.mounted) {
                            showSnackbar(
                              context: context,
                              message: authRead.errorMessage,
                            );
                          }
                        }
                      }
                    },
                    child: Text(appLocale.login),
                  ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => widget.onRegister(),
                  child: Text(appLocale.register),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
