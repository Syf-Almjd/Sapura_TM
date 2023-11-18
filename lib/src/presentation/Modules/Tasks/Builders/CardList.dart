import 'package:flutter/material.dart';
import 'package:sapura_tm/src/config/utils/styles/app_colors.dart';
import 'package:sapura_tm/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:sapura_tm/src/presentation/Cubits/appNavi_cubit/navi_cubit.dart';
import 'package:sapura_tm/src/presentation/Modules/Tasks/updateTasks/editTaskPage.dart';
import 'package:sapura_tm/src/presentation/Shared/Components.dart';

import '../../../../domain/models/TaskModel.dart';

class CardList extends StatelessWidget {
  final Task task;

  const CardList({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // open edit page
        },
        child: Card(
          elevation: 2, // Add a slight elevation for a card-like appearance
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Apply rounded corners
          ),

          child: ExpansionTile(
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            title: Text(
              task.project.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.darkColor,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              task.status,
              style: TextStyle(color: AppColors.darkColor.withOpacity(0.7)),
            ),
            trailing: Wrap(
              children: [
                InkWell(
                    onTap: () {
                      NaviCubit.get(context).navigate(
                          context,
                          EditTaskPage(
                            task: task,
                          ));
                      //open edit page
                      RemoteDataCubit.get(context).updateTask(task);
                    },
                    child: const Icon(Icons.edit)),
                getCube(5, context),
                InkWell(
                    onTap: () {
                      showChoiceDialog(
                          context: context,
                          onYes: () {
                            RemoteDataCubit.get(context).deleteTask(task);
                          });
                    },
                    child: const Icon(Icons.delete_outline_outlined)),
                getCube(5, context),
              ],
            ),
            children: [
              ListTile(
                title: const Text(
                  "Project Name:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  task.project,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  "Project Task:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  task.task,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  "Assigned To:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  task.assignedTo,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  "Date From:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  task.dateFrom,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  "Date To:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  task.dateTo,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  "Project Status:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  task.status,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
