import 'package:fitguide/database/preferance.dart';
import 'package:fitguide/mainScreen.dart';
import 'package:fitguide/view/signUp.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      bool success = await UserPref.login(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username or Password incorrect")),
        );
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
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
          "Sign In",
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
              const Image(image: AssetImage("assets/images/logoFitGuide.png")),

              Container(
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forget Password?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),

                      /// SIGN IN BUTTON
                      SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),

                          onPressed: login,

                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      /// SIGN UP BUTTON
                      SizedBox(
                        width: double.infinity,

                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ),
                            );
                          },

                          child: const Text(
                            "Sign Up",
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
