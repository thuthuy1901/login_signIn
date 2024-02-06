import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/screen/home_screen.dart';
import 'package:todo_app/screen/sign_in_screen.dart';
import 'package:todo_app/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  List<User> _users = [];

  final _formLogIn = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  bool passToggle = true;
  bool stateWrong = false;
  bool isHoveredSignIn = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    print("log in");
  }

  fetchData() async {
    try {
      final response = await Dio().get(urlUser);
      if (response.statusCode == 200) {
        _users = (response.data as List<dynamic>)
            .map((user) => User.fromJson(user))
            .toList();
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print("Error get user: $error");
    }
  }

  swicthSignInScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(data: _users),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formLogIn,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LOG IN",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (stateWrong)
                Text(
                  'Wrong user or password',
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
                obscureText: passToggle,
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Icon(passToggle
                        ? Icons.check_box_outline_blank
                        : Icons.check_box),
                    onTap: () {
                      setState(() {
                        passToggle = !passToggle;
                      });
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Show password',
                    style: TextStyle(
                      color: passToggle
                          ? colorApp.Background.color
                          : colorApp.Work.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formLogIn.currentState!.validate()) {
                    List<User> filteredUsers = _users
                        .where((user) => user.nameUser == _nameController.text)
                        .toList();
                    bool containsPassword = filteredUsers
                        .any((user) => user.password == _passController.text);

                    if (containsPassword) {
                      setState(() {
                        stateWrong = false;
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(data: _nameController.text),
                        ),
                        (route) => false,
                      );
                    } else {
                      setState(() {
                        stateWrong = true;
                      });
                    }
                  }
                },
                child: Text('Login'),
              ),
              InkWell(
                onTap: () {
                  swicthSignInScreen();
                },
                child: MouseRegion(
                  onHover: (_) {
                    setState(() {
                      isHoveredSignIn = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      isHoveredSignIn = false;
                    });
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: isHoveredSignIn
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
