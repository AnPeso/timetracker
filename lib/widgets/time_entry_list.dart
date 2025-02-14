import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/models/project.dart';
import 'package:timetracker/models/task.dart';
import 'package:timetracker/models/time_entry.dart';
import 'package:timetracker/providers/project_manager_provider.dart';
import 'package:timetracker/providers/task_manager_provider.dart';
import 'package:timetracker/providers/time_entry_provider.dart';
import 'package:timetracker/widgets/no_data_found.dart';
import 'package:timetracker/widgets/time_entry_item.dart';

class TimeEntryList extends StatefulWidget {
  const TimeEntryList({super.key});

  @override
  State<TimeEntryList> createState() => _TimeEntryListState();
}

class _TimeEntryListState extends State<TimeEntryList> {
  @override
  Widget build(BuildContext context) {
    List<TimeEntry> entries =
        Provider.of<TimeEntryProvider>(context, listen: true).entries;
    List<Project> projects =
        Provider.of<ProjectManagerProvider>(context, listen: false).projects;
    List<Task> tasks =
        Provider.of<TaskManagerProvider>(context, listen: false).tasks;

    if (entries.isEmpty) {
      return NoDataFound(
        icon: Icons.hourglass_empty,
        typeOfData: 'time entries',
      );
    }
    return Consumer(builder: (context, value, child) {
      return ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return TimeEntryItem(
              entry: entries[index], projects: projects, tasks: tasks);
        },
      );
    });
  }
}