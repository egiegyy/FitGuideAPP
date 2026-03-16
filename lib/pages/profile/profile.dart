import 'dart:io';
import 'package:fitguide/database/preferance.dart';
import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/pages/gate/signIn.dart';
import 'package:fitguide/pages/gate/signUp.dart';
import 'package:fitguide/pages/profile/progress/progress.dart';
import 'package:fitguide/pages/profile/routine/routine.dart';
import 'package:fitguide/pages/profile/setting.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> routineDays = [];
  String username = "";
  File? profileImage;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    initProfile();
  }

  Future initProfile() async {
    await getUser();
    await loadProfileImage();
    await loadRoutine();
  }

  Future getUser() async {
    String? user = await UserPref.getLoginUser();

    setState(() {
      username = user ?? "username";
    });
  }

  Future loadProfileImage() async {
    String? user = await UserPref.getLoginUser();

    if (user == null) return;

    String? path = await UserPref.getProfileImage(user);

    if (path != null) {
      setState(() {
        profileImage = File(path);
      });
    }
  }

  Future loadRoutine() async {
    final data = await DBHelper.getRoutineDays();

    setState(() {
      routineDays = data;
    });
  }

  Future pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      String? user = await UserPref.getLoginUser();

      if (user != null) {
        await UserPref.saveProfileImage(user, image.path);
      }

      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  void settingButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingPage()),
    );
  }

  void chooseImageSource() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void logoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Apakah anda yakin ingin keluar?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tidak"),
            ),
            TextButton(
              onPressed: () async {
                await UserPref.logout();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                  (route) => false,
                );
              },
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  void deleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: const Text("Apakah anda yakin ingin menghapus akun?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tidak"),
            ),
            TextButton(
              onPressed: () async {
                final db = await DBHelper.db(); //ambil database
                await db.delete("progress"); //hapus kolom
                await db.delete("routine");
                await UserPref.deleteAccount(); //hapus akun
                await DBHelper.resetDB(); //reset db
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                  (route) => false,
                );
              },
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF000000),
              Color(0xFF0A0F0A),
              Color(0xFF101810),
              Color(0xFF000000),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),

            child: Column(
              children: [
                /// PROFILE PHOTO
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF66BB6A),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey[900],
                        backgroundImage: profileImage != null
                            ? FileImage(profileImage!)
                            : null,
                        child: profileImage == null
                            ? const Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: chooseImageSource,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF2E7D32),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                /// USERNAME
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                /// PROGRESS & ROUTINE BUTTON
                Row(
                  children: [
                    /// PROGRESS
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Progress(),
                            ),
                          );
                        },
                        child: Container(
                          height: 110,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: Colors.white,
                                size: 35,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Progress",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    /// ROUTINE
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyRoutine(),
                            ),
                          );
                          loadRoutine();
                        },
                        child: Container(
                          height: 110,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.view_list,
                                color: Colors.white,
                                size: 35,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Routine",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// SETTINGS
                buildMenuTile(
                  icon: Icons.settings_rounded,
                  title: "Settings",
                  onTap: settingButton,
                ),

                const SizedBox(height: 10),

                buildMenuTile(
                  icon: Icons.logout_rounded,
                  title: "Logout",
                  onTap: logoutDialog,
                ),

                const SizedBox(height: 10),

                buildMenuTile(
                  icon: Icons.delete,
                  title: "Delete Account",
                  onTap: deleteAccountDialog,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white24),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}
