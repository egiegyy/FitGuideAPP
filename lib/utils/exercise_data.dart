import 'package:fitguide/model/exercise.dart';

class ExerciseData {
  static const chestPress = Exercise(
    name: "Chest Press",
    image: "assets/images/animations/chest_press_animation.gif",
    equipment: "Chest Press Machine",
    category: "Push / Upper / Full Body",
    level: "Beginner",
    reps: "3 sets × 10–12 reps",
    description:
        "The chest press is a fundamental exercise used to train the chest (pectoral), front shoulder (anterior deltoid), and triceps muscles. This machine provides stability, making it ideal for beginners who want to learn pushing movement patterns without needing to balance weights like with a barbell or dumbbell.",
    steps: [
      "Sit on the chest press machine and adjust the seat height so that the handles are aligned with the middle of your chest.",
      "Keep your back and head against the backrest to maintain a stable posture.",
      "Grip the handles with both hands, then push forward until your arms are nearly straight.",
      "Avoid locking your elbows completely to keep your joints safe.",
      "Slowly return the handles to the starting position while maintaining control.",
      "Repeat the movement with a steady and controlled tempo.",
    ],
  );

  static const closeGripChestPress = Exercise(
    name: "Close Grip Chest Press",
    image: "assets/images/exercises/push/close_grip_chest_press.png",
    equipment: "Chest Press Machine",
    category: "Push",
    level: "Intermediate",
    reps: "3–4 sets × 8–12 reps",
    description:
        "The close grip chest press variation uses a narrower hand position to increase focus on the triceps and inner chest muscles. This movement is suitable for users who are already familiar with the standard chest press and want to add variation to their pushing workouts.",
    steps: [
      "Sit on the chest press machine with your back firmly against the backrest.",
      "Hold the handles with a grip narrower than shoulder width.",
      "Push the handles forward while keeping your elbows close to your body.",
      "Pause briefly when your arms are nearly straight to maximize muscle contraction.",
      "Slowly return the handles to the starting position with control.",
      "Maintain steady breathing throughout the movement.",
    ],
  );

  static const wideGripLatPulldown = Exercise(
    name: "Wide Grip Lat Pulldown",
    image: "assets/images/animations/lat_pulldown_animation.gif",
    equipment: "Lat Pulldown Machine",
    category: "Pull / Upper / Full Body",
    level: "Beginner",
    reps: "3 sets × 10–12 reps",
    description:
        "The wide grip lat pulldown targets the back muscles, especially the latissimus dorsi, while also engaging the shoulders and biceps as supporting muscles. This movement mimics the pull-up pattern but with adjustable resistance, making it suitable for beginners.",
    steps: [
      "Sit on the lat pulldown machine and secure your thighs under the pads to prevent your body from lifting.",
      "Grip the bar with your hands wider than shoulder width.",
      "Pull the bar down toward your upper chest while keeping your chest open and your back upright.",
      "Focus on pulling with your back muscles rather than just your arms.",
      "Pause briefly when the bar is close to your chest.",
      "Slowly release the bar back to the starting position with control.",
    ],
  );

  static const closeGripLatPulldown = Exercise(
    name: "Close Grip Lat Pulldown",
    image: "assets/images/exercises/pull/close_grip_lat_pulldown.png",
    equipment: "Lat Pulldown Machine",
    category: "Pull",
    level: "Intermediate",
    reps: "3–4 sets × 8–12 reps",
    description:
        "The close grip lat pulldown uses a narrower grip to place greater emphasis on the middle back and biceps. This variation also increases the range of motion, helping improve muscle control in the back.",
    steps: [
      "Sit on the lat pulldown machine with your thighs secured under the pads.",
      "Hold the handle with a narrower grip or use a close-grip attachment.",
      "Pull the handle down toward your chest while keeping your back upright.",
      "Ensure your elbows move downward and slightly backward.",
      "Pause briefly when the handle is near your chest for maximum contraction.",
      "Slowly return the handle to the starting position.",
    ],
  );

  static const legPress = Exercise(
    name: "Leg Press",
    image: "assets/images/animations/leg_press_animation.gif",
    equipment: "Leg Press Machine",
    category: "Legs / Lower / Full Body",
    level: "Beginner",
    reps: "3 sets × 10–15 reps",
    description:
        "The leg press is a fundamental exercise for training the quadriceps, hamstrings, and glutes. This machine provides high stability, allowing users—especially beginners—to lift heavier loads compared to squats.",
    steps: [
      "Sit or lie on the leg press machine with your back firmly against the backrest.",
      "Place both feet on the platform at shoulder-width distance.",
      "Release the safety locks if available.",
      "Push the platform with your legs until your knees are almost fully extended.",
      "Do not lock your knees to protect your joints.",
      "Lower the platform slowly until your knees form approximately a 90-degree angle.",
    ],
  );

  static const legPressCalfRaise = Exercise(
    name: "Leg Press Calf Raise",
    image: "assets/images/exercises/leg/leg_press_calf_raise.png",
    equipment: "Leg Press Machine",
    category: "Legs",
    level: "Intermediate",
    reps: "3–4 sets × 12–15 reps",
    description:
        "The leg press calf raise is a calf exercise variation performed using a leg press machine. This movement targets the gastrocnemius and soleus muscles, which play an important role in ankle strength and stability.",
    steps: [
      "Sit on the leg press machine and place the balls of your feet on the platform.",
      "Ensure your heels are slightly off the platform to allow full movement.",
      "Push the platform using your toes until your heels are lifted.",
      "Feel the contraction in your calf muscles at the top of the movement.",
      "Lower your heels slowly until you feel a stretch in your calves.",
      "Repeat the movement with a steady and controlled tempo.",
    ],
  );

  static const all = [
    chestPress,
    closeGripChestPress,
    wideGripLatPulldown,
    closeGripLatPulldown,
    legPress,
    legPressCalfRaise,
  ];
}
