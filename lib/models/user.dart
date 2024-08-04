// lib/models/user.dart

import 'package:intl/intl.dart';

class User {
  final String name;
  final String email;
  final String country;
  final String pictureUrl;
  final String phoneNumber;
  final String dateOfBirth;

  User({
    required this.name,
    required this.email,
    required this.country,
    required this.pictureUrl,
    required this.phoneNumber,
    required this.dateOfBirth,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final name = '${json['name']['first']} ${json['name']['last']}';
    final email = json['email'];
    final country = json['location']['country'];
    final pictureUrl = json['picture']['large'];
    final phoneNumber = json['phone'];
    final dateOfBirth = json['dob']['date'];

    return User(
      name: name,
      email: email,
      country: country,
      pictureUrl: pictureUrl,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
    );
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, dateOfBirth: $dateOfBirth, phoneNum: $phoneNumber}';
  }

  ///function to showcase only the format we need
  String toDate( String wrongDate){
      DateTime rightDate = DateTime.parse(wrongDate);
      String formatDate = DateFormat('yyyy-mm-dd').format(rightDate);
      return formatDate.toString();
  }
}
