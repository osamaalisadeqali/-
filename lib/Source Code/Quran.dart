import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;
import 'package:shared_preferences/shared_preferences.dart';

class QuranData {
  static final List<String> mekkiSurahs = [
    "الفاتحة",
    "الأنعام",
    "الأعراف",
    "يونس",
    "هود",
    "يوسف",
    "إبراهيم",
    "الحجر",
    "النحل",
    "الإسراء",
    "الكهف",
    "مريم",
    "طه",
    "الأنبياء",
    "المؤمنون",
    "الفرقان",
    "الشعراء",
    "النمل",
    "العنكبوت",
    "الروم",
    "لقمان",
    "السجدة",
    "الأحزاب",
    "سبأ",
    "فاطر",
    "يس",
    "الصافات",
    "ص",
    "الزمر",
    "غافر",
    "فصلت",
    "الشورى",
    "الزخرف",
    "الدخان",
    "الجاثية",
    "الأحقاف",
    "محمد",
    "ق",
    "الذاريات",
    "الطور",
    "النجم",
    "القمر",
    "الرحمن",
    "الواقعة",
    "الملائكة",
    "المطففين",
    "الانشقاق",
    "البروج",
    "الطارق",
    "الأعلى",
    "الغاشية",
    "الفجر",
    "البلد",
    "الشمس",
    "الليل",
    "الضحى",
    "الشرح",
    "التين",
    "العلق",
    "القدر",
    "البينة",
    "الزلزلة",
    "العاديات",
    "القارعة",
    "التكاثر",
    "العصر",
    "الهمزة",
    "الفيل",
    "قريش",
    "الماعون",
    "الكوثر",
    "الكافرون",
    "النصر",
    "المسد",
    "الإخلاص",
    "الفلق",
    "الناس",
  ];

  static final List<String> orderedSurahs = [
    "الفاتحة",
    "البقرة",
    "آل عمران",
    "النساء",
    "المائدة",
    "الأنعام",
    "الأعراف",
    "الأنفال",
    "التوبة",
    "يونس",
    "هود",
    "يوسف",
    "الرعد",
    "إبراهيم",
    "الحجر",
    "النحل",
    "الإسراء",
    "الكهف",
    "مريم",
    "طه",
    "الأنبياء",
    "الحج",
    "المؤمنون",
    "النور",
    "الفرقان",
    "الشعراء",
    "النمل",
    "القصص",
    "العنكبوت",
    "الروم",
    "لقمان",
    "السجدة",
    "الأحزاب",
    "سبأ",
    "فاطر",
    "يس",
    "الصافات",
    "ص",
    "الزمر",
    "غافر",
    "فصلت",
    "الشورى",
    "الزخرف",
    "الدخان",
    "الجاثية",
    "الأحقاف",
    "محمد",
    "الفتح",
    "الحجرات",
    "ق",
    "الذاريات",
    "الطور",
    "النجم",
    "القمر",
    "الرحمن",
    "الواقعة",
    "الحديد",
    "المجادلة",
    "الحشر",
    "الممتحنة",
    "الصف",
    "الجمعة",
    "المنافقون",
    "التغابن",
    "الطلاق",
    "التحريم",
    "الملك",
    "القلم",
    "الحاقة",
    "المعارج",
    "نوح",
    "الجن",
    "المزمل",
    "المدثر",
    "القيامة",
    "الإنسان",
    "المرسلات",
    "النبأ",
    "النازعات",
    "عبس",
    "التكوير",
    "الانفطار",
    "المطففين",
    "الانشقاق",
    "البروج",
    "الطارق",
    "الأعلى",
    "الغاشية",
    "الفجر",
    "البلد",
    "الشمس",
    "الليل",
    "الضحى",
    "الشرح",
    "التين",
    "العلق",
    "القدر",
    "البينة",
    "الزلزلة",
    "العاديات",
    "القارعة",
    "التكاثر",
    "العصر",
    "الهمزة",
    "الفيل",
    "قريش",
    "الماعون",
    "الكوثر",
    "الكافرون",
    "النصر",
    "المسد",
    "الإخلاص",
    "الفلق",
    "الناس",
  ];

