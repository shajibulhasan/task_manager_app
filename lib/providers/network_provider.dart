import 'package:flutter/cupertino.dart';
import 'package:task_management_app/core/enums/api_state.dart';
import 'package:task_management_app/data/models/user_model.dart';

import '../data/servies/api_caller.dart';
import '../data/utils/urls.dart';

class NetworkProvider extends ChangeNotifier {
  ApiState _loginState = ApiState.initial;
  ApiState get loginState => _loginState;
  ApiState _registrationState = ApiState.initial;
  ApiState get registrationState => _registrationState;
  ApiState _profileUpdateState = ApiState.initial;
  ApiState get profileUpdateState => _profileUpdateState;

  String ? _errorMessage;
  String ? get errorMessage => _errorMessage;

  Future<Map <String, dynamic>?> login({
    required String email,
    required String password,
  }) async {

    Map<String, dynamic> signUpData = {
      'email': email,
      'password': password,
    };

    final ApiResponse response = await ApiCaller.postResponse(
      url: Urls.loginUrl,
      body: signUpData,
    );

    if(response.isSuccess){
      _errorMessage = null;
      _loginState = ApiState.success;
      notifyListeners();
      return {
        'user' : UserModel.fromJson(response.body['data']),
        'token' : response.body['access_token'],
      };
    } else {
      _errorMessage = response.errorMessage ?? 'An unexpected error occurred';
      _loginState = ApiState.error;
      notifyListeners();
      return null;
    }
  }



  Future<Map <String, dynamic>?> register({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {

    _registrationState = ApiState.loading;
    _errorMessage = null;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'password': password,
    };

    final ApiResponse response = await ApiCaller.postResponse(
      url: Urls.registrationUrl,
      body: requestBody,
    );

    if(response.isSuccess){
      _errorMessage = null;
      _registrationState = ApiState.success;
      notifyListeners();
      return response.body;
    } else {
      _errorMessage = response.errorMessage ?? 'Registration failed';
      _registrationState = ApiState.error;
      notifyListeners();
      return null;
    }
  }
}