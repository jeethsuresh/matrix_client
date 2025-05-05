import 'package:flutter/material.dart';
import 'package:matrix_client/requests.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _RequestLoginScreenState createState() => _RequestLoginScreenState();
}

class _RequestLoginScreenState extends State<LoginScreen> {
  String username = "";
  String password = "";
  String homeserver = "";
  bool buttonPressed = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final homeserverController = TextEditingController();

  void _loginButton() {
    setState(() {
      username = usernameController.text;
      password = passwordController.text;
      homeserver = homeserverController.text;
      buttonPressed = true;
    });
  }

  Widget _buildLayout() {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          obscureText: false,
          controller: usernameController,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: passwordController,
          obscureText: true,
          maxLines: 1,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: homeserverController,
          maxLines: 1,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Homeserver',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: _loginButton,
          child: const Text('Login'),
        ),
      ),
      const Padding(padding: EdgeInsets.all(10.0)),
      FutureBuilder<String>(
        future: loginRequest(username, password, homeserver),
        builder: (context, response) {
          if (response.hasError) print(response.error);

          return response.hasData
              ? RichText(
                  text: TextSpan(
                      text: response.data,
                      style: const TextStyle(color: Colors.black)))
              : Center(
                  child: buttonPressed
                      ? const CircularProgressIndicator()
                      : const Padding(padding: EdgeInsets.all(10.0)));
        },
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _buildLayout();
    return Scaffold(
      appBar: AppBar(title: const Text("Test Login Screen")),
      body: content,
    );
  }
}
