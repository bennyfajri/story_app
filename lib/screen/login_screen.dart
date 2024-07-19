import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/models/login/login_request.dart';
import 'package:story_app/util/constant.dart';

import '../my_app.dart';
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

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordHide = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print("activity resumed");
        break;
      case AppLifecycleState.inactive:
        print("activity inactive");
        break;
      case AppLifecycleState.paused:
        print("activity paused");
        break;
      case AppLifecycleState.detached:
        print("activity detached");
        break;
      case AppLifecycleState.hidden:
        print("activity hidden");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = context.watch<AuthProvider>().loginState;

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
                    hintText: appLocale.password_hint,
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
                loginState.map(initial: (value) {
                  return buildLoginButton(context);
                }, loading: (value) {
                  return const Center(child: CircularProgressIndicator());
                }, loaded: (value) {
                  return buildLoginButton(context);
                }, error: (value) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showSnackbar(
                      context: context,
                      message: value.message,
                    );
                  });
                  return buildLoginButton(context, message: value.message);
                }),
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

  ElevatedButton buildLoginButton(BuildContext context, {String? message}) {
    return ElevatedButton(
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
          }
        }
      },
      child: Text(appLocale.login),
    );
  }
}
