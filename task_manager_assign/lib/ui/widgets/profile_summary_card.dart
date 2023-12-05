import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:task_manager_assign/ui/controllers/auth_controllers.dart';
import 'package:task_manager_assign/ui/screens/LoginScreen.dart';
import 'package:task_manager_assign/ui/screens/edit_profile_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    Key? key,
    this.enableOnTap = true,
  }) : super(key: key);

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    String imageBytes = AuthController.user?.photo ?? '';
    Uint8List bytes = base64.decode(imageBytes.split(',').last);

    return ListTile(
      onTap: () {
        if (enableOnTap) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ),
          );
        }
      },
      leading: CircleAvatar(
        child: AuthController.user?.photo == null
            ? const Icon(Icons.person)
            : ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.memory(
                  bytes,
                  fit: BoxFit.cover,
                ),
              ),
      ),
      title: Text(
        AuthController.user!.firstName ?? '',
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        AuthController.user?.email ?? '',
        style: const TextStyle(color: Colors.white),
      ),
      trailing: GestureDetector(
        onTap: () async {
          AuthController.clearAuthData();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        },
        child: const Icon(Icons.logout_outlined),
      ),
      tileColor: Colors.green,
    );
  }
}
