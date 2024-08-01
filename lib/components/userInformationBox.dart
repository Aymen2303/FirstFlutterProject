import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userdetailsapp/uikit/uiColors.dart';

class UserInformationBox extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNum;

  UserInformationBox({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40.0),
          const Text(
            'User Informations',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(height: 20.0), // Creates spacing between each row
          Row(
            children: [
              const Text(
                'Full Name',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(color: uiColors.notSelected),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Text(
                'E-mail',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                email,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(color: uiColors.notSelected),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Text(
                'Phone',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                phoneNum,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
          const Divider(color: uiColors.notSelected),
        ],
      ),
    );
  }
}
