import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sapura_tm/src/config/utils/managers/app_strings.dart';
import 'package:sapura_tm/src/config/utils/styles/app_colors.dart';
import 'package:sapura_tm/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';

import '../../../../domain/models/TaskModel.dart';
import '../../../Cubits/appNavi_cubit/navi_cubit.dart';
import '../../../Shared/Components.dart';
import '../../../Shared/WidgetBuilders.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({super.key, required this.task});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  List<String> statusData = AppStrings.defaultStatus;
  List<String> usersData = AppStrings.defaultUser;

  final textForm = GlobalKey<FormState>();

  TextEditingController project = TextEditingController();

  TextEditingController task = TextEditingController();

  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await RemoteDataCubit.get(context).getUsers().then((value) async {
      usersData = value;
      return statusData = await RemoteDataCubit.get(context).getStatus();
    });
    setState(() {
      usersData = usersData;
      statusData = statusData;
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedStatus = widget.task.status;
    String assignedTo = widget.task.assignedTo;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Update Task"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: textForm,
              child: Column(
                children: [
                  TextFormField(
                    controller: project,
                    decoration: InputDecoration(
                      labelText: widget.task.project,
                      prefixIcon: const Icon(Icons.work_outline_outlined),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        project.text = widget.task.project;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: task,
                    decoration: InputDecoration(
                      labelText: widget.task.task,
                      prefixIcon: const Icon(Icons.task_outlined),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        task.text = widget.task.task;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Assigned To",
                          style: TextStyle(color: AppColors.greyDark),
                        ),
                        Flexible(
                          child: CustomDropdown<String>(
                            hintText: 'Assigned To:',
                            closedBorder: Border.all(),
                            items: usersData.toList(),
                            expandedFillColor:
                                AppColors.greyDark.withOpacity(0.7),
                            closedFillColor:
                                AppColors.greyDark.withOpacity(0.7),
                            initialItem: usersData[0],
                            onChanged: (value) {
                              setState(() {
                                assignedTo = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: dateFrom,
                    decoration: InputDecoration(
                      labelText: widget.task.dateFrom,
                      prefixIcon: const Icon(Icons.date_range_outlined),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        dateFrom.text = widget.task.dateFrom;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: dateTo,
                    decoration: InputDecoration(
                      labelText: widget.task.dateTo,
                      prefixIcon: const Icon(Icons.update),
                    ),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value!.isEmpty) {
                        dateTo.text = widget.task.dateTo;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Status: ",
                          style: TextStyle(color: AppColors.greyDark),
                        ),
                        Flexible(
                          child: CustomDropdown<String>(
                            hintText: 'Status:',
                            closedBorder: Border.all(),
                            items: statusData.toList(),
                            expandedFillColor:
                                AppColors.greyDark.withOpacity(0.7),
                            closedFillColor:
                                AppColors.greyDark.withOpacity(0.7),
                            initialItem: statusData[0],
                            onChanged: (value) {
                              setState(() {
                                selectedStatus = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          loadButton(
              textSize: getWidth(5, context),
              textColor: Colors.white,
              buttonElevation: 2.0,
              onPressed: () {
                validateUpdate(assignedTo, selectedStatus);
              },
              buttonText: "Update"),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  validateUpdate(assignedTo, selectedStatus) {
    Task updatedTask = Task(
        id: widget.task.id,
        project: project.text,
        task: task.text,
        assignedTo: assignedTo,
        dateFrom: dateFrom.text,
        dateTo: dateTo.text,
        status: selectedStatus);
    RemoteDataCubit.get(context).updateTask(updatedTask).then((value) {
      showToast("Successfully Updated!", context);
      NaviCubit.get(context).navigateToHome(context);
    });
  }
}
