import 'package:flutter/material.dart';
import 'package:login_signup/model/UserModel.dart';
import 'package:login_signup/view/home/screens/QuotesScreen.dart';
import 'package:login_signup/view/home/welcomescreen.dart';
import 'package:login_signup/view/signup/SignUpPage.dart';
import 'package:login_signup/widgt/DatabaseHelper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isObscure = true;

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await DatabaseHelper().getUserByEmail(email);
    if (user != null) {
      if (user.password == password) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QuotesScreen()));
      } else {
        setState(() {
          _errorMessage = 'Incorrect password!';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'No account found with this email!';
      });
    }
  }

  void _passwordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _showForgetPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _resetEmailController = TextEditingController();
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _resetEmailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        String email = _resetEmailController.text;
                        DatabaseHelper().getUserByEmail(email).then((user) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: user != null
                                ? Text('Reset link sent to $email')
                                : Text('No account found with this email!'),
                            backgroundColor: user != null ? Colors.green : Colors.red,
                          ));
                        });
                      },
                      child: Text('Send Reset Link', style: TextStyle(color: Color(0xffB71C1C))),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancel', style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Color(0xffE57373),
        title: Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/background.jpg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 200),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 11),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: _passwordVisibility,
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                    ),
                    obscureText: _isObscure,
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(140, 2, 0, 2),
                    child: GestureDetector(
                      onTap: _showForgetPasswordDialog,
                      child: Text(
                        'Forget Password!',
                        style: TextStyle(color: Color(0xffB71C1C), fontSize: 13),
                      ),
                    ),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Color(0xffE57373)),
                      ),
                    ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: _login,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Color(0xffFF4081), blurRadius: 2, offset: Offset(0, 0)),
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffE57373),
                        ),
                        child: Center(
                          child: Text(
                            'LogIn',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: TextStyle(fontSize: 15)),
                      SizedBox(width: 2),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                        },
                        child: Text(
                          'SignUp',
                          style: TextStyle(color: Color(0xffFF4081), fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
