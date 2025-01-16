import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class SignUpScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Consumer(
              builder: (context, ref, _) {
                final isLoading = ref.watch(authLoadingProvider);

                return ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          final confirmPassword =
                              confirmPasswordController.text.trim();

                          if (password != confirmPassword) {
                            ref.read(authErrorProvider.notifier).state =
                                'Passwords do not match!';
                            return;
                          }

                          ref.read(authLoadingProvider.notifier).state = true;
                          try {
                            final authService =
                                ref.read(authServiceProvider);
                            await authService.signUp(email, password);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Account Created!')),
                            );
                            context.go('/sign-in');
                          } catch (e) {
                            ref.read(authErrorProvider.notifier).state =
                                e.toString();
                          } finally {
                            ref.read(authLoadingProvider.notifier).state =
                                false;
                          }
                        },
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Sign Up'),
                );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  await ref.read(authServiceProvider).signInWithGoogle();
                } catch (e) {
                  ref.read(authErrorProvider.notifier).state = e.toString();
                }
              },
              icon: Icon(Icons.person_add),
              label: Text('Sign Up with Google'),
            ),
            TextButton(
              onPressed: () => context.go('/sign-in'),
              child: Text('Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
