import 'package:flutter/cupertino.dart';
import '../core/enums/api_state.dart';
import '../data/models/task_model.dart';
import '../data/models/task_status_count.dart';
import '../data/servies/api_caller.dart';
import '../data/utils/urls.dart';

class TaskProvider extends ChangeNotifier{
  List<TaskModel> _newTasks = [];
  List<TaskModel> _progressTasks = [];
  List<TaskModel> _completedTasks = [];
  List<TaskModel> _cancelledTasks = [];

  List<TaskStatusCountModel> _taskStatusCount = [];

  ApiState _taskListState = ApiState.initial;
  ApiState _taskCountState = ApiState.initial;

  String ? _errorMessage;

  List<TaskModel> get newTasks => _newTasks;
  List<TaskModel> get progressTasks => _progressTasks;
  List<TaskModel> get completedTasks => _completedTasks;
  List<TaskModel> get cancelledTasks => _cancelledTasks;

  List<TaskStatusCountModel> get taskStatusCount => _taskStatusCount;


  Future<void> fetchTaskStatusCount()async {
    _taskCountState = ApiState.loading;
    notifyListeners();

    final ApiResponse response =
    await ApiCaller.getRequest(url: Urls.taskCount);

    if(response.isSuccess){
      _taskStatusCount = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        _taskStatusCount.add(TaskStatusCountModel.formJson(jsonData));
      }
      _taskCountState = ApiState.success;
      _errorMessage = null;
    }else{

      _taskCountState = ApiState.error;
      _errorMessage = response.errorMessage ?? 'Failed to fetch task Count';

    }

    notifyListeners();

  }


  Future<void> fetchNewTaskByStatus(String status)async {
    _taskListState = ApiState.loading;
    notifyListeners();

    String url;

    switch(status){
      case ('New'):
        url = Urls.newTask;
        break;
      case 'Progress' :
        url = Urls.progressTask;
        break;
      case 'Completed'  :
        url = Urls.completeTask;
        break;
      case 'Cancelled'  :
        url = Urls.cancelledTask;
        break;
      default:
        url = Urls.newTask;
    }

    final ApiResponse response =
    await ApiCaller.getRequest(url: url);

    if(response.isSuccess){
      List<TaskModel> tasks = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        tasks.add(TaskModel.fromJson(jsonData));
      }
      switch(status){
        case ('New'):
          _newTasks = tasks;
          break;
        case 'Progress' :
          _progressTasks = tasks;
          break;
        case 'Completed'  :
          _completedTasks = tasks;
          break;
        case 'Cancelled'  :
          _cancelledTasks = tasks;
          break;
        default:
          _newTasks = tasks;
      }


      _taskListState = ApiState.success;
      _errorMessage = null;
    }else{

      _taskCountState = ApiState.error;
      _errorMessage = response.errorMessage ?? 'Failed to fetch task';

    }

    notifyListeners();

  }

}