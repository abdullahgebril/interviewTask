import 'package:flutter/material.dart';
import 'package:newtask/core/widget/text_field.dart';
import 'package:newtask/domain/login/provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      builder: (context, child) => Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _phoneController,
                hintText: "Phone Number",
                isPassword: false,
                obscureText: false,
                keyboardType: TextInputType.text,
                validate: (phone) {
                  if (phone!.isEmpty) {
                    return "Please enter your phone number";
                  }
                  return null;
                },
                suffixIcon: Icons.call,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: "password",
                isPassword: true,
                obscureText: true,
                validate: (password) {
                  if (password!.isEmpty) {
                    return "Please enter your phone password";
                  }
                  return null;
                },
                suffixIcon: Icons.password_rounded,
              ),
              const SizedBox(height: 8,),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot your password?",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black,fontSize: 14),
                  )),
              const SizedBox(
                height: 15,
              ),
              Consumer<LoginProvider>(
                builder: (context, loginProvider, child) =>
                    loginProvider.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              login(loginProvider);
                            },
                            child: const Text("login")),
              )
            ],
          )),
    );
  }

  void login(LoginProvider loginProvider) {
    if (_formKey.currentState!.validate()) {
      final phone = _phoneController.text.trim();
      final password = _passwordController.text.trim();
      loginProvider.login(context, phoneNumber: phone, password: password);
    }
  }
}
