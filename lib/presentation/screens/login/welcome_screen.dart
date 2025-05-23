import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to the FakeStore"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go("/login");
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
