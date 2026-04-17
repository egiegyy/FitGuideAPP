class RoutineModel {
  final int? id;
  final String day;
  final String exercise;

  RoutineModel({this.id, required this.day, required this.exercise});

  Map<String, dynamic> toMap() {
    return {'id': id, 'day': day, 'exercise': exercise};
  }

  factory RoutineModel.fromMap(Map<String, dynamic> map) {
    return RoutineModel(
      id: map['id'],
      day: map['day'],
      exercise: map['exercise'],
    );
  }
}
