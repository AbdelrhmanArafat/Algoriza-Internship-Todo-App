import 'dart:convert';

class TasksData {
  final int id;
  final String title;
  final String date;
  final String startTime;
  final String endTime;

  TasksData({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  TasksData copyWith({
    int? id,
    String? title,
    String? date,
    String? startTime,
    String? endTime,
  }) {
    return TasksData(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory TasksData.fromMap(Map<String, dynamic> map) {
    return TasksData(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TasksData.fromJson(String source) =>
      TasksData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TasksData(id: $id, title: $title, date: $date, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TasksData &&
        other.id == id &&
        other.title == title &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        date.hashCode ^
        startTime.hashCode ^
        endTime.hashCode;
  }
}
