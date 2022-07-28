import 'package:algoriza_todo/core/utils/blocs/cubit.dart';
import 'package:flutter/material.dart';

class MyTaskItem extends StatelessWidget {
  final Map model;

  const MyTaskItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model['id'].toString()),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.check_box_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            AppCubit.get(context).updateData(
              status: 'done',
              id: model['id'],
            );
          },
        ),
        title: Text(
          model['title'],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(
          id: model['id'],
        );
      },
    );
  }
}
