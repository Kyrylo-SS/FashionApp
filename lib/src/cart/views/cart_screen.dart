import 'package:flutter/material.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/src/auth/views/login_screen.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null) {
      return const LoginScreen();
    }
    return Scaffold(body: Center(child: Text("Cart Page")));
  }
}
