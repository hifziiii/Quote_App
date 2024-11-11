import 'package:flutter/material.dart';
import 'package:login_signup/model/UserModel.dart';
import 'package:login_signup/model/pages/author1_page.dart';
import 'package:login_signup/model/pages/author2_page.dart';
import 'package:login_signup/model/pages/author3_page.dart';
import 'package:login_signup/model/pages/author4_page.dart';
import 'package:login_signup/view/home/screens/ProfileScreen.dart';
import 'package:login_signup/view/home/screens/SettingScreen.dart';

class QuotesScreen extends StatelessWidget {
  final User user = User(
    firstName: ' ',
    lastName: ' ',
    email: ' ',
    password: ' ',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Authors',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffE57373),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xffE57373),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100, // Adjusted width
                    height: 80, // Adjusted height
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: const Color(0xffE57373),
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10),
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome, ${user.firstName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settingscreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Author 1',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Author1Page()),
                  );
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Author 2',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Author2Page()),
                  );
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Author 3',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Author3Page()),
                  );
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Author 4',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Author4Page()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = User(
      firstName: ' ',
      lastName: ' ',
      email: ' ',
      password: ' ',
    );

    return MaterialApp(
      title: 'Drawer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuotesScreen(),
      routes: {
        '/profile': (context) => ProfileScreen(user: user),
        '/settings': (context) => Settingscreen(),
      },
    );
  }
}
