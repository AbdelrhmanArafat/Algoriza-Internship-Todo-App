import 'package:algoriza_todo/core/utils/blocs/cubit.dart';
import 'package:algoriza_todo/core/utils/blocs/states.dart';
import 'package:algoriza_todo/core/utils/widgets/my_button.dart';
import 'package:algoriza_todo/features/all_task_screen/presentation/pages/all_task_screen.dart';
import 'package:algoriza_todo/features/completed_task_screen/presentation/pages/completed_task_screen.dart';
import 'package:algoriza_todo/features/favorite_task_screen/presentation/pages/favorite_task_screen.dart';
import 'package:algoriza_todo/features/new_task_screen/presentation/pages/new_task_screen.dart';
import 'package:algoriza_todo/features/schedule_screen/presentation/pages/schedule_screen.dart';
import 'package:algoriza_todo/features/uncompleted_task_screen/presentation/pages/uncompleted_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScheduleScreen()),
                    );
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                )
              ],
              title: const Text(
                'Todo App',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottom: const TabBar(
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.black87,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Uncompleted'),
                  Tab(text: 'Favorite'),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Expanded(
                    child: TabBarView(
                      children: [
                        AllTaskScreen(),
                        CompletedTaskScreen(),
                        UncompletedTaskScreen(),
                        FavoriteTaskScreen(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  MyButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewTaskScreen(),
                        ),
                      );
                    },
                    text: 'Add a task',
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
