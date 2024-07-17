import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/ui/widgets/groups/groups_widget_model.dart';

class GroupWidget extends StatefulWidget {
  const GroupWidget({super.key});

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {

  final _model = GroupsWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(child: const _GroupWidgetBody(), model: _model,);
  }

  @override
  Future<void> dispose() async {
    await _model.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

class _GroupWidgetBody extends StatelessWidget {
  const _GroupWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Группы", style: TextStyle(color: Colors.white, )),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(75, 149, 237, 1),
        iconTheme: IconThemeData(color: Colors.white)
      ),
      body: const _GroupListWidget(),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add), 
      onPressed: () {GroupsWidgetModelProvider
        .read(context)?.model.showForm(context);
      },
      backgroundColor: Color.fromRGBO(75, 149, 237, 1),
      foregroundColor: Colors.white
      ,),
    );
  }
}



class _GroupListWidget extends StatelessWidget {
  const _GroupListWidget();

  @override
  Widget build(BuildContext context) {
    final groupsCount = GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemBuilder:(BuildContext context, int index){
        return _GruoListRowWidget(indexInList: index,);
      }, 
      separatorBuilder: (BuildContext context, int index){
        return const Divider(height: 1,);
      }, 
      itemCount: groupsCount);
  }
}

class _GruoListRowWidget extends StatelessWidget {
  const _GruoListRowWidget({required this.indexInList});
  final int indexInList;
  @override
  Widget build(BuildContext context) {
    final model = GroupsWidgetModelProvider.read(context)!.model;
    final group = model.groups[indexInList];
    return Slidable(
              endActionPane:  ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) { model.deleteGroup(indexInList);},
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(group.name),
          trailing: const Icon(Icons.more_vert),
          onTap: () {model.showTasks(context, indexInList);},
        ),
      ),
    );
  }
}