class Task {
  String id;
  String project;
  String task;
  String assignedTo;
  String dateFrom;
  String dateTo;
  String status;

  Task({
    required this.id,
    required this.project,
    required this.task,
    required this.assignedTo,
    required this.dateFrom,
    required this.dateTo,
    required this.status,
  });

  // Factory method to create a Task object from a Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      project: map['project'],
      task: map['task'],
      assignedTo: map['assignedTo'],
      dateFrom: map['dateFrom'],
      dateTo: map['dateTo'],
      status: map['status'],
    );
  }

  // Convert the Task object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'project': project,
      'task': task,
      'assignedTo': assignedTo,
      'dateFrom': dateFrom,
      'dateTo': dateTo,
      'status': status,
    };
  }
}
