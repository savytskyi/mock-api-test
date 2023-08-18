import 'package:flutter/material.dart';
import 'package:test_task/screens/forgot_password/forgot_password_screen.dart';
import 'package:test_task/widgets/textfield/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textControllerEmail = TextEditingController();
  TextEditingController textControllerPassword = TextEditingController();

  void onLoginPressed() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Not implemented"),
    ));
  }

  void onResetPressed() {
    Navigator.pushNamed(context, ForgotPasswordScreen.routeName,
        arguments: ForgotPasswordScreenArguments(textControllerEmail.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login", style: Theme.of(context).textTheme.titleLarge),

                  TextFieldWidget(
                    label: "Email",
                    controller: textControllerEmail,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFieldWidget(
                    label: "Password",
                    controller: textControllerPassword,
                    obscureText: true,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    onPressed: onLoginPressed,
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    onPressed: onResetPressed,
                    child: const Text("Reset Password"),
                  )
                ],
              )
            )
      )
    );
  }
}
