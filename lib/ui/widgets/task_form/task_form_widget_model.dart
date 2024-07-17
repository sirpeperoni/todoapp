import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_app/domain/data_provider/box_manager.dart';
import 'package:to_do_app/domain/entity/task.dart';



class TaskFormWidgetModel{
  int groupKey;
  var taskText = '';
  TaskFormWidgetModel({required this.groupKey});
  void saveTask(BuildContext context) async {
    if(taskText.isEmpty) return;

    final task = Task(text: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);
    await box.add(task);
    await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
  }
}


class TaskFormWidgetModelProvider extends InheritedWidget {
  final TaskFormWidgetModel model;
  const TaskFormWidgetModelProvider({super.key, required this.child, required this.model}) : super(child: child);

  final Widget child;

  static TaskFormWidgetModelProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvider>();
  }

  static TaskFormWidgetModelProvider? watch(BuildContext context){
    return context
        .dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvider>();
  }

  static TaskFormWidgetModelProvider? read(BuildContext context){
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetModelProvider>()
        ?.widget;  
    return widget is TaskFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormWidgetModelProvider oldWidget) {
    return false;
  }
}