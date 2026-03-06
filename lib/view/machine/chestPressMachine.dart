import 'package:fitguide/view/exercise/CloseGripCP.dart';
import 'package:fitguide/view/exercise/chestPress.dart';
import 'package:flutter/material.dart';

class ChestPressMachine extends StatefulWidget {
  const ChestPressMachine({super.key});

  @override
  State<ChestPressMachine> createState() => _ChestPressState();
}

class _ChestPressState extends State<ChestPressMachine> {
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
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/images/Chest Press Machine.png"),
            ),

            SizedBox(height: 20),

            Text(
              "Chest Press Machine",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(800),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Chest Press Machine adalah alat gym untuk melatih otot dada dengan gerakan mendorong beban ke depan. Latihan ini menargetkan pectoralis, serta melibatkan bahu depan dan triceps.",
                style: TextStyle(color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Exercise",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            /// CHEST PRESS
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChestPressPage(),
                  ),
                );
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("assets/images/chestPress.png"),
              ),
              title: Text(
                "Chest Press",
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
                      builder: (context) => const ChestPressPage(),
                    ),
                  );
                },
                child: const Text(
                  "see more>",
                  style: TextStyle(color: Color(0xff6C9E56)),
                ),
              ),
            ),

            SizedBox(height: 20),

            /// CLOSE GRIP CHEST PRESS
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CloseGripCPPage(),
                  ),
                );
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("assets/images/chestPress.png"),
              ),
              title: Text(
                "Close Grip Chest Press",
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
                      builder: (context) => const CloseGripCPPage(),
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
    );
  }
}
