import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:userdetailsapp/uikit/uiColors.dart';

class birthdayBox extends StatelessWidget{

  final String datetext;

  birthdayBox({  //constructor
    super.key,
    required this.datetext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 75,
      decoration: BoxDecoration(
        color: uiColors.backColorForDateBox,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow:[
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Date of Birth",
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            datetext,
            style:  const TextStyle(
              fontSize: 16.0,
              color: uiColors.hintText,
            ),
          ),
        ],
      ),
    );
  }
}