  static final List<int> surahVerseCounts = [
    7, // الفاتحة
    286, // البقرة
    200, // آل عمران
    176, // النساء
    81, // المائدة
    165, // الأنعام
    206, // الأعراف
    75, // الأنفال
    129, // التوبة
    109, // يونس
    111, // هود
    114, // يوسف
    53, // الرعد
    43, // إبراهيم
    52, // الحجر
    99, // النحل
    128, // الإسراء
    111, // الكهف
    74, // مريم
    98, // طه
    135, // الأنبياء
    112, // الحج
    78, // المؤمنون
    118, // النور
    64, // الفرقان
    77, // الشعراء
    68, // النمل
    55, // القصص
    88, // العنكبوت
    69, // الروم
    60, // لقمان
    34, // السجدة
    73, // الأحزاب
    30, // سبأ
    54, // فاطر
    45, // يس
    83, // الصافات
    182, // ص
    53, // الزمر
    31, // غافر
    46, // فصلت
    36, // الشورى
    29, // الزخرف
    89, // الدخان
    59, // الجاثية
    37, // الأحقاف
    35, // محمد
    38, // الفتح
    29, // الحجرات
    62, // ق
    49, // الذاريات
    60, // الطور
    49, // النجم
    70, // القمر
    55, // الرحمن
    78, // الواقعة
    40, // الحديد
    31, // المجادلة
    24, // الحشر
    20, // الممتحنة
    12, // الصف
    18, // الجمعة
    11, // المنافقون
    10, // التغابن
    18, // الطلاق
    12, // التحريم
    8, // الملك
    30, // القلم
    52, // الحاقة
    29, // المعارج
    27, // نوح
    28, // الجن
    56, // المزمل
    20, // المدثر
    56, // القيامة
    40, // الإنسان
    31, // المرسلات
    50, // النبأ
    40, // النازعات
    46, // عبس
    42, // التكوير
    36, // الانفطار
    31, // المطففين
    36, // الانشقاق
    25, // البروج
    22, // الطارق
    19, // الأعلى
    19, // الغاشية
    26, // الفجر
    30, // البلد
    25, // الشمس
    36, // الليل
    20, // الضحى
    11, // الشرح
    12, // التين
    8, // العلق
    19, // القدر
    15, // البينة
    8, // الزلزلة
    11, // العاديات
    11, // القارعة
    9, // التكاثر
    8, // العصر
    7, // الهمزة
    7, // الفيل
    5, // قريش
    5, // الماعون
    9, // الكوثر
    11, // الكافرون
    3, // النصر
    5, // المسد
    5, // الإخلاص
    5, // الفلق
    5, // الناس
  ];
}

class QuranScreen extends StatefulWidget {
  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<String> filteredSurahs = [];
  int? playingIndex; // متغير لتتبع السورة التي يتم تشغيلها

  @override
  void initState() {
    super.initState();
    filteredSurahs = List.from(QuranData.orderedSurahs);
  }

  void _playSurah(int index) async {
    String audioUrl = 'quran/001.mp3'; // استبدل هذا بالرابط الصحيح
    await _audioPlayer.play(audioUrl as Source);
    setState(() {
      playingIndex = index; // تعيين السورة التي يتم تشغيلها
    });

    print("تشغيل السورة: ${QuranData.orderedSurahs[index]}");
  }

  void _filterSurahs(String query) {
    setState(() {
      filteredSurahs = QuranData.orderedSurahs
          .where((surah) => surah.contains(query))
          .toList();
    });
  }

