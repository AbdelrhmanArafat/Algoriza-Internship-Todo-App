import 'package:algoriza_todo/core/utils/blocs/cubit.dart';
import 'package:algoriza_todo/core/utils/blocs/states.dart';
import 'package:algoriza_todo/core/utils/widgets/my_button.dart';
import 'package:algoriza_todo/core/utils/widgets/my_dropdown_button.dart';
import 'package:algoriza_todo/core/utils/widgets/my_text_form_filed.dart';
import 'package:algoriza_todo/features/new_task_screen/presentation/widgets/text_widget.dart';
import 'package:algoriza_todo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  String? dropdownValue;
  List<String> items = [
    '1 day before',
    '1 hour before',
    '30 min before',
    '10 min before'
  ];
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    final fromKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final dateController = TextEditingController();
    final startTimeController = TextEditingController();
    final endTimeController = TextEditingController();
    final remindController = TextEditingController();
    final repeatController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
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
                            controller: titleController,
                            type: TextInputType.name,
                            hintText: 'Design team meeting',
                            validator: 'title can not be empty',
                          ),
                          const SizedBox(height: 20),
                          const TextWidget(text: 'Date'),
                          const SizedBox(height: 5),
                          //Date
                          MyTextFromFiled(
                            controller: dateController,
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
                                  dateController.text =
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
                                      controller: startTimeController,
                                      type: TextInputType.datetime,
                                      hintText: '11:00 Am',
                                      validator: 'time can not be empty',
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          startTimeController.text =
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
                                      controller: endTimeController,
                                      type: TextInputType.datetime,
                                      hintText: '14:00 Pm',
                                      validator: 'time can not be empty',
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          endTimeController.text =
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
                            controller: remindController,
                            type: TextInputType.datetime,
                            hintText: '10 minutes early',
                            validator: 'reminder can not be empty',
                            suffix: const Icon(Icons.keyboard_arrow_down),
                          ),
                          const SizedBox(height: 20),
                          const TextWidget(text: 'Repeat'),
                          const SizedBox(height: 5),
                          //Repeat
                          MyTextFromFiled(
                            controller: repeatController,
                            type: TextInputType.datetime,
                            hintText: 'weekly',
                            validator: 'repeat can not be empty',
                            onTap: () {},
                            suffix: const Icon(Icons.keyboard_arrow_down),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  MyButton(
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {
                        cubit.insertDatabase(
                          title: titleController.text,
                          date: dateController.text,
                          startTime: startTimeController.text,
                          endTime: endTimeController.text,
                          remind: remindController.text,
                          repeat: repeatController.text,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()),
                        );
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
