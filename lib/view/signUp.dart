import 'package:fitguide/database/preferance.dart';
import 'package:fitguide/view/signIn.dart';
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

      /// REGISTER BERHASIL
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful")),
        );

        /// reset form
        usernameController.clear();
        emailController.clear();
        passwordController.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
        );
      }
      /// USERNAME SUDAH ADA
      else {
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
    super.dispose();
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
              const Image(
                image: AssetImage("assets/images/logoFitGuide.png"),
                alignment: Alignment.topCenter,
              ),

              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),

                padding: const EdgeInsets.all(20),

                child: Form(
                  key: _formKey,

                  child: Column(
                    children: [
                      /// USERNAME
                      TextFormField(
                        controller: usernameController,
                        style: const TextStyle(color: Colors.white),

                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintText: "Please input your username",
                          hintStyle: const TextStyle(color: Colors.white),
                          labelText: "Username",
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// EMAIL
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),

                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Email cannot be empty";
                          }

                          if (!value.contains("@")) {
                            return "Email is not valid";
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          hintText: "Please input your email",
                          hintStyle: const TextStyle(color: Colors.white),
                          labelText: "Email",
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// PASSWORD
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),

                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Password cannot be empty";
                          }

                          if (value.trim().length < 6) {
                            return "Password must be at least 6 characters";
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: "Please input your password",
                          hintStyle: const TextStyle(color: Colors.white),
                          labelText: "Password",
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// SIGN UP BUTTON
                      SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),

                          onPressed: register,

                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      /// SIGN IN BUTTON
                      SizedBox(
                        width: double.infinity,

                        child: OutlinedButton(
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
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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
