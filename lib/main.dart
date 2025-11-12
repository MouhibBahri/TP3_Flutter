import 'package:flutter/material.dart';
import 'package:tp3/screens/basket_screen.dart';
import 'models/user.dart';
import 'services/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userService = UserService();

  final user = User.withEmailAndName(
    email: "test@example.com",
    fullName: "Mouhib Bahri",
  );
  // Save user
  await userService.saveCurrentUser(user);

  // Get user
  final savedUser = await userService.getCurrentUser();
  print("User from storage: ${savedUser?.fullName}, ${savedUser?.email}");

  // Clear user
  await userService.clearCurrentUser();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BasketScreen(),
    );
  }
}
