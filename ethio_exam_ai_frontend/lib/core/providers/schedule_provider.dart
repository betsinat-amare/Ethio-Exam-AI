import 'package:flutter/material.dart';

class ScheduleEntry {
  final String subject;
  final TimeOfDay time;
  final String day;
  final Color color;

  ScheduleEntry({
    required this.subject,
    required this.time,
    required this.day,
    required this.color,
  });

  String get formattedTime {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour == 0 ? 12 : time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}

class ScheduleProvider extends ChangeNotifier {
  final List<ScheduleEntry> _entries = [
    ScheduleEntry(
      subject: 'Mathematics',
      time: const TimeOfDay(hour: 8, minute: 0),
      day: 'Monday',
      color: const Color(0xFF1A237E),
    ),
    ScheduleEntry(
      subject: 'Physics',
      time: const TimeOfDay(hour: 10, minute: 30),
      day: 'Tuesday',
      color: const Color(0xFF2E7D32),
    ),
    ScheduleEntry(
      subject: 'Biology',
      time: const TimeOfDay(hour: 14, minute: 0),
      day: 'Wednesday',
      color: const Color(0xFF6A1B9A),
    ),
  ];

  List<ScheduleEntry> get entries => List.unmodifiable(_entries);

  ScheduleEntry? get nextEntry {
    if (_entries.isEmpty) return null;
    return _entries.first;
  }

  void addEntry(ScheduleEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void removeEntry(int index) {
    _entries.removeAt(index);
    notifyListeners();
  }
}
