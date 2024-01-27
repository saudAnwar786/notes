import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/firebase_options.dart';
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
                  final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password);
                  // await user?.sendEmailVerification;
                  if(!context.mounted) return;
                  Navigator.of(context).pushNamed(
                    verifyEmailRoute,
                  );
                }on FirebaseAuthException catch (e){
                    if(e.code == 'email-already-in-use'){
                      if(!context.mounted) return;
                      showErrorDialog(
                        context,
                        "Email Already Exists",
                      );
                    }else if(e.code == 'weak-password'){
                      if(!context.mounted) return;
                      showErrorDialog(
                        context,
                        "Weak Password",
                      );
                    }else if(e.code == 'invalid-email'){
                      if(!context.mounted) return;
                      showErrorDialog(
                        context,
                        "Invalid Mail",
                      );
                    }else{
                      if(!context.mounted) return;
                      showErrorDialog(
                        context,
                        "Error: ${e.code}",
                      );
                    }
                    
                }catch (e){
                  if(!context.mounted) return;
                      showErrorDialog(
                        context,
                        "Error: ${e.toString()}",
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
