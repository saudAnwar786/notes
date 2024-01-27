
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/views/login_view.dart';
import 'package:notes/views/notes_view.dart';
import 'package:notes/views/register_view.dart';
import 'package:notes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute : (context) => const RegisterView(),
        notesRoute :(context) => const NotesView(),
        verifyEmailRoute:(context) =>const VerifyEmailView(),
      },
    ));
}
class Homepage extends StatelessWidget {
  const Homepage({super.key});

    @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future:  Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              ),
        builder:(context,snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
              final user =  FirebaseAuth.instance.currentUser;
              if(user != null){
                if(user.emailVerified){
                  return const NotesView();
                }else{
                  return const VerifyEmailView();
                }
              }else{
                return const LoginView();
              }
              //return const NotesView();
            default:
              return const CircularProgressIndicator();
          }
           
        }
      );
  }
}




