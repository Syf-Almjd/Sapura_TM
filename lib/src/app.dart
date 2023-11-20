import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapura_tm/src/presentation/Cubits/appNavi_cubit/navi_cubit.dart';

import 'config/utils/managers/app_constants.dart';
import 'data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'domain/userAuth.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteDataCubit>(
          create: (context) => RemoteDataCubit(),
        ),
        BlocProvider<NaviCubit>(
          create: (context) => NaviCubit(),
        ),
      ],
      child: MaterialApp(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          title: AppConstants.appTitle,
          home: const AuthPage()),
    );
  }
}
