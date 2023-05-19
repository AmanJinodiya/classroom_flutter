import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> userData = {
    "username": "t1",
    "name": "aa",
    "email": "t1@gmail.com",
    "phone": "123123123",
    "class_num": 1
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://4.bp.blogspot.com/-Jx21kNqFSTU/UXemtqPhZCI/AAAAAAAAh74/BMGSzpU6F48/s1600/funny-cat-pictures-047-001.jpg"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            title: Center(
                child: Text(
              'Username',
              style: TextStyle(color: Colors.grey),
            )),
            subtitle: Center(
                child: Text(
              userData['username'],
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
          ),
          ListTile(
            title: Center(
                child: Text('Name', style: TextStyle(color: Colors.grey))),
            subtitle: Center(
                child: Text(
              userData['name'],
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
          ),
          ListTile(
            title: Center(
                child: Text('Email', style: TextStyle(color: Colors.grey))),
            subtitle: Center(
                child: Text(
              userData['email'],
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
          ),
          ListTile(
            title: Center(
                child: Text('Phone', style: TextStyle(color: Colors.grey))),
            subtitle: Center(
                child: Text(
              userData['phone'],
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
          ),
          ListTile(
            title: Center(
                child:
                    Text('Class Number', style: TextStyle(color: Colors.grey))),
            subtitle: Center(
                child: Text(
              userData['class_num'].toString(),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
          ),
        ],
      ),
    );
  }
}
