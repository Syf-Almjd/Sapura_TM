import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sapura_tm/src/config/utils/managers/app_constants.dart';
import 'package:sapura_tm/src/presentation/Modules/Tasks/Builders/CardList.dart';
import 'package:sapura_tm/src/presentation/Shared/Components.dart';

import '../../../../domain/models/TaskModel.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Results"),
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(AppConstants.taskCollection)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingAnimation();
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) => CardList(
                    task: Task.fromMap(snapshot.data!.docs[index].data())),
              );
            }));
  }
}
