import 'package:algoriza_todo/core/utils/blocs/cubit.dart';
import 'package:algoriza_todo/core/utils/blocs/states.dart';
import 'package:algoriza_todo/core/utils/widgets/my_task_item.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
        return ConditionalBuilder(
          condition: cubit.allTasks.isNotEmpty,
          builder: (context) => ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) => MyTaskItem(
                task: cubit.allTasks
                    .where((element) => element.completed == 0)
                    .toList()[index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            itemCount: cubit.allTasks
                .where((element) => element.completed == 0)
                .toList()
                .length,
          ),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.menu,
                  size: 100,
                  color: Colors.grey,
                ),
                Text(
                  'No Tasks Add , Please Add Some',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
