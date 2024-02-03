import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/services/auth/auth_service.dart';
import 'package:notes/services/auth_exceptions.dart';
import 'package:notes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter Your mail...'
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter Your pasword..'
                ),
              ),
              TextButton(onPressed: () async{
                final email = _email.text;
                final password = _password.text;
                try{
                  await  AuthService.firebase().logIn(email: email, password: password);
                    // print(userCredential);
                  if(!context.mounted) return;
                  final user = AuthService.firebase().currentUser;
                  if(user?.isEmailVerified ??false){
                    Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                    );
                  }else{
                    Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                    );
                  }
                  
                }on UserNotFoundAuthException{
                    //if(!context.mounted) return;
                    await showErrorDialog(context,
                     "User not found");
                }on WrongPasswordAuthException{
                    //if(!context.mounted) return;
                    await showErrorDialog(context,
                     "You entered wrong password");
                }on InvalidEmailAuthException{
                    //if(!context.mounted) return;
                    await showErrorDialog(context,
                     "Invalid Email");
                } on GenericAuthException{
                  //if(!context.mounted) return;
                    await showErrorDialog(context,
                    'Authentication Error');
                }
              },
              child: const Text('Login'),),
              TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                   (route) => false);
              },
               child: const Text('Not registered yet? Register here!'))
            ],
          ),
    );
  }
}
