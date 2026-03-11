import 'package:fitguide/view/machine/chestPressMachine.dart';
import 'package:fitguide/view/machine/latPulldownMachine.dart';
import 'package:fitguide/view/machine/legPressMachine.dart';
import 'package:flutter/material.dart';

class Equipment extends StatefulWidget {
  const Equipment({super.key});

  @override
  State<Equipment> createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> {
  final List<String> kategoriLatihan = [
    "Chest Press Machine",
    "Lat Pulldown Machine",
    "Leg Press Machine",
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
            padding: const EdgeInsets.all(5),

            child: Container(
              padding: EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(80),
                borderRadius: BorderRadius.circular(10),
              ),

              child: ListTile(
                leading: Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                  size: 40
                  
                  ,
                ),

                title: Text(
                  kategoriLatihan[index],
                  style: const TextStyle(
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
                        builder: (context) => equipmentPages[index],
                      ),
                    );
                  },

                  child: const Text(
                    "More",
                    style: TextStyle(
                      color: Color(0xff6C9E56),
                      fontWeight: FontWeight.bold,
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
