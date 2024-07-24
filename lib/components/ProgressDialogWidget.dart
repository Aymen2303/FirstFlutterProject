
import 'package:flutter/material.dart';
import 'package:userdetailsapp/uikit/uiColors.dart';

class Progressdialogwidget extends StatelessWidget{

  //constructor
  const Progressdialogwidget({super.key});

  @override
  Widget build(BuildContext context) {
   return const Dialog(
     backgroundColor: Colors.transparent,
     child: Center(
       child: CircularProgressIndicator(
         valueColor: AlwaysStoppedAnimation<Color> (uiColors.selected),
       )
     ),
   );
  }


  /// Creating a static void, since we using this progressDialog once
  /// and it has no attributes such as text, etc...
  static void showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(uiColors.selected),
          ),
        ),
      ),
    );
  }

}