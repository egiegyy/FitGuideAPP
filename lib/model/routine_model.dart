class RoutineModel {
  final String day;
  final String description;

  RoutineModel({required this.day, required this.description});

  RoutineModel copyWith({String? day, String? description}) {
    return RoutineModel(
      day: day ?? this.day,
      description: description ?? this.description,
    );
  }

  factory RoutineModel.fromJson(Map<String, dynamic> json) {
    return RoutineModel(
      day: json['day'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'day': day, 'description': description};
  }
}
