// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/modules/screens/components/google_in_button.dart';
import 'package:habit_tracker/core/auth/auth_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Define the authErrorProvider
final authErrorProvider = StateProvider<String?>((ref) => null);

// Define the authLoadingProvider
final authLoadingProvider = StateProvider<bool>((ref) => false);

class SignInScreen extends ConsumerWidget {
  SignInScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, _) {
                final isLoading = ref.watch(authLoadingProvider);

                return ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          ref.read(authLoadingProvider.notifier).state = true;
                          try {
                            final authService =
                                ref.read(authServiceProvider);
                            await authService.signInWithEmail(email, password);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Signed In!')),
                            );
                            context.go('/home');
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          } finally {
                            ref.read(authLoadingProvider.notifier).state =
                                false;
                          }
                        },
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Sign In'),
                );
              },
            ),
            const SizedBox(height: 16),
            const GoogleSignInButton(), // Custom reusable Google sign-in button
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, _) {
                final error = ref.watch(authErrorProvider);

                return error != null
                    ? Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go('/sign-up'),
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
