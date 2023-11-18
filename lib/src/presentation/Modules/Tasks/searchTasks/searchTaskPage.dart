import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sapura_tm/src/config/utils/managers/app_constants.dart';
import 'package:sapura_tm/src/presentation/Modules/Tasks/Builders/CardList.dart';
import 'package:sapura_tm/src/presentation/Shared/Components.dart';

import '../../../../domain/models/TaskModel.dart';

class SearchTasks extends StatefulWidget {
  final String taskName;

  const SearchTasks({super.key, required this.taskName});

  @override
  State<SearchTasks> createState() => _SearchTasksState();
}

class _SearchTasksState extends State<SearchTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
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
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = Task.fromMap(snapshot.data!.docs[index].data());
                  if (data.task.toString().toUpperCase() ==
                      widget.taskName.toString().toUpperCase()) {
                    return CardList(task: data);
                  }
                  return const Padding(
                    padding: EdgeInsets.all(70.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "There are no items with this Task!",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                });
          }),
    );
  }
}
