import 'package:algoriza_todo/core/utils/blocs/cubit.dart';
import 'package:algoriza_todo/core/utils/blocs/states.dart';
import 'package:algoriza_todo/core/utils/widgets/my_button.dart';
import 'package:algoriza_todo/core/utils/widgets/my_text_form_filed.dart';
import 'package:algoriza_todo/features/new_task_screen/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    final fromKey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppInsertTaskToDatabaseState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const Text(
              'Add Task',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: fromKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(text: 'Title'),
                          const SizedBox(height: 5),
                          //Title
                          MyTextFromFiled(
                            controller: cubit.titleController,
                            type: TextInputType.name,
                            hintText: 'Design team meeting',
                            validator: 'title can not be empty',
                          ),
                          const SizedBox(height: 20),
                          const TextWidget(text: 'Date'),
                          const SizedBox(height: 5),
                          //Date
                          MyTextFromFiled(
                            controller: cubit.dateController,
                            type: TextInputType.datetime,
                            hintText: DateFormat.yMMMd().format(DateTime.now()),
                            validator: 'date can not be empty',
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2200-31-12'),
                              ).then(
                                (value) {
                                  cubit.dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                },
                              );
                            },
                            suffix: const Icon(Icons.keyboard_arrow_down),
                          ),
                          const SizedBox(height: 20),
                          //Timing Row
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextWidget(text: 'Start time'),
                                    const SizedBox(height: 5),
                                    //Start Time
                                    MyTextFromFiled(
                                      controller: cubit.startTimeController,
                                      type: TextInputType.datetime,
                                      hintText: '11:00 Am',
                                      validator: 'time can not be empty',
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          cubit.startTimeController.text =
                                              value!.format(context).toString();
                                        });
                                      },
                                      suffix: const Icon(Icons.access_time),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextWidget(text: 'End time'),
                                    const SizedBox(height: 5),
                                    //End Time
                                    MyTextFromFiled(
                                      controller: cubit.endTimeController,
                                      type: TextInputType.datetime,
                                      hintText: '14:00 Pm',
                                      validator: 'time can not be empty',
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          cubit.endTimeController.text =
                                              value!.format(context).toString();
                                        });
                                      },
                                      suffix: const Icon(Icons.access_time),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const TextWidget(text: 'Remind'),
                          const SizedBox(height: 5),
                          //Reminder
                          MyTextFromFiled(
                            controller: cubit.remindController,
                            readOnly: true,
                            hintText: 'Select Your Reminder',
                            validator: 'reminder can not be empty',
                            suffix: DropdownButton(
                              icon: const Icon(Icons.keyboard_arrow_down),
                              underline: Container(),
                              items: cubit.remindList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                cubit.setReminder(value!);
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          const TextWidget(text: 'Repeat'),
                          const SizedBox(height: 5),
                          //Repeat
                          MyTextFromFiled(
                            controller: cubit.repeatController,
                            readOnly: true,
                            hintText: 'Select Your Repeat',
                            validator: 'repeat can not be empty',
                            suffix: DropdownButton(
                              icon: const Icon(Icons.keyboard_arrow_down),
                              underline: Container(),
                              items: cubit.repeatList
                                  .map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? value) {
                                cubit.setRepeater(value!);
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          //color
                          const TextWidget(text: 'Color'),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              ...cubit.taskColorList
                                  .asMap()
                                  .map(
                                    (key, value) => MapEntry(
                                      key,
                                      IconButton(
                                        onPressed: () {
                                          cubit.changeTaskColor(key);
                                        },
                                        icon: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 3,
                                              color:
                                                  cubit.selectedTaskColor == key
                                                      ? Colors.black
                                                      : Colors.transparent,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: value,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .values
                                  .toList(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  MyButton(
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {
                        cubit.insertTaskToDatabase();
                      }
                    },
                    text: 'Create a Task',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
