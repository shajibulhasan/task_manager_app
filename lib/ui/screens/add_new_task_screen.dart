import 'package:flutter/material.dart';
import 'package:task_management_app/data/servies/api_caller.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';
import 'package:task_management_app/ui/widgets/task_manager_app_bar.dart';

import '../../data/utils/urls.dart';
import '../widgets/snack_bar.dart';
class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: ScreenBackground(child:
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80,),
                Text("Add New Task",
                style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Task Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Title';
                    }
                    return null;
                  }
                ),
                SizedBox(height: 15,),
                TextFormField(
                  maxLines: 5,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Task Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  }
                ),
                SizedBox(height: 15,),
                FilledButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    print("Title: ${_titleController.text}");
                    print("Description: ${_descriptionController.text}");
                    addNewTask();
                  }
                }, child: Icon(Icons.arrow_forward_ios_outlined))
              ],
            ),
          ),
        ),
      )),
    );
  }
  bool _addTaskProgress = false;

  Future<void>addNewTask() async {
    _addTaskProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleController.text,
      "description": _descriptionController.text,
      "status":"New"
    };

    final ApiResponse response = await ApiCaller.postResponse(
      url: Urls.createTask,
      body: requestBody,
    );

    _addTaskProgress = false;
    setState(() {

    });

    if(response.isSuccess){
      _clearTextFields();
     showSnackBar(context, "Task Added Successfully", Colors.green);
    }else{
      showSnackBar(context, "Task Added Failed", Colors.red);
    }
  }


  _clearTextFields(){
    _titleController.clear();
    _descriptionController.clear();
  }

}
