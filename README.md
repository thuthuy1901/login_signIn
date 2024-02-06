## dio()

Using Json server to fake data use make app.

### get data

```agsl
    import 'package:dio/dio.dart';

    ...
    final response = await Dio().get(url);
    //data: response.data
```

### post data

```agsl
    import 'package:dio/dio.dart';

    ...
    final response = await Dio().post(
        urlUser,
        data: {"name": "$name", "password": "$pass"},
    );
```

## form

```agsl
    final _key = GlobalKey<FormState>();
    final _nameController = TextEditingController();
   
    ...
    Form(
        key: _key,
        TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter  user name',
            ),
            validator: (value) {
                return checkEmpty(value);
            },
        ),
        ElevatedButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                //handle logic after validate TextFormField
              }
            },
            child: Text('Sign In'),
        ),
    )
    
    //data: _nameController.text
```

## MaterialPageRoute

### pushAndRemoveUntil
delete stack storage  page odd to not back.

```agsl
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(),
        ),
        (route) => false,
    );
```

### push
click back to stack page storage.

```agsl
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
```

## click double button back to  out app

```agsl
    import 'package:fluttertoast/fluttertoast.dart';

    DateTime timeBackPressed = DateTime.now();
    
    WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);
        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          final message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold()
    );
```