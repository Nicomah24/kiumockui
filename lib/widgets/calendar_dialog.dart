import 'package:flutter/material.dart';

class CalendarDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace with a real calendar widget if needed
    return AlertDialog(
      title: const Text("School Calendar"),
      content: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_month, size: 60, color: Colors.green),
            const SizedBox(height: 16),
            const Text("Important Dates:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...[
              "Semester Start: 2025-06-01",
              "Registration Deadline: 2025-06-15",
              "Mid-Semester Exams: 2025-07-10",
              "End of Semester: 2025-09-01",
            ].map((e) => ListTile(
              leading: const Icon(Icons.event, color: Colors.green),
              title: Text(e),
            )),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}