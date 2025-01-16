import 'package:go_router/go_router.dart';
import 'package:habit_tracker/modules/screens/home/home_page.dart';
import 'package:habit_tracker/modules/screens/onboarding/sign_in_page.dart';
import 'package:habit_tracker/modules/screens/onboarding/sign_up_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



// Provider to check if the user is authenticated
final authProvider = StateProvider<bool>((ref) => false);

final router = GoRouter(
  initialLocation: '/sign-up',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) =>  SignUpScreen(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) =>  SignInScreen(),
    ),
  ],
  redirect: (context, state) {
    final ref = ProviderScope.containerOf(context);
    final isAuthenticated = ref.read(authProvider);
    final isSigningIn = state.uri.toString() == '/sign-in' || state.uri.toString() == '/sign-up';

    if (!isAuthenticated && !isSigningIn) {
      return '/sign-up';
    }
    if (isAuthenticated && isSigningIn) {
      return '/home';
    }
    return null;
  },
);