import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLoadingProvider = StateProvider<bool>((ref) => false);
final authErrorProvider = StateProvider<String?>((ref) => null);

class AuthPage extends StatelessWidget {
  final bool isSignUp;

   AuthPage({required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isSignUp ? 'Sign Up' : 'Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const  TextField(
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
           const  TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (isSignUp)
             const  TextField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
            const SizedBox(height: 16),
            Consumer(builder: (context, ref, _) {
              final isLoading = ref.watch(authLoadingProvider);

              return ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (isSignUp) {
                        } else {
                        }
                      },
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(isSignUp ? 'Sign Up' : 'Sign In'),
              );
            }),
           const  SizedBox(height: 16),
            Consumer(builder: (context, ref, _) {
              final error = ref.watch(authErrorProvider);

              return error != null
                  ? Text(error, style: const TextStyle(color: Colors.red))
                  : const SizedBox.shrink();
            }),
            if (!isSignUp)
              TextButton(
                onPressed: () {
                  // Trigger forgot password logic
                },
                child:const Text('Forgot Password?'),
              ),
          ],
        ),
      ),
    );
  }
}
