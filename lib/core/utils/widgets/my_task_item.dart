import 'package:algoriza_todo/core/models/task_model.dart';
import 'package:algoriza_todo/core/utils/blocs/cubit.dart';
import 'package:flutter/material.dart';

class MyTaskItem extends StatefulWidget {
  final TaskModel task;

  const MyTaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<MyTaskItem> createState() => _MyTaskItemState();
}

class _MyTaskItemState extends State<MyTaskItem> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Dismissible(
      key: Key(widget.task.id.toString()),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              cubit.updateCompleteTask(widget.task.id);
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.task.completed == 1
                    ? cubit.taskColorList[widget.task.color]
                    : null,
                border: Border.all(
                  width: 2,
                  color: cubit.taskColorList[widget.task.color],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: widget.task.completed == 1
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 25,
                    )
                  : Container(),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              widget.task.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 15),
          IconButton(
            onPressed: () {
              cubit.updateFavoriteTask(widget.task.id);
            },
            icon: Icon(
              widget.task.favorite == 1
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: cubit.taskColorList[widget.task.color],
            ),
          ),
        ],
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteTaskData(
          id: widget.task.id,
        );
      },
    );
  }
}
