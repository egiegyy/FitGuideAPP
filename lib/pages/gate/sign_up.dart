import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitguide/localization/app_language.dart';
import 'package:fitguide/services/auth_service.dart';
import 'package:fitguide/utils/animation_utils.dart';
import 'package:fitguide/utils/ui_components.dart';
import 'package:fitguide/pages/gate/sign_in.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;

  Future<void> register() async {
    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      setState(() => isLoading = true);

      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      try {
        await AuthService.register(
          username: username,
          email: email,
          password: password,
        );

        if (!mounted) return;
        await AuthService.signOut();
        if (!mounted) return;

        UIComponents.showSuccessSnackBar(
          context,
          context.tr("Registrasi berhasil. Silakan masuk untuk melanjutkan."),
        );

        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        String message = context.tr("Registrasi gagal");
        if (e.code == 'email-already-in-use') {
          message = context.tr("Email sudah digunakan");
        } else if (e.code == 'weak-password') {
          message = context.tr("Password terlalu lemah");
        }
        UIComponents.showErrorSnackBar(context, message);
      } catch (_) {
        if (!mounted) return;
        UIComponents.showErrorSnackBar(
          context,
          context.tr("Terjadi kesalahan saat registrasi"),
        );
      } finally {
        if (mounted) {
          setState(() => isLoading = false);
        }
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          context.tr("Sign Up"),
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
                              controller: usernameController,
                              label: context.tr("Username"),
                              hint: context.tr("Username"),
                              icon: Icons.person,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return context.tr("Username cannot be empty");
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            UIComponents.animatedTextField(
                              controller: emailController,
                              label: context.tr("Email"),
                              hint: context.tr("Email"),
                              icon: Icons.email_rounded,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return context.tr("Email cannot be empty");
                                }
                                if (!value.contains("@gmail.com")) {
                                  return context.tr("Email is not valid");
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            UIComponents.animatedTextField(
                              controller: passwordController,
                              label: context.tr("Password"),
                              hint: context.tr("Password"),
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
                                  return context.tr("Password cannot be empty");
                                }
                                if (value.trim().length < 6) {
                                  return context.tr(
                                    "Password must be at least 6 characters",
                                  );
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            UIComponents.animatedTextField(
                              controller: confirmPasswordController,
                              label: context.tr("Confirm Password"),
                              hint: context.tr("Confirm Password"),
                              icon: Icons.lock,
                              obscureText: !isConfirmPasswordVisible,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isConfirmPasswordVisible =
                                        !isConfirmPasswordVisible;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.tr(
                                    "Confirm password cannot be empty",
                                  );
                                }
                                if (value != passwordController.text) {
                                  return context.tr("Password does not match");
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            UIComponents.animatedButton(
                              text: context.tr("Sign Up"),
                              onPressed: register,
                              isLoading: isLoading,
                            ),
                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  context.tr("Already have account? "),
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
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignIn()),
                                      (route) => false,
                                    );
                                  },
                                  child: Text(
                                    context.tr("Sign In"),
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
