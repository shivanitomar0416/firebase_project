import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [     
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'email',
                  helperText: 'enter gmail e.g abc@gmail.com',
                  prefixIcon: Icon(Icons.alternate_email)),
            ),
            SizedBox(height: 20,),
                ],
              )
            ),
            RoundButton(
              title: 'login',
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
