import 'package:flutter/material.dart';

class LegPressPage extends StatefulWidget {
  const LegPressPage({super.key});

  @override
  State<LegPressPage> createState() => _LegPressPageState();
}

class _LegPressPageState extends State<LegPressPage> {
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
                  "assets/images/Leg Press.png",
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              /// TITLE
              Text(
                "Leg Press",
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
                    _InfoRow(
                      label: "Kategori",
                      value: "Legs / Lower / Full Body",
                    ),
                    SizedBox(height: 10),
                    _InfoRow(label: "Level", value: "Beginner"),
                    SizedBox(height: 10),
                    _InfoRow(
                      label: "Repetisi",
                      value: "3 set × 10–15 repetisi",
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
                  "Leg press adalah latihan dasar untuk melatih otot paha depan (quadriceps), paha belakang (hamstring), dan glutes. Mesin ini memberikan stabilitas yang tinggi sehingga memungkinkan pengguna mengangkat beban yang lebih besar dibandingkan squat bagi pemula.",
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
                      "Duduk atau berbaring pada mesin leg press dengan punggung menempel pada sandaran.",
                    ),
                    _StepText(
                      "Letakkan kedua kaki di platform dengan jarak selebar bahu.",
                    ),
                    _StepText("Lepaskan pengunci mesin jika ada."),
                    _StepText(
                      "Dorong platform dengan kaki hingga lutut hampir lurus.",
                    ),
                    _StepText(
                      "Jangan mengunci lutut untuk menjaga keamanan sendi.",
                    ),
                    _StepText(
                      "Turunkan platform perlahan sampai lutut membentuk sudut sekitar 90 derajat.",
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
