import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/models/project.dart';
import 'package:timetracker/models/task.dart';
import 'package:timetracker/models/time_entry.dart';
import 'package:timetracker/providers/project_manager_provider.dart';
import 'package:timetracker/providers/task_manager_provider.dart';
import 'package:timetracker/providers/time_entry_provider.dart';
import 'package:timetracker/widgets/no_data_found.dart';
import 'package:timetracker/widgets/time_entry_grouped_item.dart';

class TimeEntryGroupedList extends StatefulWidget {
  const TimeEntryGroupedList({super.key});

  @override
  State<TimeEntryGroupedList> createState() => _TimeEntryListState();
}

class _TimeEntryListState extends State<TimeEntryGroupedList> {
  buildMainContent() {
    final List<TimeEntry> entries =
        Provider.of<TimeEntryProvider>(context, listen: true).entries;

    if (entries.isEmpty) {
      return NoDataFound(
        icon: Icons.hourglass_empty,
        typeOfData: 'time entries',
      );
    } else {
      final List<Project> projects =
          Provider.of<ProjectManagerProvider>(context, listen: false).projects;
      final List<Task> tasks =
          Provider.of<TaskManagerProvider>(context, listen: false).tasks;
      final Map<String, List<TimeEntry>> entriesGrouped =
          groupBy(entries, (entry) => entry.projectId);

      return Consumer(builder: (context, value, child) {
        return ListView.builder(
          itemCount: entriesGrouped.length,
          itemBuilder: (context, index) {
            return TimeEntryGroupedItem(
                entryKey: entriesGrouped.keys.elementAt(index),
                entryValues: entriesGrouped.values.elementAt(index),
                projects: projects,
                tasks: tasks);
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildMainContent();
  }
}