import 'package:flutter/material.dart';
import 'package:newtask/core/extension/media_values.dart';
import 'package:newtask/domain/login/view/widget/login_app_bar.dart';
import 'package:newtask/domain/login/view/widget/login_form.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: const LoginAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: context.height * 0.1,
                ),
                Image.asset(
                  'assets/images/frame.png',
                  width: context.width * 0.8,
                  height: context.height * 0.15,
                ),
                SizedBox(
                  height: context.height * 0.1,
                ),
               const LoginForm()
            ]),
          ),
        ),
      
    );
  }


}
