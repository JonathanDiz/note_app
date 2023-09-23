import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:note_app/models/note_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalendarWidget(),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  final List<Note>? notes;

  const CalendarWidget({Key? key, this.notes}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Calendar'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.calendarCell) {
            // Muestra la ventana modal para agregar una nota
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Agregar una nota'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Fecha seleccionada: ${details.date}'),
                      const TextField(
                        decoration: InputDecoration(labelText: 'Contenido de la nota'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Agrega aquí la lógica para guardar la nota
                          Navigator.of(context).pop(); // Cierra la ventana modal
                        },
                        child: const Text('Guardar Nota'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
