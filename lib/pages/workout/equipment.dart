import 'package:fitguide/pages/workout/machine/chest_press_machine.dart';
import 'package:fitguide/pages/workout/machine/lat_pulldown_machine.dart';
import 'package:fitguide/pages/workout/machine/leg_press_machine.dart';
import 'package:flutter/material.dart';

class Equipment extends StatefulWidget {
  const Equipment({super.key});

  @override
  State<Equipment> createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> {
  final List<String> kategoriLatihan = [
    "Chest Press",
    "Lat Pulldown",
    "Leg Press",
  ];

  final List<Widget> equipmentPages = const [
    ChestPressMachine(),
    LatPulldownMachine(),
    LegPressMachine(),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),

      child: ListView.builder(
        itemCount: kategoriLatihan.length,
        physics: const BouncingScrollPhysics(),

        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),

            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              height: 95,

              decoration: BoxDecoration(
                color: Colors.white.withAlpha(13),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white24),
              ),

              child: ListTile(
                contentPadding: EdgeInsets.zero,

                leading: Container(
                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),

                  child: const Icon(
                    Icons.fitness_center,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                title: Text(
                  kategoriLatihan[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => equipmentPages[index],
                      ),
                    );
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: const Text(
                      "More",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
