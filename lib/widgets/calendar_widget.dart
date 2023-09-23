import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:note_app/models/note_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalendarWidget(notes: []),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  final List<Note>? notes;

  const CalendarWidget({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Appointment> appointments = _getAppointments();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Calendar'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MyCalendarDataSource(appointments),
      ),
    );
  }

  List<Appointment> _getAppointments() {
    // Aquí puedes crear y retornar tus eventos de calendario
    return [
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        subject: 'Reunión importante',
        color: Colors.blue,
      ),
      // Agrega más eventos aquí...
    ];
  }
}

class MyCalendarDataSource extends CalendarDataSource {
  MyCalendarDataSource(List<Appointment> source) {
    appointments = source;
  }
}
