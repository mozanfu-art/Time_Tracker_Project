class TimeEntry {
  final String id;
  final String projectId;
  final String project;
  final String task;
  final DateTime date;
  final double hours;
  final String note;

  TimeEntry({
    required this.id,
    required this.projectId,
    required this.project,
    required this.task,
    required this.date,
    required this.hours,
    required this.note,
  });

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      projectId: json['projectId'],
      project: json['project'],
      task: json['task'],
      date: DateTime.parse(json['date']),
      hours: json['hours'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'project': project,
      'task': task,
      'date': date.toIso8601String(),
      'hours': hours,
      'note': note,
    };
  }
}
