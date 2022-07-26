import 'package:algoriza_todo/core/utils/blocs/cubit.dart';
import 'package:algoriza_todo/core/utils/blocs/states.dart';
import 'package:algoriza_todo/core/utils/widgets/my_task_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UncompletedTaskScreen extends StatelessWidget {
  const UncompletedTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: MyTaskBuilder(
            tasks: cubit.uncompletedTasks,
          ),
        );
      },
    );
  }
}
