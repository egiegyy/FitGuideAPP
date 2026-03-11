import 'package:flutter/material.dart';

class LegPressCalfRaisePage extends StatefulWidget {
  const LegPressCalfRaisePage({super.key});

  @override
  State<LegPressCalfRaisePage> createState() => _LegPressCalfRaisePageState();
}

class _LegPressCalfRaisePageState extends State<LegPressCalfRaisePage> {
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
                  "assets/images/Leg Press Calf Raise.png",
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              /// TITLE
              Text(
                "Leg Press Calf Raise",
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
                    _InfoRow(label: "Alat", value: "Leg Press Machine"),
                    SizedBox(height: 10),
                    _InfoRow(label: "Kategori", value: "Legs"),
                    SizedBox(height: 10),
                    _InfoRow(label: "Level", value: "Intermediate"),
                    SizedBox(height: 10),
                    _InfoRow(
                      label: "Repetisi",
                      value: "3–4 set × 12–15 repetisi",
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
                  "Leg press calf raise adalah variasi latihan betis menggunakan mesin leg press. Gerakan ini fokus pada otot gastrocnemius dan soleus yang berperan dalam kekuatan dan stabilitas pergelangan kaki.",
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
                      "Duduk di mesin leg press dan letakkan bagian depan kaki di platform.",
                    ),
                    _StepText(
                      "Pastikan tumit berada sedikit di luar platform agar dapat bergerak bebas.",
                    ),
                    _StepText(
                      "Dorong platform menggunakan ujung kaki hingga tumit terangkat.",
                    ),
                    _StepText(
                      "Rasakan kontraksi otot betis di bagian atas gerakan.",
                    ),
                    _StepText(
                      "Turunkan tumit perlahan sampai otot betis terasa teregang.",
                    ),
                    _StepText(
                      "Ulangi gerakan dengan tempo yang stabil dan terkontrol.",
                    ),
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
