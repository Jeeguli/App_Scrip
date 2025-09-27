import 'package:app_scrip_bloc/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_scrip_bloc/features/app_scrip_list/data/services/app_scrip_service.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/domain/repository/app_scrip_repository.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/cubit/app_scrip_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppScripRepository>(
          create: (_) => AppScripRepository(ApiService()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppScripCubit>(
            create: (context) =>
                AppScripCubit(context.read<AppScripRepository>()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
