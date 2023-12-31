import 'package:flutter/material.dart';

import 'package:task_manager_assign/data/models/task_count_summary_list_model.dart';
import 'package:task_manager_assign/data/models/task_list_model.dart';
import 'package:task_manager_assign/data/network_caller/network_caller.dart';
import 'package:task_manager_assign/data/network_caller/network_response.dart';
import 'package:task_manager_assign/data/utility/urls.dart';
import 'package:task_manager_assign/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_assign/ui/widgets/profile_summary_card.dart';
import 'package:task_manager_assign/ui/widgets/summary_card.dart';
import 'package:task_manager_assign/ui/widgets/task_item_card.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  bool getNewTaskInProgress = false;
  bool getTaskCountSummaryInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  TaskCountSummaryListModel taskCountSummaryListModel =
      TaskCountSummaryListModel();

  Future<void> getTaskCountSummaryList() async {
    getTaskCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
      getTaskCountSummaryInProgress = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTasks);
    if (response.isSuccess) {
      debugPrint("true");
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getNewTaskList();
    getTaskCountSummaryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Visibility(
                visible: getTaskCountSummaryInProgress == false,
                replacement: const LinearProgressIndicator(),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          taskCountSummaryListModel.taskcountList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return SummeryCard(
                            title: taskCountSummaryListModel
                                    .taskcountList![index].sId ??
                                '',
                            count: taskCountSummaryListModel
                                .taskcountList![index].sum
                                .toString());
                      }),
                )),
            Expanded(
                child: Visibility(
              visible: getNewTaskInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: getNewTaskList,
                child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChanges: () {
                          getNewTaskList();
                          getTaskCountSummaryList();
                        },
                        showProgress: (inPogress) {
                          getNewTaskInProgress = inPogress;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      );
                    }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
