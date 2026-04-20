import 'dart:async';

import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitguide/pages/gate/sign_in.dart';
import 'package:fitguide/pages/gate/sign_up.dart';
import 'package:fitguide/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _authRefreshNotifier = _AuthStateRefreshNotifier(
    FirebaseAuth.instance.authStateChanges(),
  );

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: _authRefreshNotifier,
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final signedIn = user != null;
      final goingToSignIn = state.matchedLocation == '/signin';
      final goingToSignUp = state.matchedLocation == '/signup';
      final goingToHome = state.matchedLocation == '/home';
      final goingToRoot = state.matchedLocation == '/';

      if (!signedIn && (goingToHome || goingToRoot)) {
        return '/signin';
      }

      if (signedIn && (goingToSignIn || goingToSignUp || goingToRoot)) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) {
          return FirebaseAuth.instance.currentUser == null ? '/signin' : '/home';
        },
      ),
      GoRoute(
        path: '/signin',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 350),
          child: const SignIn(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 350),
          child: const SignUp(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 350),
          child: const MainScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        ),
      ),
    ],
  );
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          return const MainScreen();
        } else {
          return const SignIn();
        }
      },
    );
  }
}

class _AuthStateRefreshNotifier extends ChangeNotifier {
  _AuthStateRefreshNotifier(Stream<User?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<User?> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
