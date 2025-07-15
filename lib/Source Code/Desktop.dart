import 'dart:async';
import 'dart:math';

import 'package:adhan/adhan.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dlikir/Source%20Code/sleep_morning.dart';
import 'package:dlikir/Source%20Code/table.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AI.dart';
import 'NamesOfAllah.dart';
import 'Prophetic.dart';
import 'Quran.dart';
import 'Remmber.dart';
import 'Spair.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

class Desktop extends StatefulWidget {
  @override
  _DesktopState createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  int currentIndex = 1;
  bool isDarkMode = true;
  String randomDhikr = '';
  ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true, date = true;
  String hijriDate = '';
  String currentTime = '';

  late SharedPreferences _local;

  final List<String> monthar = [
    "محرم",
    "صفر",
    "ربيع الأول",
    "ربيع الآخر",
    "جمادى الأولى",
    "جمادى الآخرة",
    "رجب",
    "شعبان",
    "رمضان",
    "شوال",
    "ذو القعدة",
    "ذو الحجة"
  ];
  final List<String> monthen = [
    "Muharram",
    "Safar",
    "Rabii' al-Awwal",
    "Rabii' al-Thani",
    "Jumada al-Awwal",
    "Jumada al-Thani",
    "Rajab",
    "Sha'ban",
    "Ramadan",
    "Shawwal",
    "Dhu al-Qi'dah",
    "Dhu al-Hijjah"
  ];

  final List<String> messages = [
    "اللّهُ أَكْبَرُ",
    "الحَمدُ لِلَّهِ",
    "سُبْحَانَ اللّهِ",
    "لَا إِلَٰهَ إِلَّا اللّهُ",
    "اِسْتَغْفِرُ اللّهَ رَبِّي وَأَتُوبُ إِلَيْهِ",
    "اللّهُمَّ صَلِّ عَلَى مُحَمَّدٍ",
    "اللّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ",
    "اللّهُمَّ اجْعَلْ فِي قُلُوبِنَا نُورًا",
    "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ",
    "اللّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ عَذَابِ النَّارِ",
    "اللّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ سُوءِ الْقَضَاءِ"
  ];

