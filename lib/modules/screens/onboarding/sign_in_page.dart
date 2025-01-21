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
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const  BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
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
                      : const Text('Sign In',
                      style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold),),
                );
              },
            ),
            const SizedBox(height: 16),
            const GoogleSignInButton(), 
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
               style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
                
              ),
              child: const Text("Don't have an account? Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
