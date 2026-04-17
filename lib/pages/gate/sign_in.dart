import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitguide/firebase/services/auth_service.dart';
import 'package:fitguide/utils/animation_utils.dart';
import 'package:fitguide/utils/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isLoading = false;

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        await AuthService.signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (!mounted) return;
        if (FirebaseAuth.instance.currentUser != null) {
          context.go('/home');
        }
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        String message = "Email atau password salah";
        if (e.code == 'user-not-found') {
          message = "Akun tidak ditemukan";
        } else if (e.code == 'wrong-password') {
          message = "Password salah";
        }
        UIComponents.showErrorSnackBar(context, message);
      } catch (_) {
        if (!mounted) return;
        UIComponents.showErrorSnackBar(context, "Terjadi kesalahan saat login");
      } finally {
        if (mounted) {
          setState(() => isLoading = false);
        }
      }
    }
  }

  Future<void> loginWithGoogle() async {
    setState(() => isLoading = true);

    try {
      final user = await AuthService.signInWithGoogle();

      if (!mounted) return;
      if (user != null) {
        context.go('/home');
      }
    } catch (_) {
      if (!mounted) return;
      UIComponents.showErrorSnackBar(
        context,
        "Terjadi kesalahan saat login Google",
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UIComponents.loadingOverlay(
      isLoading: isLoading,
      loadingMessage: "Sedang masuk...",
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  AnimationUtils.bounceIn(
                    child: const Image(
                      image: AssetImage("assets/images/logo_fitguide.png"),
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimationUtils.fadeIn(
                    delay: const Duration(milliseconds: 300),
                    child: Form(
                      key: _formKey,
                      child: UIComponents.animatedCard(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: AnimationUtils.staggeredAnimation(
                            children: [
                              UIComponents.animatedTextField(
                                controller: emailController,
                                label: "Email",
                                hint: "Email",
                                icon: Icons.email_rounded,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Email cannot be empty";
                                  }
                                  if (!value.contains("@gmail.com")) {
                                    return "Email is not valid";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),

                              /// PASSWORD
                              UIComponents.animatedTextField(
                                controller: passwordController,
                                label: "Password",
                                hint: "Password",
                                icon: Icons.lock,
                                obscureText: !isPasswordVisible,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Password cannot be empty";
                                  }
                                  if (value.trim().length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              /// SIGN IN BUTTON
                              UIComponents.animatedButton(
                                text: "Sign In",
                                onPressed: login,
                                isLoading: isLoading,
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: isLoading ? null : loginWithGoogle,
                                  icon: const Icon(Icons.login),
                                  label: const Text("Login with Google"),
                                ),
                              ),
                              const SizedBox(height: 10),

                              /// SIGN UP LINK
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have account? ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      context.go('/signup');
                                    },
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                            baseDelay: const Duration(milliseconds: 100),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
