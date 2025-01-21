// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/config/routes/route_path.dart';

class SignOutDialog extends ConsumerWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await ref.read(authServiceProvider).signOut();
                Navigator.of(context).pop();
                context.go('/sign-in');
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      }
  }
