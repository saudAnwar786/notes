import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(children: [
            const Text("we've sent you an email verification"),
            const Text("If you haven't recived a verification ,press the button"),
            TextButton(onPressed: () async{
              await AuthService.firebase().sendEmailVerification();
      
            }, child: const Text('Send Email Verification')),
            TextButton(onPressed: ()async{
              await AuthService.firebase().logOut();
              if(!context.mounted) return;
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
               (route) => false);
            },
             child: const Text('Restart')
            ),
        ],),
    );
  }
}