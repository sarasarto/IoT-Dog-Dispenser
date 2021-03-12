/*import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profilo', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
            child: TextButton(
          onPressed: () async {
            await _authService.signOut();
          },
          child: Text("LOG OUT"),
        )),
      ),
    );
  }
}
*/