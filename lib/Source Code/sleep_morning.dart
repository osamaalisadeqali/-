import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class remmbersl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _remmbersleep();
}

class _remmbersleep extends State<remmbersl>
    with SingleTickerProviderStateMixin {
  bool isLightTheme = false;
  double fontSize = 30;

  List<String> eveningAzka21 = [
    "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ هُوَ اللَّهُ أَحَدٌ، اللَّهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَٰهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَالنَّاسِ",
    "بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي، وَبِكَ أَرْفَعُهُ، إِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِينَ",
    "سُبْحَانَ اللَّهِ",
    "الْحَمْدُ لِلَّهِ",
    "اللَّهُ أَكْبَرُ",
    "اللَّهُمَّ أَسْلَمْتُ نَفْسِي إِلَيْكَ، وَفَوَّضْتُ أَمْرِي إِلَيْكَ، وَوَجَّهْتُ وَجْهِي إِلَيْكَ، وَأَلْجَأْتُ ظَهْرِي إِلَيْكَ، رَغْبَةً وَرَهْبَةً إِلَيْكَ، لَا مَلْجَأَ وَلَا مَنْجَا مِنْكَ إِلَّا إِلَيْكَ، آمَنْتُ بِكِتَابِكَ الَّذِي أَنْزَلْتَ، وَبِنَبِيِّكَ الَّذِي أَرْسَلْتَ",
    "اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ عِبَادَكَ",
    "اللَّهُمَّ إِنَّكَ خَلَقْتَ نَفْسِي وَأَنْتَ تَوَفَّاهَا، لَكَ مَمَاتُهَا وَمَحْيَاهَا، إِنْ أَحْيَيْتَهَا فَاحْفَظْهَا، وَإِنْ أَمَتَّهَا فَاغْفِرْ لَهَا، اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ",
    "اللَّهُمَّ إِنِّي أَعُوذُ بِوَجْهِكَ الْكَرِيمِ، وَكَلِمَاتِكَ التَّامَّاتِ، مِنْ شَرِّ مَا أَنْتَ آخِذٌ بِنَاصِيَتِهِ، اللَّهُمَّ أَنْتَ تَكْشِفُ الْمَغْرَمَ وَالْمَأْثَمَ، اللَّهُمَّ لَا يُهْزَمُ جُنْدُكَ، وَلَا يُخْلَفُ وَعْدُكَ، وَلَا يَنْفَعُ ذَا الْجَدِّ مِنْكَ الْجَدُّ، سُبْحَانَكَ وَبِحَمْدِكَ",
    "قرأت سورة الملك"
  ];

  List<int> repetitionCount = [
    1,
    3,
    1,
    1,
    1,
    33,
    33,
    34,
    1,
    1,
    1,
    1,
    1,
    3,
    1,
    1,
    1,
    33,
    33,
    34,
    1,
    1,
    1,
    1
  ];

  late AnimationController _eveningController;
  late Animation<double> _eveningAnimation;

  @override
  void initState() {
    super.initState();
    _loadEveningPreferences();
    _eveningController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _eveningAnimation = CurvedAnimation(
      parent: _eveningController,
      curve: Curves.easeInOut,
    );
    _eveningController.forward();
  }

  _loadEveningPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLightTheme = prefs.getBool('eveningTheme') ?? false; // default to true
      fontSize = prefs.getDouble('eveningFontSize') ?? 30; // استرجاع حجم الخط
      _loadEveningAzkar(); // تحميل الأذكار
    });
  }

  _loadEveningAzkar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedEveningAzkar = prefs.getStringList('eveningAzkar21');
    List<String>? storedRepetitionCounts =
        prefs.getStringList('repetitionCount');

    if (storedEveningAzkar != null) {
      eveningAzka21 = storedEveningAzkar;
    }

    if (storedRepetitionCounts != null) {
      repetitionCount =
          storedRepetitionCounts.map((e) => int.parse(e)).toList();
    }
  }

  _saveEveningThemePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('eveningTheme', value);
  }

  _saveEveningFontSize(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('eveningFontSize', value);
  }

  @override
  void dispose() {
    _eveningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isLightTheme ? Colors.white : Colors.black,
        actions: [
          Text(
            "أذكار الاستيقاظ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: isLightTheme ? Color(0xFF2C2C2C) : Color(0xFFEFEFEF),
            ),
          ),
          SizedBox(width: 3),
          Container(
            margin: EdgeInsets.only(right: 20, top: 10),
            child: Icon(
              shadows: [Shadow(color: Colors.redAccent, offset: Offset(3, 3))],
              Icons.access_alarms_outlined,
              size: 60,
              color: Colors.amber,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLightTheme
                ? [Colors.white.withOpacity(0.5), Colors.white]
                : [Colors.black, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: FadeTransition(
                  opacity: _eveningAnimation,
                  child: eveningAzka21.isEmpty
                      ? Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Icon(
                                Icons.check_circle_outlined,
                                color: Colors.greenAccent,
                                size: 50,
                              ),
                              Text(
                                "\nفضل الذكر: \n \" استجابة الدعاء، قبول الصلاة،\n والشكر لله على نعمة الحياة \"",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isLightTheme
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ]))
                      : SingleChildScrollView(
                          child: Column(
                            children:
                                List.generate(eveningAzka21.length, (index) {
                              if (repetitionCount[index] > 0) {
                                return _buildEveningZekrCard(
                                    eveningAzka21[index],
                                    repetitionCount[index]);
                              } else {
                                setState(() {});
                                return SizedBox();
                              }
                            }),
                          ),
                        )),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isLightTheme = !isLightTheme;
                        _saveEveningThemePreference(isLightTheme);
                        _eveningController.forward(from: 0);
                      });
                    },
                    icon: Icon(
                      isLightTheme ? Icons.dark_mode : Icons.light_mode,
                      color:
                          isLightTheme ? Colors.black : Colors.yellow.shade500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (fontSize > 20) {
                          fontSize -= 2; // تقليل الحجم
                          _saveEveningFontSize(fontSize); // حفظ الحجم الجديد
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_downward_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (fontSize < 35) {
                          fontSize += 2;
                          _saveEveningFontSize(fontSize); // حفظ الحجم الجديد
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_upward_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEveningZekrCard(String zikr, int agin) {
    int index = eveningAzka21.indexOf(zikr); // الحصول على الفهرس هنا

    return AnimatedContainer(
      onEnd: () {
        Colors.pink;
      },
      duration: Duration(milliseconds: 50),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: isLightTheme ? Colors.white : Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isLightTheme ? Colors.black26 : Colors.blueGrey,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          if (agin > 0) {
            setState(() {
              repetitionCount[index]--;
              if (repetitionCount[index] == 0) {
                eveningAzka21.removeAt(index);
                repetitionCount.removeAt(index);
              }
            });
          }
        },
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Share.share("*" +
                        zikr +
                        "*" +
                        "\n\n (( فَاذْكُرُونِي أَذْكُرْكُمْ ))\n *تطبيق ذكرني* \n\n\n *للتواصل مع المطور* : +967715206725 "); // مشاركة النص
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: isLightTheme
                            ? Colors.white
                            : Colors.black.withOpacity(0.4),
                        child: Icon(
                          Icons.share,
                          color: isLightTheme ? Colors.black : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                if (agin > 0)
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isLightTheme
                                ? Colors.teal
                                : Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isLightTheme
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: isLightTheme
                                          ? Colors.teal
                                          : Colors.white),
                                ),
                                child: Text(
                                  agin.toString(),
                                  style: TextStyle(
                                    color: isLightTheme
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                  )
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                zikr,
                style: TextStyle(
                  color: isLightTheme ? Colors.black : Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: zikr));
                  },
                  color: Colors.blue,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class remmbermor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _remmbermorning();
}

class _remmbermorning extends State<remmbermor>
    with SingleTickerProviderStateMixin {
  bool isLightTheme = false;
  bool isempty = false;
  double fontSize = 30;

  List<String> eveningAzka21 = [
    "الحمد لله الذي أحيانا بعد ما أماتنا وإليه النشور",
    "الحمد لله الذي عافاني في جسدي ورد علي روحي وأذن لي بذكره",
    "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير، سبحان الله، والحمد لله، ولا إله إلا الله، والله أكبر، ولا حول ولا قوة إلا بالله العلي العظيم",
    "اللهم بك أصبحنا، وبك أمسينا، وبك نحيا، وبك نموت، وإليك النشور",
    "اللهم إني أسألك علماً نافعاً، ورزقاً طيباً، وعملاً متقبلاً",
    "سبحان الله وبحمده: عدد خلقه، ورضا نفسه، وزنة عرشه، ومداد كلماته",
    "أصبحنا وأصبح الملك لله، والحمد لله، لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير"
  ];

  List<int> repetitionCount = [1, 1, 1, 1, 1, 3, 1];
  late AnimationController _eveningController;
  late Animation<double> _eveningAnimation;

  @override
  void initState() {
    super.initState();
    _loadEveningPreferences(); // تحميل التفضيلات
    _eveningController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _eveningAnimation = CurvedAnimation(
      parent: _eveningController,
      curve: Curves.easeInOut,
    );
    _eveningController.forward();
  }

  _loadEveningPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLightTheme = prefs.getBool('eveningTheme') ?? false; // default to true
      fontSize = prefs.getDouble('eveningFontSize') ?? 30; // استرجاع حجم الخط
      _loadEveningAzkar(); // تحميل الأذكار
    });
  }

  _loadEveningAzkar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedEveningAzkar = prefs.getStringList('eveningAzkar21');
    List<String>? storedRepetitionCounts =
        prefs.getStringList('repetitionCount');

    if (storedEveningAzkar != null) {
      eveningAzka21 = storedEveningAzkar;
    }

    if (storedRepetitionCounts != null) {
      repetitionCount =
          storedRepetitionCounts.map((e) => int.parse(e)).toList();
    }
  }

  _saveEveningThemePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('eveningTheme', value);
  }

  _saveEveningFontSize(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('eveningFontSize', value);
  }

  @override
  void dispose() {
    _eveningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isLightTheme ? Colors.white : Colors.black,
        actions: [
          Text(
            "أذكار الاستيقاظ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: isLightTheme ? Color(0xFF2C2C2C) : Color(0xFFEFEFEF),
            ),
          ),
          SizedBox(width: 3),
          Container(
            margin: EdgeInsets.only(right: 20, top: 10),
            child: Icon(
              shadows: [Shadow(color: Colors.redAccent, offset: Offset(3, 3))],
              Icons.access_alarms_outlined,
              size: 60,
              color: Colors.amber,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLightTheme
                ? [Colors.white.withOpacity(0.5), Colors.white]
                : [Colors.black, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: FadeTransition(
                  opacity: _eveningAnimation,
                  child: eveningAzka21.isEmpty
                      ? Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Icon(
                                Icons.check_circle_outlined,
                                color: Colors.greenAccent,
                                size: 50,
                              ),
                              Text(
                                "\nفضل الذكر: \n \" استجابة الدعاء، قبول الصلاة،\n والشكر لله على نعمة الحياة \"",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isLightTheme
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ]))
                      : SingleChildScrollView(
                          child: Column(
                            children:
                                List.generate(eveningAzka21.length, (index) {
                              if (repetitionCount[index] > 0) {
                                return _buildEveningZekrCard(
                                    eveningAzka21[index],
                                    repetitionCount[index]);
                              } else {
                                setState(() {});
                                return SizedBox(); // استخدم SizedBox بدلاً من Container
                              }
                            }),
                          ),
                        )),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isLightTheme = !isLightTheme;
                        _saveEveningThemePreference(isLightTheme);
                        _eveningController.forward(from: 0);
                      });
                    },
                    icon: Icon(
                      isLightTheme ? Icons.dark_mode : Icons.light_mode,
                      color:
                          isLightTheme ? Colors.black : Colors.yellow.shade500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (fontSize > 20) {
                          fontSize -= 2; // تقليل الحجم
                          _saveEveningFontSize(fontSize); // حفظ الحجم الجديد
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_downward_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (fontSize < 35) {
                          fontSize += 2; // زيادة الحجم
                          _saveEveningFontSize(fontSize); // حفظ الحجم الجديد
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_upward_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEveningZekrCard(String zikr, int agin) {
    int index = eveningAzka21.indexOf(zikr); // الحصول على الفهرس هنا

    return AnimatedContainer(
      onEnd: () {
        Colors.pink;
      },
      duration: Duration(milliseconds: 50),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: isLightTheme ? Colors.white : Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isLightTheme ? Colors.black26 : Colors.blueGrey,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          if (agin > 0) {
            setState(() {
              repetitionCount[index]--;
              if (repetitionCount[index] == 0) {
                eveningAzka21.removeAt(index);
                repetitionCount.removeAt(index);
              }
            });
          }
        },
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Share.share("*" +
                        zikr +
                        "*" +
                        "\n\n (( فَاذْكُرُونِي أَذْكُرْكُمْ ))\n *تطبيق ذكرني* \n\n\n *للتواصل مع المطور* : +967715206725 "); // مشاركة النص
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: isLightTheme
                            ? Colors.white
                            : Colors.black.withOpacity(0.4),
                        child: Icon(
                          Icons.share,
                          color: isLightTheme ? Colors.black : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                if (agin > 0) // تحقق مما إذا كان يجب عرض التكرار
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isLightTheme
                                ? Colors.teal
                                : Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // عرض عدد التكرارات بجانب الأذكار
                              Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isLightTheme
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: isLightTheme
                                          ? Colors.teal
                                          : Colors.white),
                                ),
                                child: Text(
                                  agin.toString(),
                                  style: TextStyle(
                                    color: isLightTheme
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                  )
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                zikr,
                style: TextStyle(
                  color: isLightTheme ? Colors.black : Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: zikr));
                  },
                  color: Colors.blue,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
