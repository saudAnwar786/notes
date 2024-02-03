import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:notes/constants/routes.dart';
import 'package:notes/enums/menu_actions.dart';
import 'package:notes/services/auth/auth_service.dart';
class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<MenuAction>( onSelected: (value) async{
            switch(value){
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                devtools.log(shouldLogout.toString());
                if(shouldLogout){
                  await AuthService.firebase().logOut();
                  if(!context.mounted) return;
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                     (route) => false
                  );
                }
            }
          },
          itemBuilder: (context){
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child:  Text('Log out'),
              )
            ]; 
          },
         )
        ],
      ),

    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
   return showDialog<bool>(
    context: context,
    builder: (context){
      return AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are your sure to log out ?'),
        actions: [
          TextButton(
           onPressed: (){
            Navigator.of(context).pop(true);
           },
           child:const Text('Yes')
          ),
          TextButton(
           onPressed: (){
            Navigator.of(context).pop(false);
           },
           child:const Text('No')
          )
        ],
      );
   }).then((value) => value ?? false);
}