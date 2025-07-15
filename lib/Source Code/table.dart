import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'document.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Task> tasks = [];
  final PageController _pageController = PageController();
  bool isHijri = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadCalendarPreference();
  }

  Future<void> _loadCalendarPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isHijri = prefs.getBool('isHijri') ?? true;
    });
  }

  Future<void> _saveCalendarPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isHijri', isHijri);
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      List<dynamic> jsonTasks = jsonDecode(tasksString);
      setState(() {
        tasks = jsonTasks.map((json) => Task.fromJson(json)).toList();
      });
      _goToCurrentMonth();
    }
  }

  void _goToCurrentMonth() {
    if (isHijri) {
      HijriCalendar today = HijriCalendar.now();
      int currentIndex = today.hMonth - 1;
      _pageController.jumpToPage(currentIndex);
    } else {
      DateTime today = DateTime.now();
      int currentIndex = today.month - 1;
      _pageController.jumpToPage(currentIndex);
    }
  }

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tasksString =
        jsonEncode(tasks.map((task) => task.toJson()).toList());
    prefs.setString('tasks', tasksString);
  }

  void _addTask(String month) async {
    String? newDescription = await _showTaskDialog('إضافة مهمة جديدة');
    if (newDescription != null && newDescription.isNotEmpty) {
      setState(() {
        tasks.add(Task(
            description: newDescription, date: DateTime.now(), month: month));
        _saveTasks();
      });
      _showSnackBar('تمت إضافة المهمة بنجاح', Colors.green);
    }
  }

  void _editTask(int index) async {
    String? updatedDescription = await _showTaskDialog('تعديل المهمة',
        existingDescription: tasks[index].description);
    if (updatedDescription != null) {
      setState(() {
        tasks[index].description = updatedDescription;
        _saveTasks();
      });
      _showSnackBar('تم تعديل المهمة بنجاح', Colors.blue);
    }
  }

  Future<String?> _showTaskDialog(String title, {String? existingDescription}) {
    TextEditingController controller =
        TextEditingController(text: existingDescription);
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'أدخل وصف المهمة'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: Text('حفظ'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      _saveTasks();
    });
    _showSnackBar('تم حذف المهمة بنجاح', Colors.red);
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
      _saveTasks();
    });
    String message =
        task.isCompleted ? 'تم إنجاز المهمة بنجاح' : 'لم يتم إنجاز المهمة';
    _showSnackBar(message, task.isCompleted ? Colors.green : Colors.orange);
  }

  void _showSnackBar(String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "مهامـ✒",
            style: TextStyle(
                color: Colors.green.shade900, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            DropdownButton<bool>(
              value: isHijri,
              items: [
                DropdownMenuItem(
                  value: true,
                  child: Text('التقويم الهجري'),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text('التقويم الميلادي'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  isHijri = value!;
                  _goToCurrentMonth(); // الانتقال إلى الشهر الحالي عند التغيير
                  _saveCalendarPreference(); // حفظ تفضيل التقويم
                });
              },
            ),
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotesPage(),
                    ));
              },
              icon: Icon(Icons.document_scanner)),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: isHijri ? hijriMonths.length : gregorianMonths.length,
          itemBuilder: (context, index) {
            String month =
                isHijri ? hijriMonths[index] : gregorianMonths[index];
            List<Task> monthlyTasks =
                tasks.where((task) => task.month == month).toList();
            int completedTasks =
                monthlyTasks.where((task) => task.isCompleted).length;
            int totalTasks = monthlyTasks.length;
            String weekDay = getWeekDay(DateTime.now());

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$weekDay"),
                      Text(
                        '$monthـ✒', // عرض الشهر واليوم
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                          child: SingleChildScrollView(
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('المهمة')),
                            DataColumn(label: Text('الحالة')),
                            DataColumn(label: Text('الإجراءات')),
                          ],
                          rows: monthlyTasks.map((task) {
                            int index = tasks.indexOf(task);
                            return DataRow(cells: [
                              DataCell(Container(
                                child: Text(
                                  task.description.isEmpty
                                      ? 'لم يتم تحديد المهمة'
                                      : task.description,
                                  style: TextStyle(
                                      color: task.isCompleted
                                          ? Colors.blue.shade900
                                          : Colors.red,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                width: 90,
                              )),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        task.isCompleted
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color: task.isCompleted
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      onPressed: () =>
                                          _toggleTaskCompletion(task),
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue.shade900,
                                    ),
                                    onPressed: () => _editTask(index),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _deleteTask(index),
                                  ),
                                ],
                              )),
                            ]);
                          }).toList(),
                        ),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Colors.blue.shade200)),
                            onPressed: () => _addTask(month),
                            child: Icon(
                              Icons.add,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'تقييم المهام المنجزة',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'عدد المهام: $totalTasks',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'عدد المهام المنجزة: $completedTasks',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'نسبة الإنجاز: ${totalTasks > 0 ? ((completedTasks / totalTasks) * 100).toStringAsFixed(1) : 0}%',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String getWeekDay(DateTime date) {
    List<String> weekDays = [
      'الأَحَد',
      'الأَثْنَيْن',
      'الثُلاثاء',
      'الأَرْبِعَاء',
      'الخَمِيس',
      'الجُمُعَة',
      'السَّبْت',
    ];
    return weekDays[date.weekday % 7];
  }
}

class Task {
  final DateTime date;
  final String month;
  String description;
  bool isCompleted;

  Task(
      {required this.date,
      required this.month,
      this.description = '',
      this.isCompleted = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      date: DateTime.parse(json['date']),
      month: json['month'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'month': month,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}

const List<String> hijriMonths = [
  'محرم',
  'صفر',
  'ربيع الأول',
  'ربيع الآخر',
  'جمادى الأولى',
  'جمادى الآخرة',
  'رجب',
  'شعبان',
  'رمضان',
  'شوّال',
  'ذو القعدة',
  'ذو الحجة',
];

const List<String> gregorianMonths = [
  'يناير',
  'فبراير',
  'مارس',
  'أبريل',
  'مايو',
  'يونيو',
  'يوليو',
  'أغسطس',
  'سبتمبر',
  'أكتوبر',
  'نوفمبر',
  'ديسمبر',
];
