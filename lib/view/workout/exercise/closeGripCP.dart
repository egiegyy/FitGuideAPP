import 'package:flutter/material.dart';

class CloseGripCPPage extends StatefulWidget {
  const CloseGripCPPage({super.key});

  @override
  State<CloseGripCPPage> createState() => _CloseGripCPPageState();
}

class _CloseGripCPPageState extends State<CloseGripCPPage> {
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
                      "assets/images/Close Grip Chest Press.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// TITLE
                const Text(
                  "Close Grip Chest Press",
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
                      _InfoRow(label: "Alat", value: "Chest Press Machine"),
                      SizedBox(height: 10),
                      _InfoRow(label: "Kategori", value: "Push"),
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
                    "Variasi close grip chest press menggunakan posisi tangan yang lebih sempit untuk meningkatkan fokus pada otot triceps dan bagian dalam dada. Gerakan ini cocok untuk pengguna yang sudah terbiasa dengan chest press standar dan ingin menambah variasi latihan dorongan.",
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
                        "Duduk di mesin chest press dengan posisi punggung menempel pada sandaran.",
                      ),
                      _StepText(
                        "Pegang handle dengan posisi tangan lebih sempit dari lebar bahu.",
                      ),
                      _StepText(
                        "Dorong handle ke depan sambil menjaga siku tetap dekat dengan tubuh.",
                      ),
                      _StepText(
                        "Tahan sebentar saat lengan hampir lurus untuk meningkatkan kontraksi otot.",
                      ),
                      _StepText(
                        "Turunkan handle kembali secara perlahan ke posisi awal dengan kontrol.",
                      ),
                      _StepText(
                        "Jaga pernapasan tetap stabil selama melakukan gerakan.",
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