import 'package:flutter/material.dart';

class WideGripLatPulldownPage extends StatefulWidget {
  const WideGripLatPulldownPage({super.key});

  @override
  State<WideGripLatPulldownPage> createState() => _WideGripWideGripLPState();
}

class _WideGripWideGripLPState extends State<WideGripLatPulldownPage> {
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
                  "assets/images/animation/lat_pulldown_animation.gif",
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              /// TITLE
              Text(
                "Wide Grip Lat Pulldown",
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
                    _InfoRow(label: "Alat", value: "Lat Pulldown Machine"),
                    SizedBox(height: 10),
                    _InfoRow(
                      label: "Kategori",
                      value: "Pull / Upper / Full Body",
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
                  "Wide grip lat pulldown melatih otot punggung terutama latissimus dorsi, serta melibatkan otot bahu dan biceps sebagai otot pendukung. Gerakan ini meniru pola pull-up tetapi dengan beban yang dapat diatur sehingga cocok untuk pemula.",
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
                      "Duduk di mesin lat pulldown dan pastikan paha terkunci dengan bantalan agar tubuh tidak terangkat.",
                    ),
                    _StepText(
                      "Pegang bar dengan posisi tangan lebih lebar dari bahu.",
                    ),
                    _StepText(
                      "Tarik bar ke bawah menuju dada bagian atas sambil menjaga dada terbuka dan punggung tetap tegak.",
                    ),
                    _StepText(
                      "Fokus menarik dengan otot punggung, bukan hanya dengan tangan.",
                    ),
                    _StepText("Tahan sebentar ketika bar mendekati dada."),
                    _StepText(
                      "Lepaskan bar perlahan kembali ke posisi awal dengan kontrol.",
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