  bool notificationsEnabled = true;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      '123',
      'الهدي للايمان',
      description: 'تطبيق مليئ بالاذكار الدينية و القران و غيرة الكثير',
      importance: Importance.high,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _loadNotificationPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
      if (notificationsEnabled) {
        showNotifications();
      }
    });
  }

  Future<void> _saveNotificationPreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationsEnabled', value);
  }

  void showNotifications() {
    for (int i = 0; i < messages.length; i++) {
      Future.delayed(
          Duration(
            seconds: 1200 * i,
          ), () {
        if (notificationsEnabled) {
          _showLocalNotification(i + 1, messages[i]);

          ElegantNotification.success(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text: messages[i] +
                                " \n& Program : الهدي للإيمان ❤"));
                      },
                      icon: Icon(
                        Icons.copy,
                        color: Colors.blue,
                      )),
                ),
              ],
            ),
            title: Text(
              'الهدي للإيمان 🔻',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            description: Text(messages[i]),
          ).show(context);
        }
      });
    }
  }

  Future<void> _showLocalNotification(int id, String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '123',
      'الهدي للايمان',
      channelDescription: 'تطبيق مليئ بالاذكار الدينية و القران و غيرة الكثير',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      15,
      'الهدي للإيمان 🔻',
      message,
      platformChannelSpecifics,
    );
  }

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    _getRandomDhikr();
    _startClock();
    _updateHijriDate();
    _requestLocationPermission();

    _loadNotificationPreference();
    _initializeNotifications();

    initializeDateFormatting('ar', null).then((_) {});

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isAppBarVisible = false;
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isAppBarVisible = true;
        });
      }
    });
  }

  Future<void> _initializePreferences() async {
    _local = await SharedPreferences.getInstance();
    isDarkMode = _local.getBool('isDarkMode') ?? true;
    setState(() {});
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
  }

  void _getRandomDhikr() {
    final random = Random();
    setState(() {
      randomDhikr = messages[random.nextInt(messages.length)];
    });
  }

  void _startClock() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = _formatTime(DateTime.now());
      });
    });
  }

  void _updateHijriDate() {
    final hijriDateTime = HijriCalendar.fromDate(DateTime.now());

    final List<String> monthar = [
      "محرم",
      "صفر",
      "ربيع الأول",
      "ربيع الآخر",
      "جمادى الأولى",
      "جمادى الآخرة",
      "رجب",
      "شعبان",
      "رمضان",
      "شوال",
      "ذو القعدة",
      "ذو الحجة"
    ];
    String dayInArabic = _convertToArabicNumbers(hijriDateTime.hDay.toString());
    String yearInArabic =
        _convertToArabicNumbers(hijriDateTime.hYear.toString());

    int monthIndex = hijriDateTime.hMonth - 1;
    if (monthIndex >= 0 && monthIndex < monthar.length) {
      setState(() {
        String name = monthar[monthIndex];
        hijriDate = '$dayInArabic ${name} $yearInArabic هـ';
      });
    } else {
      print("Invalid month index: $monthIndex");
    }
  }

  String _convertToArabicNumbers(String number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number.split('').map((digit) {
      return arabicDigits[int.parse(digit)];
    }).join('');
  }

  String _formatTime(DateTime dateTime) {
    int hour = dateTime.hour % 12;
    hour = hour == 0 ? 12 : hour;
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String period = dateTime.hour < 12 ? 'صباحاً' : 'مساءً';
    return '$period $hour:$minute';
  }

  void _toggleTheme() async {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    await _local.setBool('isDarkMode', isDarkMode);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isDarkMode ? Color(0xFF2C2C2C) : Color(0xFFEFEFEF),
              isDarkMode ? Color(0xFF1A1A1A) : Color(0xFFD1E8FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            if (_isAppBarVisible) _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: _buildBody(),
              ),
            ),
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            date == false
                ? Text(
                    DateFormat('EEEE, d MMMM yyyy', 'ar')
                        .format(DateTime.now()),
                    style: TextStyle(
                        color: isDarkMode ? Colors.amberAccent : Colors.black),
                  )
                : Text(
                    hijriDate,
                    style: TextStyle(
                        color: isDarkMode ? Colors.amberAccent : Colors.black),
                  ),
            IconButton(
              onPressed: () {
                setState(() {
                  date = !date;
                });
              },
              icon: Icon(
                Icons.arrow_right_outlined,
                color: isDarkMode ? Colors.amberAccent : Colors.black,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode
                ? Colors.black.withOpacity(.1)
                : Colors.white.withOpacity(.3),
          ),
          width: 50,
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(right: 12),
          child: Text(
            currentTime,
            style: TextStyle(
              fontSize: 15,
              color: isDarkMode ? Colors.amberAccent : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (currentIndex == 0) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "🕌 مواعيد الصلاة",
              style: TextStyle(
                fontSize: 40,
                color: isDarkMode ? Colors.amberAccent : Colors.black87,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    offset: Offset(2, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _buildCompass(),
          ],
        ),
      );
    }
    if (currentIndex == 1) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 50),
            _buildDhikrSection(),
            SizedBox(height: 50),
            _buildButtonSection(),
          ],
        ),
      );
    }
    if (currentIndex == 2) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 50),
            _buildDhikrSection(),
            SizedBox(height: 50),
            _buildButtonSectionDikr(),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          ListTile(
            title: Text(
              'تغيير الثيمات',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                _toggleTheme();
              },
            ),
          ),
          ListTile(
            leading: Text(
              'تواصل مع الذكاء الاصطناعي',
              style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 15),
            ),
            titleAlignment: ListTileTitleAlignment.bottom,
            title: Text("يحتاج الا أنترنت",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'تفعيل الإشعارات',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            trailing: Switch(
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                  _saveNotificationPreference(value);
                  if (notificationsEnabled) {
                    showNotifications();
                  }
                });
              },
            ),
          ), //     الاشعارات
        ],
      );
    }
  }

  TableRow _buildTableRow(String prayerName, DateTime prayerTime) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(prayerName, style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(DateFormat.jm().format(prayerTime),
              style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }

  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  PrayerTimes calculatePrayerTimes(Position position) {
    final params = CalculationMethod.muslim_world_league.getParameters();
    final coordinates = Coordinates(position.latitude, position.longitude);
    return PrayerTimes.today(coordinates, params);
  }

  Widget _buildCompass() {
    return Container(
      child: Column(
        children: [
          Table(
            children: [
              TableRow(
                children: [
                  Text(
                    "العشاء",
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 20),
                  ),
                  Text(
                    "الضهر",
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 20),
                  ),
                  Text(
                    "المغرب",
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 20),
                  ),
                  Text(
                    "العصر",
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 20),
                  ),
                  Text(
                    "الفجر",
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSectionDikr() {
    return Padding(
      padding: EdgeInsets.all(9),
      child: Wrap(
        spacing: 30,
        runSpacing: 40,
        children: [
          _buildCreativeButton(
            "أذكار الصباح",
            '🌕',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => remmbersun()),
            ),
          ),
          _buildCreativeButton(
            "أذكار المساء",
            '🌙',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => remmber()),
            ),
          ),
          _buildCreativeButton(
            "أذكار النوم",
            '🛏',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => remmbersl()),
            ),
          ),
          _buildCreativeButton(
            "أذكار\nالاستيقاض",
            '⏰',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => remmbermor()),
            ),
          ),
          _buildCreativeButton(
            "أذكار الصلاة",
            '🕌',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => remmbermasged()),
            ),
          ),
          _buildCreativeButton(
            "أذكار اخرى",
            '🔖',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => remmberanydikr()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSection() {
    return Padding(
      padding: EdgeInsets.all(9),
      child: Wrap(
        spacing: 30,
        runSpacing: 50,
        children: [
          _buildCreativeButton(
            "اسماء الله",
            'ﷻ',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NamesOfAllah()),
            ),
          ),
          _buildCreativeButton(
            "تسبيح",
            '📿',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Spair()),
            ),
          ),
          _buildCreativeButton(
            "القران",
            '📖',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuranScreen()),
            ),
          ),
          _buildCreativeButton(
            "الاحاديث\nالاربعين\nالنووية",
            'ﷺ',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HadithListScreen()),
            ),
          ),
          _buildCreativeButtontale(
            "جدولة مهام",
            '🪫',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SchedulePage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreativeButtontale(
      String title, String emoji, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 310,
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                emoji,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ).animate().scale(
                duration: Duration(milliseconds: 200),
                curve: Curves.elasticOut,
              ),
        ),
      ),
    );
  }

  Widget _buildCreativeButton(
      String title, String emoji, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                emoji,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ).animate().scale(
                duration: Duration(milliseconds: 200),
                curve: Curves.elasticOut,
              ),
        ),
      ),
    );
  }

  Widget _buildDhikrSection() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 3),
      child: Column(
        children: [
          Text(
            randomDhikr,
            style: TextStyle(
              fontSize: 45,
              color: isDarkMode ? Colors.amberAccent : Colors.black87,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(2, 2),
                  blurRadius: 8,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return ConvexAppBar(
      items: [
        TabItem(
          icon: Animate(
            child: Text(
              "🕌",
              style: TextStyle(fontSize: 30),
            ),
          ),
          title: 'مواعيد الصلاة',
        ),
        TabItem(
          icon: Animate(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    "🎇",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
          ),
          title: 'الرئيسية',
        ),
        TabItem(
          icon: Animate(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    "✨",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          title: 'الاذكار',
        ),
        TabItem(
          icon: Animate(
            child: Text(
              "⚙️",
              style: TextStyle(fontSize: 30),
            ),
          ),
          title: 'الاعدادات',
        ),
      ],
      initialActiveIndex: currentIndex,
      onTap: (int i) {
        setState(() {
          currentIndex = i;
        });
      },
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      color: isDarkMode ? Colors.yellow.shade600 : Colors.black,
      activeColor: isDarkMode
          ? Colors.white.withOpacity(.8)
          : Colors.black.withOpacity(.8),
      style: TabStyle.react,
    );
  }
}
