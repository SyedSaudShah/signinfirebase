import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:signinfirebase/riverpod/loginstate.dart';
import 'package:signinfirebase/riverpod/logprovider.dart';

import 'package:signinfirebase/riverpod/stateprovider.dart';

class LogInScreen extends ConsumerWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: non_constant_identifier_names
    final PostState = ref.watch(loginprovider.notifier);
    return Scaffold(
      body: Builder(
        builder: (context) {
          if (PostState is LoginpPostInitialState) {
            return const RegisterUserPage();
          } else if (PostState is LoginpPostLoadingState) {
            return const LoadingStateWidget();
          } else if (PostState is LoginpPostLoadedState) {
            return const Text("Loaded State");
          } else {
            return ErrorStateWidget(
                errorMessage: (PostState as SignupPostErrorState).message);
          }
        },
      ),
    );
  }
}

class LoadingStateWidget extends ConsumerWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.amber,
      ),
    );
  }
}

class RegisterUserPage extends ConsumerWidget {
  const RegisterUserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    void _submit() {
      final isValid = formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formKey.currentState?.save();
    }

    return SafeArea(
      child: Form(
        key: formKey,
        child: Center(
          child: Column(
            children: [
              const Text(
                'LogIn',
                style: TextStyle(color: Colors.black26, fontSize: 40),
              ),
              Container(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 22,
                ),
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Enter Email",
                  fillColor: Colors.greenAccent,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
              Container(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a valid password!';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(
                  fontSize: 22,
                ),
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  fillColor: Colors.greenAccent,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    _submit();
                    if (!(emailController.value.text.isEmpty ||
                        passwordController.value.text.isEmpty)) {
                      String emailAddress = emailController.value.text.trim();
                      String confirmPassword =
                          passwordController.value.text.trim();
                      ref
                          .read(loginprovider.notifier)
                          .signin(emailAddress, confirmPassword);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Login")));
                    }
                  },
                  child: const Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorStateWidget extends ConsumerWidget {
  const ErrorStateWidget({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        color: Colors.red,
        child: Text(errorMessage),
      ),
    );
  }
}
