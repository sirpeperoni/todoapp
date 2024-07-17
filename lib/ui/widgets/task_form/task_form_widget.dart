import 'package:flutter/material.dart';
import 'package:to_do_app/ui/widgets/task_form/task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  final int groupKey;
  const TaskFormWidget({super.key, required this.groupKey});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  late final TaskFormWidgetModel? _model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = TaskFormWidgetModel(groupKey: widget.groupKey);
  }
  //   @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   if(_model == null){
  //     final groupKey = ModalRoute.of(context)!.settings.arguments as int;
  //     _model = TaskFormWidgetModel(groupKey: groupKey);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(model: _model!, child: const _TextFormWidgetBody());
  }
}

class _TextFormWidgetBody extends StatelessWidget {
  const _TextFormWidgetBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Новая задача", style: TextStyle(color: Colors.white)),backgroundColor: Color.fromRGBO(75, 149, 237, 1),iconTheme: IconThemeData(color: Colors.white), centerTitle: true,),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _TaskNameWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => 
          TaskFormWidgetModelProvider.read(context)?.model.saveTask(context),
        child: const Icon(Icons.done),
        backgroundColor: Color.fromRGBO(75, 149, 237, 1),
        foregroundColor: Colors.white
      ),
    );
  }
}

class _TaskNameWidget extends StatelessWidget {
  const _TaskNameWidget();

  @override
  Widget build(BuildContext context) {
    final model =TaskFormWidgetModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      minLines: null,
      expands: true,
      maxLines: null,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Текст задачи'
      ),
      onChanged: (value) => model?.taskText = value,
      onEditingComplete: () => model?.saveTask(context),
    );
  }
}