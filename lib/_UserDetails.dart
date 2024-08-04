import 'package:flutter/material.dart';
import 'package:userdetailsapp/components/birthdaybox.dart';
import 'package:userdetailsapp/components/userInformationBox.dart';
import 'package:userdetailsapp/models/user.dart';
import 'package:userdetailsapp/uikit/uiColors.dart';

class UserDetails extends StatelessWidget {
  final User user;

  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "User Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: uiColors.selected,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Image.network(
                    user.pictureUrl,
                    height: 124,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Space between image and name
            Align(
              alignment: Alignment.center,
              child: Text(
                user.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: birthdayBox(datetext: user.toDate(user.dateOfBirth)),
            ),
            const SizedBox(height: 50),
          Align(
            alignment: Alignment.center,
            child: UserInformationBox(
                name: user.name ,
                email: user.email,
               phoneNum: user.phoneNumber),
          )
          ],
        ),
      ),
    );
  }
}
