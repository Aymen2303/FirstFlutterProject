
import 'package:flutter/material.dart';
import 'package:userdetailsapp/uikit/uiColors.dart';


class Alertdialogwidget extends StatelessWidget {

 //variables
 final String text;
 final VoidCallback onPressed;


 const Alertdialogwidget({super.key,  //constructor
  required this.text,
  required this.onPressed,
 });

//widget
 @override
  Widget build(BuildContext context) {
    return AlertDialog(
     title: const Text('Alert Message!'),
     content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
       fontSize: 14.0,
       fontWeight: FontWeight.bold,
      ),
     ),
    actions: [
     TextButton(
      onPressed: onPressed,
      child: const Text(
       'Refresh',
       style: TextStyle(
        color: uiColors.selected,
       ),
      ),
     ),
    ],
    );
  }
}