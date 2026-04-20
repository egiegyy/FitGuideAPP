import 'package:fitguide/model/exercise.dart';
import 'package:fitguide/pages/workout/exercise_detail_page.dart';
import 'package:fitguide/utils/exercise_data.dart';
import 'package:flutter/material.dart';

class ExerciseItem {
  final String image;
  final Exercise exercise;

  ExerciseItem({required this.image, required this.exercise});

  String get name => exercise.name;

  Widget get page => ExerciseDetailPage(exercise: exercise);
}

final List<ExerciseItem> allExercises = [
  ExerciseItem(
    image: "assets/images/exercises/push/chest_press.png",
    exercise: ExerciseData.chestPress,
  ),

  ExerciseItem(
    image: "assets/images/exercises/push/close_grip_chest_press.png",
    exercise: ExerciseData.closeGripChestPress,
  ),

  ExerciseItem(
    image: "assets/images/exercises/pull/lat_pulldown.png",
    exercise: ExerciseData.wideGripLatPulldown,
  ),

  ExerciseItem(
    image: "assets/images/exercises/pull/close_grip_lat_pulldown.png",
    exercise: ExerciseData.closeGripLatPulldown,
  ),

  ExerciseItem(
    image: "assets/images/exercises/leg/leg_press.png",
    exercise: ExerciseData.legPress,
  ),

  ExerciseItem(
    image: "assets/images/exercises/leg/leg_press_calf_raise.png",
    exercise: ExerciseData.legPressCalfRaise,
  ),
];
