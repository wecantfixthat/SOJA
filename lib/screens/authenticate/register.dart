import 'package:flutter/material.dart';
import 'package:soja/services/auth.dart';
import 'package:soja/shared/constants.dart';
import 'package:soja/shared/loading.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  Register({this.toggleView});


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String email = '';
  String username = '';
  String firstName = '';
  String lastName = '';
  String bio = '';
  String date = '';
  String gender = '';
  String password = '';
  String error = '';

  void _handleGenderChange(String? value) {
    setState(() {
      gender = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
          backgroundColor: Colors.purple[400],
          elevation: 0.0,
          title:Text('Register to SOJA'),
        actions: <Widget> [
          TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              onPressed: () {
                widget.toggleView!();
              }
          )
        ],
      ),
      body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget> [
            SizedBox(height: 20.0,),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Email'),
                style: TextStyle(color: Colors.black),
              validator: (val) => val!.isEmpty ? 'Enter email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                }
            ),
            SizedBox(height: 20.0,),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Username'),
                style: TextStyle(color: Colors.black),
                validator: (val) => val!.isEmpty ? 'Enter username' : null,
                onChanged: (val) {
                  setState(() {
                    username = val;
                  });
                }
            ),
            SizedBox(height: 20.0,),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter First Name'),
                style: TextStyle(color: Colors.black),
                validator: (val) => val!.isEmpty ? 'Enter first name' : null,
                onChanged: (val) {
                  setState(() {
                    firstName = val;
                  });
                }
            ),
            SizedBox(height: 20.0,),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Last Name'),
                style: TextStyle(color: Colors.black),
                validator: (val) => val!.isEmpty ? 'Enter last name' : null,
                onChanged: (val) {
                  setState(() {
                    lastName = val;
                  });
                }
            ),
            SizedBox(height: 20.0,),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Date of Birth'),
                validator: (val) => val!.isEmpty ? 'Enter date of birth' : null,
                onChanged: (val) {
                  setState(() {
                    date = val;
                  });
                }
            ),
            SizedBox(height: 20.0,),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Password'),
                style: TextStyle(color: Colors.black),
                obscureText: true,
                validator: (val) => val!.length < 8 ? 'Enter a password 8+ chars long' : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                }
            ),
            SizedBox(height: 20.0,),
            Text('Select Your Gender'),
            Radio<String>(
              value: "Male",
              groupValue: gender,
              onChanged: _handleGenderChange,
            ),
            Text("Male"),
            Radio<String>(
              value: "Female",
              groupValue: gender,
              onChanged: _handleGenderChange,
            ),
            Text("Female"),
            Radio<String>(
              value: "Nonbinary",
              groupValue: gender,
              onChanged: _handleGenderChange,
            ),
            Text("Nonbinary"),
            SizedBox(height: 20.0,),
            ElevatedButton(
              child: Text('Register'),
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Colors.purple[400]),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(color: Colors.white))),
              onPressed: () async {
                if(_formKey.currentState!.validate()) {
                  setState(() => loading = true);
                  dynamic result = await _auth.register(email, username, firstName, lastName, date, password, gender, bio);
                  if (result == null) {
                    setState(() {
                        error = 'please fill the required credentials';
                        loading = false;
                    });
                  }
                }
              }
            ),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],

        ),
      ),
    ),
    );
  }
}
