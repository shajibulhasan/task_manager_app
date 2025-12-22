class Urls{
  static String baseUrl = 'http://35.73.30.144:2005/api/v1';
  static String registrationUrl = '$baseUrl/Registration';
  static String loginUrl = '$baseUrl/Login';
  static String createTask = '$baseUrl/createTask';
  static String taskCount = '$baseUrl/taskStatusCount';
  static String newTask = '$baseUrl/listTaskByStatus/New';
  static String completeTask = '$baseUrl/listTaskByStatus/Completed';
  static String cancelledTask = '$baseUrl/listTaskByStatus/Cancelled';
  static String progressTask = '$baseUrl/listTaskByStatus/Progress';
  static String deleteTaskUrl(String taskId) => '$baseUrl/deleteTask/$taskId';
  static String changeStatus(String taskId,String status) => '$baseUrl/updateTaskStatus/$taskId/$status';
}