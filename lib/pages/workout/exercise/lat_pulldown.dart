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
          ),
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
                    color: Colors.white.withValues(alpha: 0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      "assets/images/animations/lat_pulldown_animation.gif",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// TITLE
                const Text(
                  "Wide Grip Lat Pulldown",
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
                    color: Colors.white.withValues(alpha: 0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    children: [
                      _InfoRow(
                        label: "Equipment",
                        value: "Lat Pulldown Machine",
                      ),
                      SizedBox(height: 10),
                      _InfoRow(
                        label: "Category",
                        value: "Pull / Upper / Full Body",
                      ),
                      SizedBox(height: 10),
                      _InfoRow(label: "Level", value: "Beginner"),
                      SizedBox(height: 10),
                      _InfoRow(
                        label: "Repetitions",
                        value: "3 sets × 10–12 reps",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                /// DESCRIPTION
                const Text(
                  "Description",
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
                    color: Colors.white.withValues(alpha: 0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Text(
                    "The wide grip lat pulldown targets the back muscles, especially the latissimus dorsi, while also engaging the shoulders and biceps as supporting muscles. This movement mimics the pull-up pattern but with adjustable resistance, making it suitable for beginners.",
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
                  "How to Use",
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
                    color: Colors.white.withValues(alpha: 0.05),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    children: [
                      _StepText(
                        "Sit on the lat pulldown machine and secure your thighs under the pads to prevent your body from lifting.",
                      ),
                      _StepText(
                        "Grip the bar with your hands wider than shoulder width.",
                      ),
                      _StepText(
                        "Pull the bar down toward your upper chest while keeping your chest open and your back upright.",
                      ),
                      _StepText(
                        "Focus on pulling with your back muscles rather than just your arms.",
                      ),
                      _StepText(
                        "Pause briefly when the bar is close to your chest.",
                      ),
                      _StepText(
                        "Slowly release the bar back to the starting position with control.",
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
