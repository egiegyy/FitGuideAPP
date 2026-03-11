import 'package:flutter/material.dart';

class ChestPressPage extends StatefulWidget {
  const ChestPressPage({super.key});

  @override
  State<ChestPressPage> createState() => _ChestPressPageState();
}

class _ChestPressPageState extends State<ChestPressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Workout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [Icon(Icons.search_rounded, color: Colors.white, size: 30)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              Container(
                width: double.infinity,
                height: 260,
                color: const Color(0xffF4F6F8),
                child: Image.asset(
                  "assets/images/Chest Press.png",
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              /// TITLE
              Text(
                "Chest Press",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /// INFO
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(800),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Column(
                  children: [
                    _InfoRow(label: "Alat", value: "Chest Press Machine"),
                    SizedBox(height: 10),
                    _InfoRow(
                      label: "Kategori",
                      value: "Push / Upper / Full Body",
                    ),
                    SizedBox(height: 10),
                    _InfoRow(label: "Level", value: "Beginner"),
                    SizedBox(height: 10),
                    _InfoRow(
                      label: "Repetisi",
                      value: "3 set × 10–12 repetisi",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// DESCRIPTION
              Text(
                "Deskripsi",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(800),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "Chest press adalah latihan dasar untuk melatih otot dada (pectoralis), bahu depan, dan triceps. Mesin ini membantu menjaga stabilitas sehingga cocok untuk pemula yang ingin belajar pola gerakan mendorong tanpa harus menyeimbangkan beban seperti pada barbell atau dumbbell.",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// HOW TO USE
              Text(
                "Cara penggunaan",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(800),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: const [
                    _StepText(
                      "Duduk di mesin chest press dan atur tinggi kursi sehingga pegangan berada sejajar dengan bagian tengah dada.",
                    ),
                    _StepText(
                      "Tempelkan punggung dan kepala pada sandaran untuk menjaga postur tetap stabil.",
                    ),
                    _StepText(
                      "Pegang handle dengan kedua tangan, lalu dorong ke depan sampai lengan hampir lurus.",
                    ),
                    _StepText(
                      "Jangan mengunci siku sepenuhnya agar sendi tetap aman.",
                    ),
                    _StepText(
                      "Kembalikan handle secara perlahan ke posisi awal sambil mengontrol gerakan.",
                    ),
                    _StepText("Ulangi gerakan dengan tempo yang stabil."),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
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
              color: Colors.white,
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
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
