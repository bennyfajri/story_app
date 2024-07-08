import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/models/register/register_request.dart';

import '../my_app.dart';
import '../provider/auth_provider.dart';
import '../util/constant.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const RegisterScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordHide = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = context.watch<AuthProvider>().registerState;

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
                Text(appLocale.register,
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return appLocale.name_error_msg;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: appLocale.name_hint,
                  ),
                ),
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
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
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
                registerState.map(
                    initial: (value) {
                      return buildRegisterButton(context);
                    },
                    loading: (value) {
                      return const Center(child: CircularProgressIndicator());
                    },
                    loaded: (value) {
                      return buildRegisterButton(context);
                    },
                    error: (value) {
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        showSnackbar(
                          context: context,
                          message: value.message,
                        );
                      });
                      return buildRegisterButton(context);
                    }),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => widget.onLogin(),
                  child: Text(appLocale.login),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        hideKeyboard();
        if (formKey.currentState!.validate()) {
          final registerRequest = RegisterRequest(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          );
          final authRead = context.read<AuthProvider>();
          final result = await authRead.register(registerRequest);
          if (result) {
            widget.onRegister();
          }
        }
      },
      child: Text(appLocale.register),
    );
  }
}
