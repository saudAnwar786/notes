import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/views/register_view.dart';

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
                // await FirebaseAuth.instance.createUserWithEmailAndPassword(
                //   email: email,
                //   password: password);
                try{
                  final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email
                  , password: password);
                    print(userCredential);
                  
                } on FirebaseAuthException catch(e){
                     print(e.code);
                }catch (e){
                  print(e.runtimeType);
                  print(e);
                }
              },
              child: const Text('Login'),),
              TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/register',
                   (route) => false);
              },
               child: const Text('Not registered yet? Register here!'))
            ],
          ),
    );
  }
  
}