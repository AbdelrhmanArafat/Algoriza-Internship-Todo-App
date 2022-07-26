import 'package:algoriza_todo/core/utils/blocs/cubit.dart';
import 'package:algoriza_todo/core/utils/blocs/states.dart';
import 'package:algoriza_todo/core/utils/widgets/my_button.dart';
import 'package:algoriza_todo/features/all_task_screen/presentation/pages/all_task_screen.dart';
import 'package:algoriza_todo/features/new_task_screen/presentation/pages/new_task_screen.dart';
import 'package:algoriza_todo/features/schedule_screen/presentation/pages/schedule_screen.dart';
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
                'Board',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                      child:
                          Text('All', style: TextStyle(color: Colors.black))),
                  Tab(
                      child: Text('Completed',
                          style: TextStyle(color: Colors.black))),
                  Tab(
                      child: Text('Uncompleted',
                          style: TextStyle(color: Colors.black))),
                  Tab(
                      child: Text('Favorite',
                          style: TextStyle(color: Colors.black))),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        const AllTaskScreen(),
                        Container(color: Colors.yellow),
                        Container(color: Colors.red),
                        Container(color: Colors.grey),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  MyButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewTaskScreen()),
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
