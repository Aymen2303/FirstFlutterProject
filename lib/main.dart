import 'dart:async';
import 'dart:convert';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isVisible = true;
  List<User> users = [];

  Future<void> _loadUsers() async {
    _showProgressDialog(context);  //showing the progress dialog for the User
    const URL = 'https://randomuser.me/api/?results=10'; // result is 10 Users
    try {
      final http.Response response = await http.get(Uri.parse(URL));
      final decode = json.decode(response.body);
      final List<dynamic> results = decode['results'];

      ///**** Filter Method
      List<User> loadedUsers = results.map((json) => User.fromJson(json)).toList();
      loadedUsers.sort((a, b) => a.name.compareTo(b.name));


      setState(() {
        users = loadedUsers;
        isVisible = false;
      });

    } catch (exception) {
      _showDialog(context);
    }finally{
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUsers(); //load users on app start
  }

  ///  ***** Alert dialog function *******

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert Message!'),
        content: const Text(
          """Sorry, we couldn’t retrieve the list at this moment, 
            click on “Refresh” to try again.""",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _loadUsers();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Refresh',
              style: TextStyle(
                color: selected,
              ),
            ),
          )
        ],
      ),
    );
  }
  ///
  ///**** END ALERT DIALOG


  ///***** Progress Dialog
  void _showProgressDialog(BuildContext context){
  showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context)=> const Dialog(
    backgroundColor: Colors.transparent,
    child: Center(
      child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(selected),
      ),
      ),
    ),
  );
  }
  ///
  ///***** END Progress Dialog


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container( // container for the background Image
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: isVisible  //showin the text if there is no Users List
                ? const Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'Please hit the "Refresh" button down below, or slide the screen down '
                    'to retrieve a new list of users',
                style: TextStyle(
                  fontSize: 16.0,
                  color: hintText,
                ),
                textAlign: TextAlign.center,
              ),
            )
                : Container(), // showing empty container
          ),
          RefreshIndicator(
            onRefresh: _loadUsers,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 120.0),
              itemCount: users.length,
              itemBuilder: (BuildContext ctx, index) { //building user item
                final user = users[index];
                return Card( //card view
                  color: random,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: selected, width: 1),
                  ),
                  child: SizedBox(
                    width: 310,
                    height: 150,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50), //setting it to 50, so it looks circular
                            child: Image.network(  //image profile
                              user.pictureUrl,
                              width: 85,
                              height: 85,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                user.email,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: hintText,
                                ),
                              ),
                              Text(
                                user.country,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: hintText,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Click to show more information',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: selected,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: _loadUsers, // using the function to retreive a new list
          backgroundColor: random,
          child: const Icon(
            Icons.refresh_rounded,
            color: selected,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}

/// ******* User Class******
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
}//*****END USER CLASS


/// **** Colors ****
const selected = Color(0xff9747FF);
const notSelected = Color(0xffE1D0F6);
const hintText = Color(0xff7C7C7C);
const random = Color(0xffFFFFFF);
//*****END COLORS
