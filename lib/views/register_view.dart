import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/services/auth/auth_service.dart';
import 'package:notes/services/auth_exceptions.dart';
import 'package:notes/utilities/show_error_dialog.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    return   Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                  await AuthService.firebase().createuser(email: email, password: password);
                  AuthService.firebase().sendEmailVerification();
                  if(!context.mounted) return;
                  Navigator.of(context).pushNamed(
                    verifyEmailRoute,
                  );
                }on EmailAlreadyInUSePasswordAuthException{
                    //if(!context.mounted) return;
                     await showErrorDialog(
                        context,
                        "Email Already Exists",
                      );
                }on WeakPasswordAuthException{
                    //if(!context.mounted) return;
                      await showErrorDialog(
                        context,
                        "Weak Password",
                      );
                }on InvalidEmailAuthException{
                    //if(!context.mounted) return;
                      await showErrorDialog(
                        context,
                        "Invalid Mail",
                      );
                }on GenericAuthException{
                    //if(!context.mounted) return;
                    await showErrorDialog(
                        context,
                        "Failed to register",
                      );
                }
              },
              child: const Text('Register'),
              ),
              TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
               child:const Text('Already registered? Log in!')
              )
            ],
          ),
    );
  }
}
