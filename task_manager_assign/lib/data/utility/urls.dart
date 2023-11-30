class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createNewTask = '$_baseUrl/createTask';
  static const String getNewTasks = '$_baseUrl/listTaskByStatus/New';
  static const String getTaskStatusCount = '$_baseUrl/taskStatusCount';
  static const String getTaskStatusCompleted =
      '$_baseUrl/listTaskByStatus/Completed';
  static const String getProgressTasks = "$_baseUrl/listTaskByStatus/Progress";
  static const String getCancelledTask = '$_baseUrl/listTaskByStatus/Cancelled';

  static String updateTaskStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';
}
