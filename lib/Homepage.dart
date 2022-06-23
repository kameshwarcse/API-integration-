

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageUI extends StatelessWidget {
  const HomePageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApi(),

    );
  }
}
class MyApi extends StatefulWidget {
  const MyApi({Key? key}) : super(key: key);

  @override
  _MyApi createState() => _MyApi();
}

class _MyApi extends State<MyApi> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();

    getDio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: users.map((e) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("NAME:- "+e["name"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                                )),
                                Text("USERNAME:- "+e["username"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    )),
                                  Text("EMAIL:- "+e["email"],maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  Text("COMPANY NAME:- "+e["company"]["name"],maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  Text("CITY:- "+e["address"]["city"],maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  Chip(label: Text("WEBSITE:-"+e["website"]),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("PINCODE:-",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(e["address"]["zipcode"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          )),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void getDio() async {
    try {
      var dio = Dio();
      final response = await dio.get('https://jsonplaceholder.typicode.com/users');
      print(response.data);

      users = response.data;
      print(users);
      // setState(() {});
    } catch (e) {
      print("Not Working");
      print(e);
    }
  }
}
