import 'package:fitguide/view/exercise/closeGripLP.dart';
import 'package:fitguide/view/exercise/wideGripLP.dart';
import 'package:flutter/material.dart';

class LatPulldownMachine extends StatefulWidget {
  const LatPulldownMachine({super.key});

  @override
  State<LatPulldownMachine> createState() => _LatPulldownMachineState();
}

class _LatPulldownMachineState extends State<LatPulldownMachine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Workout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: const [
          Icon(Icons.search_rounded, color: Colors.white, size: 30),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset("assets/images/Lat Pulldown Machine.png"),
              ),
          
              const SizedBox(height: 10),
          
              const Text(
                "Lat Pulldown Machine",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
              const SizedBox(height: 10),
          
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(800),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "Alat gym untuk melatih otot punggung dengan gerakan menarik bar dari atas ke arah dada. Latihan ini membantu memperkuat dan membentuk punggung bagian atas. Otot utama yang dilatih adalah latissimus dorsi, dengan bantuan biceps dan bahu belakang.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
          
              const SizedBox(height: 20),
          
              const Text(
                "Exercise",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
              const SizedBox(height: 20),
          
              /// WIDE GRIP LAT PULLDOWN
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WideGripLatPulldownPage(),
                    ),
                  );
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/LatPulldownMachine.png"),
                ),
                title: const Text(
                  "Wide Grip Lat Pulldown",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WideGripLatPulldownPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "see more>",
                    style: TextStyle(color: Color(0xff6C9E56)),
                  ),
                ),
              ),
          
              const SizedBox(height: 20),
          
              /// CLOSE GRIP LAT PULLDOWN
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CloseGripLatPulldownPage(),
                    ),
                  );
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/LatPulldownMachine.png"),
                ),
                title: const Text(
                  "Close Grip Lat Pulldown",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CloseGripLatPulldownPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "see more>",
                    style: TextStyle(color: Color(0xff6C9E56)),
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
