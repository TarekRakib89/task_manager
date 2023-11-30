import 'package:task_manager_assign/data/models/task_count.dart';

class TaskCountSummaryListModel {
  String? status;
  List<TaskCount>? taskcountList;

  TaskCountSummaryListModel({this.status, this.taskcountList});

  TaskCountSummaryListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskcountList = <TaskCount>[];
      json['data'].forEach((v) {
        taskcountList!.add(TaskCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskcountList != null) {
      data['data'] = taskcountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
