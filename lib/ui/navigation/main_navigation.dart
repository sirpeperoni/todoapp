import 'package:flutter/material.dart';
import 'package:to_do_app/ui/widgets/group_form/group_form_widget.dart';
import 'package:to_do_app/ui/widgets/groups/groups_widget.dart';
import 'package:to_do_app/ui/widgets/task_form/task_form_widget.dart';
import 'package:to_do_app/ui/widgets/tasks/tasks_widget.dart';

abstract class MainNavigationRouteNames{
  static const groups = '/groups';
  static const groupsForm = '/groupForm';
  static const tasks = '/tasks';
  static const tasksForm = '/tasks/form ';
}

class MainNavigation{
  final initialRoute = MainNavigationRouteNames.groups;
  final routes = <String, Widget Function(BuildContext)>{
        MainNavigationRouteNames.groups:(context) => const GroupWidget(),
        MainNavigationRouteNames.groupsForm:(context) => const GroupFormWidget(),
      };
  
  Route<Object> onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case MainNavigationRouteNames.tasks:
        final configuration = settings.arguments as TasksWidgetConfiguration;
        return MaterialPageRoute(builder: (context) => TasksWidget(configuration: configuration));
      case MainNavigationRouteNames.tasksForm:
        final groupKey = settings.arguments as int;
          return MaterialPageRoute(builder: (context) => TaskFormWidget(groupKey: groupKey));
      default:
        const widget = Text("Navigation Error!");
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}