  void _openSearchDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 15.0,
            right: 15.0,
            top: 15.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                onChanged: _filterSurahs,
                decoration: InputDecoration(
                  hintText: "بحث",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _clearAllMarks, // زر لحذف جميع العلامات
                    child: Text("حذف جميع العلامات"),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // إغلاق البحث
                    },
                    child: Text("إغلاق"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _clearAllMarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int surahIndex = 0;
        surahIndex < QuranData.orderedSurahs.length;
        surahIndex++) {
      for (int page = 1;
          page <= QuranData.surahVerseCounts[surahIndex];
          page++) {
        await prefs.remove('markedPage_${surahIndex + 1}_$page');
      }
    }
    print("تم حذف جميع العلامات");
  }

  // دالة للتحقق من وجود صفحة مميزة في السورة
  Future<bool> _isSurahMarked(int surahIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int page = 1; page <= QuranData.surahVerseCounts[surahIndex]; page++) {
      if (prefs.getBool('markedPage_${surahIndex + 1}_$page') == true) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "القرآن الكريم",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openSearchDialog(context),
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
        backgroundColor: Colors.orangeAccent.shade700,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: AnimationLimiter(
            child: ListView.builder(
              itemCount: filteredSurahs.length,
              itemBuilder: (context, index) {
                int surahIndex =
                    QuranData.orderedSurahs.indexOf(filteredSurahs[index]);
                int n = QuranData.surahVerseCounts[surahIndex];
                String surahName = filteredSurahs[index];
                String surahNumber = (surahIndex + 1).toString();
                String surahType =
                    QuranData.mekkiSurahs.contains(surahName) ? '🕋' : '🕌';

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SurahDetailScreen(
                                      surahIndex: surahIndex + 1),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(15.0),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      playingIndex == surahIndex
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      if (playingIndex == surahIndex) {
                                        _audioPlayer.pause();
                                        setState(() {
                                          playingIndex = null; // إيقاف التشغيل
                                        });
                                      } else {
                                        _playSurah(surahIndex);
                                      }
                                    },
                                  ),
                                  Text(
                                    "$surahType",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.blue),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Column(
                                      children: [
                                        Text(
                                          "آياتها",
                                          style: GoogleFonts.amiri(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "$n ",
                                          style: GoogleFonts.amiri(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      FutureBuilder<bool>(
                                        future: _isSurahMarked(surahIndex),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else if (snapshot.hasData &&
                                              snapshot.data!) {
                                            return Column(
                                              children: [
                                                Text(
                                                  '$surahName',
                                                  textAlign: TextAlign.right,
                                                  style: GoogleFonts.amiri(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .underline, // إضافة خط تحت النص
                                                      decorationColor: Colors
                                                          .red, // لون الخط
                                                      decorationThickness:
                                                          2), // سمك الخط
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Text(
                                              '$surahName',
                                              textAlign: TextAlign.right,
                                              style: GoogleFonts.amiri(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          }
                                        },
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "$surahNumber ",
                                            style: GoogleFonts.amiri(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            " : رقم",
                                            style: GoogleFonts.amiri(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SurahDetailScreen extends StatefulWidget {
  final int surahIndex;

  SurahDetailScreen({required this.surahIndex});

  @override
  _SurahDetailScreenState createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  int currentPage = 1;
  double fontSize = 25;
  bool isMarked = false;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _loadFontSize();
    _loadLastReadPage();
    _loadMarkedState();
    _pageController = PageController(initialPage: currentPage - 1);
  }

  Future<void> _navigateToMarkedPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int page = 1;
        page <= QuranData.surahVerseCounts[widget.surahIndex - 1];
        page++) {
      if (prefs.getBool('markedPage_${widget.surahIndex}_$page') == true) {
        setState(() {
          currentPage = page; // تحديث الصفحة إلى الصفحة المميزة
        });
        _pageController
            .jumpToPage(currentPage - 1); // الانتقال مباشرة إلى الصفحة المميزة
        break;
      }
    }
  }

  Future<void> _loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fontSize = prefs.getDouble('fontSize') ?? 25;
    });
  }

  Future<void> _loadLastReadPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentPage = prefs.getInt('lastReadPage_${widget.surahIndex}') ?? 1;
    });
  }

  Future<void> _loadMarkedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isMarked =
          prefs.getBool('markedPage_${widget.surahIndex}_${currentPage}') ??
              false;
    });

    if (isMarked) {
      _navigateToMarkedPage();
    }
  }

  Future<void> _saveMarkedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('markedPage_${widget.surahIndex}_${currentPage}', true);
    setState(() {
      isMarked = true;
    });

    Fluttertoast.showToast(
      msg: "تم حفظ العلامة بنجاح",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> _removeMarkedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'markedPage_${widget.surahIndex}_${currentPage}', false);
    setState(() {
      isMarked = false;
    });
  }

  Future<void> _saveLastReadPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('lastReadPage_${widget.surahIndex}', currentPage);
    setState(() {});
  }

  Future<void> _saveFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', fontSize);
  }

  void _increaseFontSize() {
    setState(() {
      fontSize += 2;
      _saveFontSize();
    });
  }

  void _decreaseFontSize() {
    setState(() {
      fontSize = (fontSize > 10) ? fontSize - 2 : 15;
      _saveFontSize();
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalPagesBefore = 0;

    for (int i = 1; i < widget.surahIndex; i++) {
      totalPagesBefore += (quran.getVerseCount(i) /
              ((MediaQuery.of(context).size.height / 30).floor() - 15))
          .ceil();
    }

    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.add), onPressed: _increaseFontSize),
                  IconButton(
                      icon: Icon(Icons.remove), onPressed: _decreaseFontSize),
                  IconButton(
                    icon:
                        Icon(isMarked ? Icons.bookmark : Icons.bookmark_border),
                    onPressed: () {
                      if (isMarked) {
                        _removeMarkedState();
                      } else {
                        _saveMarkedState();
                      }
                    },
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isMarked)
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("علامة",
                            style: GoogleFonts.amiri(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black)),
                        height: 20,
                        width: MediaQuery.of(context).size.width - 305,
                        color: Colors.red.shade100,
                      ),
                    ),
                ],
              ),
              Spacer(),
              Container(
                child: Text(quran.getSurahNameArabic(widget.surahIndex),
                    style: GoogleFonts.amiri(
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontSize: 19,
                        color: Colors.black)),
              ),
              Spacer(),
              Container(
                child: Text(": سورة",
                    style: GoogleFonts.amiri(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black)),
              ),
            ],
          ),
        ),
      ],
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double verseHeight = 30;
            int versesPerPage =
                (constraints.maxHeight / verseHeight).floor() - 15;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: PageView.builder(
                controller: _pageController,
                itemCount:
                    (quran.getVerseCount(widget.surahIndex) / versesPerPage)
                        .ceil(),
                onPageChanged: (pageIndex) {
                  setState(() {
                    currentPage = pageIndex + 1;
                    _saveLastReadPage();
                    _loadMarkedState();
                  });
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, pageIndex) {
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 20.0, left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (pageIndex == 0 && widget.surahIndex != 9)
                                  Center(
                                    child: Text(
                                      "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.amiri(
                                          fontSize: fontSize,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                SizedBox(height: 20),
                                Text(
                                  List.generate(versesPerPage, (index) {
                                    int verseIndex =
                                        (pageIndex * versesPerPage) + index;
                                    if (verseIndex <
                                        quran
                                            .getVerseCount(widget.surahIndex)) {
                                      return quran.getVerse(
                                              widget.surahIndex, verseIndex + 1,
                                              verseEndSymbol: true) +
                                          " ";
                                    } else {
                                      return "";
                                    }
                                  }).join(),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.amiri(fontSize: fontSize),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
