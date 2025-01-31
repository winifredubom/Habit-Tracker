import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/modules/screens/home/home_page.dart';
import 'package:habit_tracker/modules/screens/onboarding/sign_in_page.dart';
import 'package:habit_tracker/modules/screens/onboarding/sign_up_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to check if the user is authenticated
final authProvider = StateProvider<bool>((ref) => false);

// Firebase Auth service provider
final authServiceProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// Stream provider for auth state changes
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges();
});

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/sign-up',
    refreshListenable: RouterNotifier(ref),
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => SignInScreen(),
      ),
      
    ],
    redirect: (context, state) {
      final ref = ProviderScope.containerOf(context);
      final authState = ref.read(authStateProvider);
      final isSigningIn = state.uri.toString() == '/sign-in' ||
          state.uri.toString() == '/sign-up';

          if(authState.isLoading) return null;

          return authState.when(data: (user) {
            if(user != null){
              return isSigningIn ? '/home' : null;
            }
            return !isSigningIn ? '/sign-up' : null;
          }, 
          error: (_, __) => '/sign-up', 
          loading: () => null);
      // if (!isAuthenticated && !isSigningIn) {
      //   return '/sign-up';
      // }
      // if (isAuthenticated && isSigningIn) {
      //   return '/home';
      // }
      // return null;
    },
  );
  return router;
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(authStateProvider, (_, __) {
      notifyListeners();
    });
  }
}
