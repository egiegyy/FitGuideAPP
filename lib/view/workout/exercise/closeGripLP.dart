import 'package:flutter/material.dart';

class CloseGripLatPulldownPage extends StatefulWidget {
  const CloseGripLatPulldownPage({super.key});

  @override
  State<CloseGripLatPulldownPage> createState() =>
      _CloseGripLatPulldownPageState();
}

class _CloseGripLatPulldownPageState extends State<CloseGripLatPulldownPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Workout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search_rounded, color: Colors.white, size: 28),
          )
        ],
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

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// IMAGE
                Container(
                  width: double.infinity,
                  height: 260,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      "assets/images/Close Grip Lat Pulldown.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// TITLE
                const Text(
                  "Close Grip Lat Pulldown",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                /// INFO
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    children: [
                      _InfoRow(label: "Alat", value: "Lat Pulldown Machine"),
                      SizedBox(height: 10),
                      _InfoRow(label: "Kategori", value: "Pull"),
                      SizedBox(height: 10),
                      _InfoRow(label: "Level", value: "Intermediate"),
                      SizedBox(height: 10),
                      _InfoRow(
                        label: "Repetisi",
                        value: "3–4 set × 8–12 repetisi",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                /// DESCRIPTION
                const Text(
                  "Deskripsi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Text(
                    "Close grip lat pulldown menggunakan pegangan yang lebih sempit untuk memberikan fokus lebih pada bagian tengah punggung dan biceps. Variasi ini juga meningkatkan rentang gerakan sehingga membantu memperkuat kontrol otot punggung.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// HOW TO USE
                const Text(
                  "Cara penggunaan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    children: [
                      _StepText(
                        "Duduk di mesin lat pulldown dengan paha terkunci di bawah bantalan.",
                      ),
                      _StepText(
                        "Pegang handle dengan posisi tangan lebih sempit atau menggunakan pegangan khusus.",
                      ),
                      _StepText(
                        "Tarik handle ke arah dada sambil menjaga punggung tetap tegak.",
                      ),
                      _StepText(
                        "Pastikan siku bergerak ke bawah dan sedikit ke belakang.",
                      ),
                      _StepText(
                        "Tahan sebentar saat handle mendekati dada untuk kontraksi maksimal.",
                      ),
                      _StepText(
                        "Kembalikan handle perlahan ke posisi awal.",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepText extends StatelessWidget {
  final String text;

  const _StepText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}