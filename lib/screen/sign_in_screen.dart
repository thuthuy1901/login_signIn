import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screen/login_screen.dart';

import '../constants.dart';
import '../user.dart';

class SignInScreen extends StatefulWidget {
  final List<User> data;
  SignInScreen({required this.data});

  @override
  State<StatefulWidget> createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
  List<User> _users = [];
  final _formSignIn = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passController = TextEditingController();

  bool isNotice = false;
  bool isHoveredLogIn = false;

  @override
  void initState() {
    super.initState();
    _users = widget.data;
  }

  addAccount(name, pass) async {
    try {
      final response = await Dio().post(
        urlUser,
        data: {"name": "$name", "password": "$pass"},
      );
    } catch (error) {
      print("Error adding user: $error");
    }
  }

  swicthLogInScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formSignIn,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SIGN IN",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isNotice)
                Text(
                  'Account already exists',
                  style: TextStyle(color: colorApp.Notice.color),
                ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter  user name',
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: InkWell(
                    child: Icon(Icons.clear),
                    onTap: () {
                      _nameController.clear();
                    },
                  ),
                  border: UnderlineInputBorder(),
                  errorStyle: TextStyle(),
                ),
                validator: (value) {
                  return checkEmpty(value);
                },
              ),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter  password',
                  prefixIcon: Icon(Icons.key),
                  suffixIcon: InkWell(
                    child: Icon(Icons.clear),
                    onTap: () {
                      _passController.clear();
                    },
                  ),
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  return checkEmpty(value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formSignIn.currentState!.validate()) {
                    bool exitsAccount = _users
                        .any((user) => user.nameUser == _nameController.text);
                    if (exitsAccount) {
                      setState(() {
                        isNotice = true;
                      });
                    } else {
                      addAccount(_nameController.text, _passController.text);
                      swicthLogInScreen();
                    }
                  }
                },
                child: Text('Sign In'),
              ),
              InkWell(
                onTap: () {
                  swicthLogInScreen();
                },
                child: MouseRegion(
                  onHover: (_) {
                    setState(() {
                      isHoveredLogIn = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      isHoveredLogIn = false;
                    });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: isHoveredLogIn
                          ? colorApp.Work.color
                          : colorApp.Primary.color,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
