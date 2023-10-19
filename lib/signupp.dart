import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signinfirebase/riverpod/provider.dart';
import 'package:signinfirebase/riverpod/stateprovider.dart';
import 'package:signinfirebase/secreens/home.dart';

class Signuppscreen extends ConsumerStatefulWidget {
  const Signuppscreen({super.key});

  @override
  ConsumerState<Signuppscreen> createState() => _SignuppscreenState();
}

class _SignuppscreenState extends ConsumerState<Signuppscreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final PostState = ref.watch(registerUserNotifierProvider);
    return Scaffold(
      body: Builder(
        builder: (context) {
          if (PostState is SignupPostInitialState) {
            return const RegisterUserPage();
          } else if (PostState is SignupPostLoadingState) {
            return const LoadingStateWidget();
          } else if (PostState is SignupPostLoadedState) {
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
    TextEditingController nameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    // ignore: no_leading_underscores_for_local_identifiers
    void _submit() {
      final isValid = formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formKey.currentState?.save();
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  color: Colors.amber,
                )),
            Expanded(
              child: Container(
                height: 200,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 00,
              top: 70,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: const LinearGradient(
                        colors: [Colors.indigo, Colors.blueAccent]),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          offset: Offset(2.0, 2.0))
                    ]),
              ),
            ),
            Form(
              key: formKey,
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Signupp',
                      style: TextStyle(color: Colors.black26, fontSize: 40),
                    ),
                    Container(
                      height: 50,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        fillColor: Colors.greenAccent,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                      controller: lastnameController,
                      decoration: InputDecoration(
                        labelText: "Last Name",
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
                              passwordController.value.text.isEmpty ||
                              nameController.value.text.isEmpty ||
                              lastnameController.value.text.isEmpty)) {
                            String name = nameController.value.text;
                            String lastName = lastnameController.value.text;
                            String emailAddress =
                                emailController.value.text.trim();
                            String confirmPassword =
                                passwordController.value.text.trim();
                            ref
                                .read(registerUserNotifierProvider.notifier)
                                .registerUser(emailAddress, confirmPassword,
                                    name, lastName);
                            // .read(provider.notifier)
                            // .registerUser(
                            //     emailAddress, confirmPassword, name, lastName);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // ignore: prefer_const_constructors
                                  builder: (context) => HomeScreen(),
                                ));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Creat Account")));
                          }
                        },
                        child: const Text('Signupp')),
                  ],
                ),
              ),
            ),
          ],
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
