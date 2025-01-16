
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/modules/screens/onboarding/sign_in_page.dart';
import 'package:habit_tracker/modules/screens/onboarding/sign_up_page.dart';

final router = GoRouter(
  initialLocation: '/sign-in',
  routes: [
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => SignUpScreen(),
    ),
  ],
);
