import 'package:flutter/material.dart';
import 'package:test_task/models/user/user_model.dart';
import 'package:test_task/widgets/textfield/textfield_widget.dart';

class ForgotPasswordScreenArguments {
  final String? email;

  ForgotPasswordScreenArguments(this.email);
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static const routeName = '/forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController textControllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Get the email passed from the previous screen:
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments
          as ForgotPasswordScreenArguments?;
      if (args?.email != null) {
        textControllerEmail.text = args?.email ?? "";
      }
    });
  }

  Future<void> onResetPressed() async {
    // Make sure user has entered a valid email address first:
    String email = textControllerEmail.text;
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.isEmpty || !emailValid) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter a valid email address"),
      ));
      return;
    }

    // Try and recover a password:
    try {
      bool isSuccess = await User.resetPassword(email);
      if (isSuccess) {
        displayMessage("Password reset instructions sent to $email");
      } else {
        displayMessage('Something went wrong');
      }
    } catch (e) {
      displayMessage(e.toString());
    }
  }

  void displayMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                child: Column(
                  children: [
                    Text("Forgot Password",
                        style: Theme.of(context).textTheme.titleLarge),
                    TextFieldWidget(
                      label: "Email",
                      controller: textControllerEmail,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    ElevatedButton(
                      onPressed: onResetPressed,
                      child: const Text("Reset Password"),
                    )
                  ],
                ))));
  }
}
