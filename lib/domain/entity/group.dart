import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
class Group extends HiveObject{
  //Last used HiveField key 1
  @HiveField(0)
  String name;
  

  Group({
    required this.name
  });

}