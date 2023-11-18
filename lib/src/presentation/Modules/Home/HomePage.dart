import 'package:flutter/material.dart';
import 'package:sapura_tm/src/config/utils/managers/app_constants.dart';
import 'package:sapura_tm/src/presentation/Cubits/appNavi_cubit/navi_cubit.dart';
import 'package:sapura_tm/src/presentation/Shared/Components.dart';

import '../../../config/utils/styles/app_colors.dart';
import '../../Shared/WidgetBuilders.dart';
import '../Tasks/addTasks/addTasksPage.dart';
import '../Tasks/allTask/TasksPage.dart';
import '../Tasks/searchTasks/searchTaskPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchBarText = TextEditingController();
    late String findTask;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          elevation: 1,
          title: const Text(AppConstants.appTitle),
        ),
        body: ListView(
          children: [
            getCube(5, context),
            Text(
              "Sapura",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: getWidth(15, context), color: AppColors.darkColor),
            ),
            Text(
              "Search your Tasks",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: getWidth(4, context),
                  color: AppColors.darkColor.withOpacity(0.8)),
            ),
            getCube(10, context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const Text(
                    "Task",
                    style: TextStyle(color: Colors.black),
                  ),
                  getCube(2, context),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty";
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        findTask = value;
                        NaviCubit.get(context)
                            .navigate(context, SearchTasks(taskName: findTask));
                      },
                      controller: searchBarText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: AppConstants.appTask,
                        prefixIcon: const Icon(Icons.file_copy_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      findTask = searchBarText.text;
                      NaviCubit.get(context)
                          .navigate(context, SearchTasks(taskName: findTask));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            getCube(5, context),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                loadButton(
                    onPressed: () {
                      NaviCubit.get(context)
                          .navigate(context, const TasksPage());
                    },
                    buttonText: "Show all",
                    buttonWidth: getWidth(30, context),
                    textSize: getWidth(3, context),
                    buttonElevation: 2,
                    buttonHeight: getHeight(5, context)),
                loadButton(
                    onPressed: () {
                      NaviCubit.get(context)
                          .navigate(context, const AddTaskPage());
                    },
                    buttonText: "Create",
                    buttonElevation: 2,
                    textSize: getWidth(3, context),
                    buttonWidth: getWidth(30, context),
                    buttonHeight: getHeight(5, context)),
              ],
            ),
          ],
        ));
  }
}
