import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class SignInScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
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

                          ref.read(authLoadingProvider.notifier).state = true;
                          try {
                            final authService =
                                ref.read(authServiceProvider);
                            await authService.signIn(email, password);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Signed In!')),
                            );
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
                      : Text('Sign In'),
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
              icon: Icon(Icons.login),
              label: Text('Sign In with Google'),
            ),
            TextButton(
              onPressed: () => context.go('/sign-up'),
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
