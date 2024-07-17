import 'package:flutter/material.dart';
import 'package:to_do_app/ui/widgets/group_form/group_form_widget_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({super.key});

  @override
  State<GroupFormWidget> createState() => _GroupFormWidgetState();
}

class _GroupFormWidgetState extends State<GroupFormWidget> {
  final _model = GroupFormWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvider(model: _model,child: const _GroupFormWidgetBody(),);
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Новая группа",
          style: TextStyle(color: Colors.white)), 
          backgroundColor: const Color.fromRGBO(75, 149, 237, 1),
          iconTheme: const IconThemeData(color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _GroupNameWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => 
          GroupFormWidgetModelProvider.read(context)?.model.saveGroup(context),
              backgroundColor: const Color.fromRGBO(75, 149, 237, 1),
      foregroundColor: Colors.white,
        child: const Icon(Icons.done)
      ),
    );
  }
}

class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget();

  @override
  Widget build(BuildContext context) {
    final model =GroupFormWidgetModelProvider.watch(context)?.model;
    return TextField(
      decoration: InputDecoration(
        border:const  OutlineInputBorder(),
        hintText: 'Имя группы',
        errorText: model?.errorText,
      ),
      onChanged: (value) => model?.groupName = value,
      onEditingComplete: () => model?.saveGroup(context),
    );
  }
}