import 'package:fitguide/pages/workout/exercise/chest_press.dart';
import 'package:fitguide/pages/workout/exercise/close_grip_chest_press.dart';
import 'package:fitguide/pages/workout/exercise/close_grip_lat_pulldown.dart';
import 'package:fitguide/pages/workout/exercise/leg_press.dart';
import 'package:fitguide/pages/workout/exercise/leg_press_calf_raise.dart';
import 'package:fitguide/pages/workout/exercise/lat_pulldown.dart';

class ExerciseItem {
  final String name;
  final String image;
  final dynamic page;

  ExerciseItem({required this.name, required this.image, required this.page});
}

final List<ExerciseItem> allExercises = [
  ExerciseItem(
    name: "Chest Press",
    image: "assets/images/exercises/push/chest_press.png",
    page: const ChestPressPage(),
  ),

  ExerciseItem(
    name: "Close Grip Chest Press",
    image: "assets/images/exercises/push/close_grip_chest_press.png",
    page: const CloseGripCPPage(),
  ),

  ExerciseItem(
    name: "Wide Grip Lat Pulldown",
    image: "assets/images/exercises/pull/lat_pulldown.png",
    page: const WideGripLatPulldownPage(),
  ),

  ExerciseItem(
    name: "Close Grip Lat Pulldown",
    image: "assets/images/exercises/pull/close_grip_lat_pulldown.png",
    page: const CloseGripLatPulldownPage(),
  ),

  ExerciseItem(
    name: "Leg Press",
    image: "assets/images/exercises/leg/leg_press.png",
    page: const LegPressPage(),
  ),

  ExerciseItem(
    name: "Leg Press Calf Raise",
    image: "assets/images/exercises/leg/leg_press_calf_raise.png",
    page: const LegPressCalfRaisePage(),
  ),
];
