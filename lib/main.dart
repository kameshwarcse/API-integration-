import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Homepage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();
  List getList=[];
  String _userEmail = '';
  String _password = '';
  static const String BaseUrl = "https://challengerscommunity.com/rest/index.php/";
  String LoginUrl = '$BaseUrl/login';

  // This function is triggered when the user press the "Sign Up" button
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      debugPrint(_userEmail);
      debugPrint(_password);
      fetchData(_userEmail,_password);
      /*
      Continute proccessing the provided information with your own logic
      such us sending HTTP requests, savaing to SQLite database, etc.
      */
    }
  }



  Future fetchData(String email, String password) async {
     var url = Uri.parse('https://challengerscommunity.com/rest/index.php/login');
   // http.Response response = await http.get(url);
     var data = {'email': email, 'password' : password};
     var response = await http.post(url, body: data); // REMOVED [email]
     print(data);
     if (response.statusCode == 201) {
      debugPrint("Success flutter");
      setState(() {
      final data=jsonDecode(response.body);
      print("your Data is");
      print(data);
      print(data['r']['name']);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 35),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Eamil
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email address';
                          }
                          // Check if the entered email has the right format
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          // Return null if the entered email is valid
                          return null;
                        },
                        onChanged: (value) => _userEmail = value,
                      ),

                      /// Password
                      TextFormField(
                        decoration:
                        const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (value.trim().length < 3) {
                            return 'Password must be at least 3 characters in length';
                          }

                          // Return null if the entered password is valid
                          return null;
                        },
                        onChanged: (value) => _password = value,
                      ),

// ajit.jadhav@nectarinfotel.com
                      const SizedBox(height: 20),
                      Container(
                          alignment: Alignment.centerRight,
                          child: OutlinedButton(
                              onPressed: _trySubmitForm,
                              child: const Text('Sign Up') )),


                      Container(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Row(
                            children: <Widget>[

                              FlatButton(
                                textColor: Colors.amber,
                                child: Text(
                                  'Go Next Page',
                                  style: TextStyle(fontSize: 15),
                                ),
                                onPressed: () {
                                  //signup screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePageUI()),
                                  );
                                },
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ))


                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}