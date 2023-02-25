import 'dart:convert';
import 'package:auto_assistant_cli/models/hypermedialink.dart';

class Links {
  HypermediaLink delete;
  HypermediaLink detail;
  HypermediaLink taskList;
  HypermediaLink updateOne;

  Links(this.delete, this.detail, this.taskList, this.updateOne);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'delete': delete.toMap(),
      'detail': detail.toMap(),
      'taskList': taskList.toMap(),
      'updateOne': updateOne.toMap(),
    };
  }

  factory Links.fromMap(Map<String, dynamic> map) {
    return Links(
      HypermediaLink.fromMap(map['delete'] as Map<String, dynamic>),
      HypermediaLink.fromMap(map['detail'] as Map<String, dynamic>),
      HypermediaLink.fromMap(map['taskList'] as Map<String, dynamic>),
      HypermediaLink.fromMap(map['updateOne'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Links.fromJson(String source) =>
      Links.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Links(delete: $delete, detail: $detail, taskList: $taskList, updateOne: $updateOne)';
  }
}
