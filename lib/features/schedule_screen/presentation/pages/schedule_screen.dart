import 'package:flutter/material.dart';
// import 'package:algoriza_todo/core/utils/blocs/cubit.dart';
// import 'package:algoriza_todo/core/utils/blocs/states.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                _buildDateButton('Sun', 28, true),
                _buildDateButton('Mon', 1, false),
                _buildDateButton('Tue', 2, false),
                _buildDateButton('Wed', 3, false),
                _buildDateButton('Thu', 4, false),
                _buildDateButton('Fri', 5, false),
                _buildDateButton('Sat', 6, false),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.EEEE().format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat.yMMMM().format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                _buildScheduleItem(
                  time: '09:00 AM',
                  title: 'Design team meeting',
                  color: Colors.red,
                  isCompleted: true,
                ),
                _buildScheduleItem(
                  time: '11:00 AM',
                  title: 'Making wireframes',
                  color: Colors.orange,
                  isCompleted: false,
                ),
                _buildScheduleItem(
                  time: '13:00 PM',
                  title: 'Check emails',
                  color: Colors.yellow,
                  isCompleted: false,
                ),
                _buildScheduleItem(
                  time: '13:30 PM',
                  title: 'Meeting with Murman Khvadadze',
                  color: Colors.blue,
                  isCompleted: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateButton(String day, int date, bool isSelected) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? Colors.green : Colors.grey[300]),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  day,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(date.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleItem({
    required String time,
    required String title,
    required Color color,
    required bool isCompleted,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.white,
            child: Icon(
              isCompleted ? Icons.check : Icons.circle,
              size: 14.0,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
