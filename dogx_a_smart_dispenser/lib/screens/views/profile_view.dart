import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
      onPressed: () async {
        await _authService.signOut();
      },
      child: Text("LOG OUT"),
    ));
  }
}
