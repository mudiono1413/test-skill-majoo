import 'dart:developer';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:majootestcase/bloc/conectivity/connection_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_cubit.dart';
import 'package:majootestcase/bloc/login_bloc/login_cubit.dart';
import 'package:majootestcase/bloc/register/sign_up_cubit.dart';
import 'package:majootestcase/services/api.dart';
import 'package:majootestcase/ui/login/login_page.dart';
import 'bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Movies',
        theme: ThemeData(
          fontFamily: 'Nunito',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AuthCubit()..fetchHistoryLogin()),
            BlocProvider(create: (_) => LoginCubit()),
            BlocProvider(create: (_) => SignUpCubit()),
            BlocProvider(create: (_) => HomeCubit(RestDataSource())),
            BlocProvider(
                create: (_) => ConnectionCubit()..monitorInternetConnection()),
          ],
          child: MyHomePageScreen(),
        ),
      ),
    );
  }
}

class MyHomePageScreen extends StatelessWidget {
  const MyHomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state.isSignedIn) {
        return Text("data");
      } else {
        return LoginPage();
      }
    });
  }
}
