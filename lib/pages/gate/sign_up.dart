import 'package:fitguide/database/preferance.dart';
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

  Future<void> register() async {
    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      bool success = await UserPref.saveUser(
        username: username,
        email: email,
        password: password,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful")),
        );

        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username already exists")),
        );
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

  /// INPUT DECORATION FUNCTION
  InputDecoration inputDecoration({
    required IconData icon,
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFD9D9D9),
      prefixIcon: Icon(icon, color: Colors.black54),
      suffixIcon: suffixIcon,
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black54),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Image(
                image: AssetImage("assets/images/logo_fitguide.png"),
                alignment: Alignment.topCenter,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,

                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// USERNAME
                      const Text(
                        "Username",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: usernameController,
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                          icon: Icons.person,
                          hint: "Username",
                        ),
                      ),
                      const SizedBox(height: 15),

                      /// EMAIL
                      const Text(
                        "Email",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.black),

                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Email cannot be empty";
                          }

                          if (!value.contains("@gmail.com")) {
                            return "Email is not valid";
                          }

                          return null;
                        },
                        decoration: inputDecoration(
                          icon: Icons.email_rounded,
                          hint: "Email",
                        ),
                      ),
                      const SizedBox(height: 15),

                      /// PASSWORD
                      const Text(
                        "Password",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        style: const TextStyle(color: Colors.black),

                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Password cannot be empty";
                          }

                          if (value.trim().length < 6) {
                            return "Password must be at least 6 characters";
                          }

                          return null;
                        },
                        decoration: inputDecoration(
                          icon: Icons.lock,
                          hint: "Password",
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
                        ),
                      ),
                      const SizedBox(height: 15),

                      /// CONFIRM PASSWORD
                      const Text(
                        "Confirm Password",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: !isConfirmPasswordVisible,
                        style: const TextStyle(color: Colors.black),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm password cannot be empty";
                          }

                          if (value != passwordController.text) {
                            return "Password does not match";
                          }

                          return null;
                        },

                        decoration: inputDecoration(
                          icon: Icons.lock,
                          hint: "Confirm Password",
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
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// SIGN UP BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            onPressed: register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// ALREADY HAVE ACCOUNT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have account? ",
                            style: TextStyle(color: Colors.white),
                          ),

                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),

                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignIn(),
                                ),
                              );
                            },

                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
