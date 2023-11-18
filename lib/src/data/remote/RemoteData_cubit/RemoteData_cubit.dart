import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapura_tm/src/config/utils/managers/app_constants.dart';

import '../../../domain/models/TaskModel.dart';
import '../../../presentation/Shared/Components.dart';

part 'RemoteData_states.dart';

class RemoteDataCubit extends Cubit<RemoteAppStates> {
  RemoteDataCubit() : super(InitialAppState());

  static RemoteDataCubit get(context) => BlocProvider.of(context);

  Future<List<String>> getStatus() async {
    try {
      emit(GettingData());
      var data = await FirebaseFirestore.instance
          .collection(AppConstants.statusCollection)
          .get(); // Use get() instead of snapshots() to retrieve a single data snapshot

      List<String> dataList = [];
      for (var element in data.docs) {
        dataList.add(element.id);
      }
      emit(GetDataSuccessful());
      return dataList; // Return the list of document IDs
    } catch (e) {
      emit(GetDataError());
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<String>> getUsers() async {
    try {
      emit(GettingData());
      var data = await FirebaseFirestore.instance
          .collection(AppConstants.usersCollection)
          .get(); // Use get() instead of snapshots() to retrieve a single data snapshot

      List<String> dataList = [];
      for (var element in data.docs) {
        dataList.add(element.id);
      }
      emit(GetDataSuccessful());
      return dataList; // Return the list of document IDs
    } catch (e) {
      emit(GetDataError());
      return []; // Return an empty list in case of an error
    }
  }

  //Firebase get current data
  Future<void> deleteTask(Task task) async {
    try {
      emit(GettingData());
      await FirebaseFirestore.instance
          .collection(AppConstants.taskCollection)
          .doc(task.id)
          .delete();
      emit(GetDataSuccessful());
    } catch (e) {
      emit(GetDataError());
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      emit(GettingData());
      await FirebaseFirestore.instance
          .collection(AppConstants.taskCollection)
          .doc(task.id)
          .update(task.toMap());
      emit(GetDataSuccessful());
    } catch (e) {
      emit(GetDataError());
    }
  }

  Future<void> addTask(Task task) async {
    try {
      emit(GettingData());
      await FirebaseFirestore.instance
          .collection(AppConstants.taskCollection)
          .doc(task.id)
          .set(task.toMap());
      emit(GetDataSuccessful());
    } catch (e) {
      emit(GetDataError());
    }
  }

  //Firebase Login with current user data
  Future<void> userLogin(String mail, String pwd, context) async {
    emit(GettingData());

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pwd);
      showToast("Successful Login", context);
      emit(GetDataSuccessful());
    } on FirebaseAuthException {
      showToast("Successful Error", context);

      emit(GetDataError());
    }
  }
}
