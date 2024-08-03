import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart' as http;
import 'package:userdetailsapp/_UserDetails.dart';
import 'package:userdetailsapp/components/AlertDialogWidget.dart';
import 'package:userdetailsapp/components/ProgressDialogWidget.dart';
import 'package:userdetailsapp/components/RefreshFloatingActionButton.dart';
import 'package:userdetailsapp/models/user.dart';
import 'package:userdetailsapp/uikit/uiColors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool isVisible = true;
  bool isProgressDialogShowing = false;
  List<User> users = [];

  Future<void> _loadUsers() async {
    Progressdialogwidget.showProgressDialog(context);
    const String URL = 'https://randomuser.me/api/?results=10';

    try {
      final http.Response response = await http.get(Uri.parse(URL));

      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      }

      final decode = json.decode(response.body);
      final List results = decode['results'];
      Navigator.of(context).pop();

      List<User> loadedUsers = results.map((json) => User.fromJson(json)).toList();
      debugPrint('list users is:  $loadedUsers');
      loadedUsers.sort((a, b) => a.name.compareTo(b.name));

      // Initial application state
      setState(() {
        users = loadedUsers;
        isVisible = false;
      });

    } catch (exception) {
      debugPrint('Error occurred while fetching data: $exception');
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop(); // Dismiss the progress dialog if it is still shown
      }
      _showDialog(context);
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){ //wait for the initState to finish before calling  _loadUsers()
      _loadUsers();
    });
  }

  void _showDialog(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder:  (BuildContext context) => Alertdialogwidget(
            text: "Sorry, we could not retrieve the list at this moment, click on “Refresh” to try again.",
            onPressed: (){
              _loadUsers();
              Navigator.of(context).pop();
            })
    );
  }

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
            child: isVisible //showing the text if there is no Users List
                ? const Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'Please hit the "Refresh" button down below, or slide the screen down '
                    'to retrieve a new list of users',
                style: TextStyle(
                  fontSize: 16.0,
                  color: uiColors.hintText,
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
                  color: uiColors.random,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: uiColors.selected, width: 1),
                  ),
                  child: SizedBox(
                    width: double.infinity,
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
                       Expanded(
                        child:
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
                                  color: uiColors.hintText,
                                ),
                              ),
                              Text(
                                user.country,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: uiColors.hintText,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                  context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDetails(user: user),
                                    ),
                                  );
                                },
                               child: const Text(
                                'Click to show more information',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: uiColors.selected,
                                ),
                              ),
                              ),
                            ],
                          ),
                        ),)
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
        child: RefreshFloatingActionButton( //Calling the refresh widget
          onPressed: _loadUsers,
        ),
      ),
    );
  }
}