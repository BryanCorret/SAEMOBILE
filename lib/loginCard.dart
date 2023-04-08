import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  bool _isLoading = false;
  bool _incorrectData = false;

  Future<void> _loginUser() async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse('https://fakestoreapi.com/auth/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _email,
        'password': _password,
      }),
    );
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 200) {
      // Les informations de connexion sont valides
      // Naviguez vers la page suivante
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Les informations de connexion sont invalides
      setState(() {
        _incorrectData = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Se connecter'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Veuillez saisir votre adresse email';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre mot de passe';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _loginUser();
                }
              },
              child: Text('Se connecter'),
            ),
            _incorrectData
                ? const Text(
              'Données incorrectes',
              style: TextStyle(color: Colors.red),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}