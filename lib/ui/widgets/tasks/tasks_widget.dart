import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/ui/widgets/tasks/tasks_widget_model.dart';

class TasksWidgetConfiguration{
  final int groupKey;
  final String title;

  TasksWidgetConfiguration(this.groupKey, this.title);
}


class TasksWidget extends StatefulWidget {
  final TasksWidgetConfiguration configuration;
  const TasksWidget({super.key, required this.configuration});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late final TasksWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TasksWidgetModel(configuration: widget.configuration);
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   if(_model == null){
  //     final groupKey = ModalRoute.of(context)!.settings.arguments as int;
  //     _model = TasksWidgetModel(groupKey: groupKey);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return TasksWidgetModelProvider(model: _model!, child: const TasksWidgetBody());
  }
  @override
  void dispose() async {
    await _model.dispose();
    super.dispose();
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final title = model?.configuration.title ?? 'Задачи';
    return Scaffold(
      appBar: AppBar(title: Text(title, style: TextStyle(color: Colors.white)),backgroundColor: Color.fromRGBO(75, 149, 237, 1),iconTheme: IconThemeData(color: Colors.white), centerTitle: true,),
      floatingActionButton: FloatingActionButton(onPressed: () {model?.showForm(context);}, child: Icon(Icons.add),      backgroundColor: Color.fromRGBO(75, 149, 237, 1),
      foregroundColor: Colors.white),
      body: const _TasksListWidget(),
    );
  }
}

class _TasksListWidget extends StatelessWidget {
  const _TasksListWidget();

  @override
  Widget build(BuildContext context) {
    final groupsCount = TasksWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
      itemBuilder:(BuildContext context, int index){
        return _TaskListRowWidget(indexInList: index,);
      }, 
      separatorBuilder: (BuildContext context, int index){
        return const Divider(height: 1,);
      }, 
      itemCount: groupsCount);
  }
}

class _TaskListRowWidget extends StatelessWidget {
  const _TaskListRowWidget({required this.indexInList});
  final int indexInList;
  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.read(context)!.model;
    final task = model.tasks[indexInList];

    final icon = task.isDone ? Icons.done : null;
    final lineThrough = task.isDone ? const TextStyle(decoration: TextDecoration.lineThrough) : null;
    return Slidable(
              endActionPane:  ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) { model.deleteTask(indexInList);},
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: icon,
                    label: 'Delete',
                  ),
                ],
              ),
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(task.text, style: lineThrough,),
          trailing: Icon(icon),
          onTap: () {model.doneToggle(indexInList);},
        ),
      ),
    );
  }
}