import 'package:fitguide/firebase/services/models/student_firebase_model.dart';
import 'package:fitguide/pages/gate/sign_in.dart';
import 'package:fitguide/pages/students/student_form_page.dart';
import 'package:fitguide/firebase/services/firebase_service.dart';
import 'package:flutter/material.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseService.logoutUser();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SignIn()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Student'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: FutureBuilder<List<StudentFirebaseModel>>(
        future: FirebaseService.getAllStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Terjadi error: ${snapshot.error}'));
          }

          final students = snapshot.data ?? [];
          if (students.isEmpty) {
            return const Center(child: Text('Belum ada data student.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: students.length,
            separatorBuilder: (_, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final student = students[index];
              return Card(
                child: ListTile(
                  title: Text(student.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Email: ${student.email}'),
                      Text('Class: ${student.studentClass}'),
                      Text('Age: ${student.age}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const StudentFormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
