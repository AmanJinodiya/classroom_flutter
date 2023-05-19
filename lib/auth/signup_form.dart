import 'dart:convert';

import 'package:classroom/auth/login.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class signup_form extends StatefulWidget {
  final BuildContext context;
  signup_form({super.key, required this.context});

  @override
  State<signup_form> createState() => _signup_formState();
}

class _signup_formState extends State<signup_form> {
  final _email = TextEditingController();

  final _username = TextEditingController();

  final _password = TextEditingController();

  final _classno = TextEditingController();

  // Future create_acc() async {
  createAccount() async {
    final url = Uri.parse('http://10.0.2.2:8000/register/');
    final response = await http.post(url, body: {
      'username': _username.text,
      'email': _email.text,
      'password': _password.text,
      'class_num': _classno.text,
      'is_staff': (_isChecked)?"True":"False",
      "phone": "1231231232",
      "name": _username.text
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Check Credential's")));
      throw Exception('Failed to create account');
    }
  }

  bool PasswordConfirmed() {
    if (_password.text.trim() == _password.text.trim()) return true;
    return false;
  }

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextFormField(
                obscureText: true,
                controller: _classno,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Class Number',
                    suffixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.remove_red_eye_rounded))),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextFormField(
                obscureText: true,
                controller: _username,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Username',
                    suffixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.remove_red_eye_rounded))),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextFormField(
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.remove_red_eye_rounded))),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: null,
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.blue[300],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CheckboxListTile(
            title: Text("Student"),
            value: _isChecked,
            onChanged: (newValue) {
              setState(() {
                _isChecked = newValue!;
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 214, 181, 132))),
                  onPressed: createAccount,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                  ))),
        ),
      ],
    ));
  }
}
