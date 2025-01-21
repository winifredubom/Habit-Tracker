// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/auth/auth_page.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);

    return ElevatedButton.icon(
       icon: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const  LinearGradient(
            colors: [
              Color(0xFF4285F4), 
              Color(0xFF34A853),
              Color(0xFFFBBC05), 
              Color(0xFFEA4335),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child:const  Icon(Icons.g_mobiledata, color: Colors.white, size: 60,),
      ),
      label: const Text(""),
      onPressed: () async {
        try {
          final user = await authService.signInWithGoogle();
          if (user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Welcome, ${user.user?.displayName ?? "User"}!')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Google Sign-In canceled')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      },
    );
  }
}
