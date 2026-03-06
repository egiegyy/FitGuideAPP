import 'package:fitguide/view/exercise/CloseGripCP.dart';
import 'package:fitguide/view/exercise/chestPress.dart';
import 'package:fitguide/view/exercise/closeGripLP.dart';
import 'package:fitguide/view/exercise/legPress.dart';
import 'package:fitguide/view/exercise/legPressCalfRaise.dart';
import 'package:fitguide/view/exercise/wideGripLP.dart';

class ExerciseItem {
  final String name;
  final String image;
  final dynamic page;

  ExerciseItem({required this.name, required this.image, required this.page});
}

final List<ExerciseItem> allExercises = [
  ExerciseItem(
    name: "Chest Press",
    image: "assets/images/Chest Press.png",
    page: const ChestPressPage(),
  ),

  ExerciseItem(
    name: "Close Grip Chest Press",
    image: "assets/images/Close Grip Chest Press.png",
    page: const CloseGripCPPage(),
  ),

  ExerciseItem(
    name: "Wide Grip Lat Pulldown",
    image: "assets/images/Lat Pulldown.png",
    page: const WideGripLatPulldownPage(),
  ),

  ExerciseItem(
    name: "Close Grip Lat Pulldown",
    image: "assets/images/Close Grip Lat Pulldown.png",
    page: const CloseGripLatPulldownPage(),
  ),

  ExerciseItem(
    name: "Leg Press",
    image: "assets/images/Leg Press.png",
    page: const LegPressPage(),
  ),

  ExerciseItem(
    name: "Leg Press Calf Raise",
    image: "assets/images/Leg Press Calf Raise.png",
    page: const LegPressCalfRaisePage(),
  ),
];
