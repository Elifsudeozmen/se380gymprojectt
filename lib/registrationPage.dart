import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
@override
Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MainPage(),
  );
}
}
class MainPage extends StatelessWidget{
  const MainPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      title: Text('Registration Page'),
      actions:[
        Padding(
          padding: const EdgeInsets.only(right:16),
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 152, 240, 242), //later the image will be added but for now it will just be a color
            radius: 17,
            child: Icon(Icons.person, color: Colors.lightGreenAccent)
          )
          )
      ]
     ),
     body: SingleChildScrollView(
      child: Column(
        children: [
          DayOption(day: 'Monday'),
          DayOption(day: 'Tuesday'),
          DayOption(day: 'Wednesday'),
          DayOption(day: 'Thursday'),
          DayOption(day: 'Friday'),
          DayOption(day: 'Saturday'),
          DayOption(day: 'Sunday'),
        ],
        )
     )
      );
  }
}
class DayOption extends StatefulWidget{
  final String day;
  const DayOption({Key? key, required this.day}) :super(key: key);
  @override
  State<DayOption> createState() => TimeTable();
}
class TimeTable extends State<DayOption>{
  bool isExpanded = false;
  final List <String> timeOptions = [
    '8:00 - 10:00',
    '10:00 - 12:00',
    '12:00 - 14:00',
    '14:00 - 16:00',
    '16:00 - 18:00',
    '18:00 - 20:00',
    '20:00 - 22:00',
    '22:00 - 00:00',
  ];
  @override 
  Widget build(BuildContext context){
    return ExpansionTile(
      title: Text(
        widget.day,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded){
          setState(() => isExpanded = expanded);
       },
       children: timeOptions.map((option){
        return ListTile(
          title: Text(option),
          trailing: IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: (){
              openConfirmButton(context, option);
            },
          ),
        );
       }).toList(),
    );
  }

  void openConfirmButton(BuildContext context, String time){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to register to the $time?'),
        actions:[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered to $time')),);
              },
              child: Text('Yes'),
            ),
        ],
      ),
    );
  }
}
