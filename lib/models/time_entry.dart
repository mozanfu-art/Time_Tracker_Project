class TimeEntry {
  final String id;
  final String projectId;
  final String taskId;
  final String project; // snapshot name
  final String task;    // snapshot name
  final DateTime date;
  final double hours;
  final String note;

  TimeEntry({
    required this.id,
    required this.projectId,
    required this.taskId,
    required this.project,
    required this.task,
    required this.date,
    required this.hours,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'taskId': taskId,
      'project': project,
      'task': task,
      'date': date.toIso8601String(),
      'hours': hours,
      'note': note,
    };
  }

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      taskId: json['taskId'] as String,
      project: json['project'] as String,
      task: json['task'] as String,
      date: DateTime.parse(json['date'] as String),
      hours: (json['hours'] as num).toDouble(),
      note: json['note'] as String,
    );
  }
}