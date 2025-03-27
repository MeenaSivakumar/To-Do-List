import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/utils.dart/theme.dart';
import 'package:to_do_list/views/home_page.dart';
import 'package:to_do_list/widgets/button.dart';
import 'package:to_do_list/widgets/text_fields.dart';
import 'package:to_do_list/widgets/text_widget.dart';

class AddTask extends StatefulWidget {
  final Function(Task) addTask;
  const AddTask({super.key, required this.addTask});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController _taskcontroller = TextEditingController();
  TextEditingController _description = TextEditingController();
  TimeOfDay? startTime;
  TimeOfDay? endtime;
  DateTime? startDate;
  DateTime? enddate;
  bool isRemainderSet = false;
  DateTime? reminderDateTime;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initstate() {
    super.initState();
    _initialNotifications();
  }

  void _initialNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _setReminder(DateTime scheduledDateTime) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'reminder_channel_id',
      'Reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.schedule(
      0, // ID for the notification
      'Task Reminder',
      'This is a reminder for your task!',
      scheduledDateTime,
      notificationDetails,
    );
  }

  Future<void> _pickStartTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        startTime = pickedTime;
      });
    }
  }

  Future<void> _pickEndTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        endtime = pickedTime;
      });
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return '${date.year}-${date.month.toString().padLeft(1, '0')}-${date.day.toString().padLeft(1, '0')}';
  }

  Future<void> _pickStartDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        startDate = pickedDate;
      });
    }
  }

  Future<void> _pickEndDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        enddate = pickedDate;
      });
    }
  }

  void _pickRemainderTime() async {
    final TimeOfDay? pickedRemTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedRemTime != null && startDate != null) {
      setState(() {
        reminderDateTime = DateTime(
          startDate!.year,
          startDate!.month,
          startDate!.day,
          startTime!.hour,
          startTime!.minute,
        );
      });
    }
  }

  
  String formatTimeOfDay(TimeOfDay? time) {
    if (time == null) return 'SelectTime';
    final hours = time.hour.toString().padLeft(1, '0');
    final minutes = time.minute.toString().padLeft(1, '0');
    return '$hours:$minutes';
  }


  void _saveTask() {
    if (_taskcontroller.text.isNotEmpty ||
        startTime != null ||
        endtime != null ||
        startDate != null ||
        enddate != null) {
      final newTask = Task(
        name: _taskcontroller.text,
        startDate: startDate!,
        endDate: enddate!,
        starttime: startTime!,
        endtime: endtime!,
      );
      widget.addTask(newTask);
       Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }

    if (isRemainderSet && reminderDateTime != null) {
      _setReminder(reminderDateTime!);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task Saved! Reminder set.')),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task Saved!')),
    );

   
  }

  void _cancelTask() {
    // Clear all entered data
    _taskcontroller.clear();
    setState(() {
      startTime = null;
      endtime = null;
      startDate = null;
      enddate = null;
    });

    // Optionally, navigate back
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white.withOpacity(0.9),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Set Task',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: blue,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: TextField(
                  controller: _taskcontroller,
                  decoration: InputDecoration(
                    hintText: 'Enter Task',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      borderSide: BorderSide(
                        color: black,
                        width: 3,
                      ),
                    ),
                    fillColor: white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      borderSide: BorderSide(
                        color: black,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [TextWidget(text: 'Set Date')],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFields(
                      hintText: '${formatDate(startDate)}',
                      onpressed: _pickStartDate,
                      iconButton: Icons.calendar_month,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    TextFields(
                      hintText: '${formatDate(enddate)}',
                      onpressed: _pickEndDate,
                      iconButton: Icons.calendar_month,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  TextWidget(text: 'Set Time'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFields(
                      hintText: '${formatTimeOfDay(startTime)}',
                      onpressed: _pickStartTime,
                      iconButton: Icons.timer,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    TextFields(
                      hintText: '${formatTimeOfDay(endtime)}',
                      onpressed: _pickEndTime,
                      iconButton: Icons.timer,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  TextWidget(text: 'Enter Drescription'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextField(
                  controller: _description,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      borderSide: BorderSide(
                        width: 2,
                        color: blue,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      borderSide: BorderSide(
                        width: 2,
                        color: blue,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Remainder',
                  ),
                  Switch(
                    value: isRemainderSet,
                    onChanged: (value) {
                      setState(() {
                        isRemainderSet = value;
                        if (!isRemainderSet) reminderDateTime = null;
                      });
                    },
                  ),
                ],
              ),
              if (isRemainderSet)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFields(
                    iconButton: Icons.alarm,
                    onpressed: _pickRemainderTime,
                    hintText: reminderDateTime != null
                        ? formatTimeOfDay(
                            )
                        : 'Pick Time',
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      text: 'cancel',
                      onPressed: _cancelTask,
                    ),
                    Button(
                      text: 'save',
                      onPressed: _saveTask,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on FlutterLocalNotificationsPlugin {
  schedule(int i, String s, String t, DateTime scheduledDateTime,
      NotificationDetails notificationDetails) {}
}
