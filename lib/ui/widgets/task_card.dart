import 'package:flutter/material.dart';
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text("This is task Title"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("This is task Description"),
              SizedBox(height: 5),
              Text("Date: 16-12-2025"),
              Row(
                children: [
                  Chip(
                    label: Text("New"),
                    backgroundColor: Colors.blue.shade400,
                    labelStyle: TextStyle(color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),

                  ),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.edit_note_outlined, color: Colors.green,)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}