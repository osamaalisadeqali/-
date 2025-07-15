import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class remmber extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _remmber();
}

class _remmber extends State<remmber> with SingleTickerProviderStateMixin {
  bool isLightTheme = false;
  double fontSize = 30; // الحجم الحالي

  List<String> eveningAzka = [
    "اللّهُ لاَ إِلَـهَ إِلّا هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إلّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.",
    "آمَنَ الرَّسُولُ بِمَا أُنْزِلَ إِلَيْهِ مِنْ رَبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِنْ رُسُلِهِ ۚ وَقَالُوا سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ. لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ رَبَّنَا لَا تُؤَاخِذْنَا إِنْ نَسِينَا أَوْ أَخْطَأْنَا رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِنْ قَبْلِنَا رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا أَنْتَ مَوْلَانَا فَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ.",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ هُوَ اللهُ أَحَدٌ، اللهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ.",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّالنَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ.",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ.",
    "أَمْسَيْـنا وَأَمْسـى المـلكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذهِ اللَّـيْلَةِ وَخَـيرَ ما بَعْـدَهـا ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذهِ اللَّـيْلةِ وَشَرِّ ما بَعْـدَهـا ، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُبِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.",
    "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلّا أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ.",
    "رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً.",
    "اللّهُـمَّ إِنِّـي أَمسيتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلائكتَك ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك.",
    "اللّهُـمَّ ما أَمسى بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر.",
    "حَسْبِـيَ اللّهُ لا إلهَ إلّا هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم.",
    "بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم.",
    "اللّهُـمَّ بِكَ أَمْسَـينا وَبِكَ أَصْـبَحْنا، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ الْمَصِيرُ.",
    "أَمْسَيْنَا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.",
    "سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه.",
    "اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ.",
    "اللّهُـمَّ إِنّـي أَعـوذُ بِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُ بِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلّا أَنْـتَ.",
    "اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي.",
    "يا حَـيُّ يا قَيّـومُ بِـرَحْمَـتِكَ أَسْتَـغـيث ، أَصْلِـحْ لي شَـأْنـي كُلَّـه ، وَلا تَكِلـني إِلى نَفْـسي طَـرْفَةَ عَـين.",
    "أَمْسَيْنا وَأَمْسَى الْمُلْكُ للهِ رَبِّ الْعَالَمَيْنِ، اللَّهُمَّ إِنَّي أسْأَلُكَ خَيْرَ هَذَه اللَّيْلَةِ فَتْحُهَا وَنُصَرُّهَا، وَنورَهُا و برَكَتَهُا، وَهُداهُا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فيهِا وَشَرَّ مَا بَعْدَهَا.",
    "اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِـرْكِه ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم.",
    "أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق.",
    "اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ على نَبِيِّنَا مُحمَّد.",
    "اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئًا نَعْلَمُهُ ، وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُهُ.",
    "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنْ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنْ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ، وَقَهْرِ الرِّجَالِ.",
    "أسْتَغْفِرُ اللهَ العَظِيمَ الَّذِي لاَ إلَهَ إلاَّ هُوَ، الحَيُّ القَيُّومُ، وَأتُوبُ إلَيهِ.",
    "يَا رَبِّ , لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ , وَلِعَظِيمِ سُلْطَانِكَ.",
    "لا الهَ إلاّ اللهُ وَحْدَهُ لا شَريْكَ لهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ.",
    "اللَّهُمَّ أَنْتَ رَبِّي لا إِلَهَ إِلا أَنْتَ ، عَلَيْكَ تَوَكَّلْتُ ، وَأَنْتَ رَبُّ الْعَرْشِ الْكَرِيمِ , مَا شَاءَ اللَّهُ كَانَ ، وَمَا لَمْ يَشَأْ لَمْ يَكُنْ ، وَلا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ , أَعْلَمُ أَنَّ اللَّهَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، وَأَنَّ اللَّهَ قَدْ أَحَاطَ بِكُلِّ شَيْءٍ عِلْمًا , اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي ، وَمِنْ شَرِّ كُلِّ دَابَّةٍ أَنْتَ آخِذٌ بِنَاصِيَتِهَا ، إِنَّ رَبِّي عَلَى صِرَاطٍ مُسْتَقِيمٍ.",
    "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ"
  ];

  List<int> repetitionCount = [
    1,
    1,
    3,
    3,
    3,
    1,
    1,
    3,
    4,
    1,
    7,
    3,
    1,
    1,
    3,
    3,
    3,
    1,
    3,
    1,
    1,
    3,
    10,
    3,
    3,
    3,
    3,
    10,
    1,
    100
  ]; // مصفوفة للتكرار

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
    List<String>? storedEveningAzkar = prefs.getStringList('eveningAzkar');
    List<String>? storedRepetitionCounts =
        prefs.getStringList('eveningRepetitionCounts');

    if (storedEveningAzkar != null) {
      eveningAzka = storedEveningAzkar;
    }

    if (storedRepetitionCounts != null) {
      repetitionCount = storedRepetitionCounts
          .map((e) => int.parse(e))
          .toList(); // تحويل السلاسل إلى أعداد صحيحة
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

  _saveEveningAzkar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('eveningAzkar', eveningAzka);
    prefs.setStringList(
        'eveningRepetitionCounts',
        repetitionCount
            .map((e) => e.toString())
            .toList()); // تحويل الأعداد إلى سلاسل
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
            "أذكار المساء",
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
              Icons.nights_stay_outlined,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(eveningAzka.length, (index) {
                      if (repetitionCount[index] > 0) {
                        return _buildEveningZekrCard(
                            eveningAzka[index], repetitionCount[index]);
                      } else {
                        return SizedBox(); // استخدم SizedBox بدلاً من Container
                      }
                    }),
                  ),
                ),
              ),
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
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddEveningZikrPage(onAdd: _addEveningZikr)),
                      );
                    },
                    color: isLightTheme
                        ? Colors.black.withOpacity(.7)
                        : Colors.white.withOpacity(.5),
                    iconSize: 35,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade800,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => remmber1()),
                      );
                    },
                    color: Colors.white,
                    iconSize: 35,
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
    int index = eveningAzka.indexOf(zikr); // الحصول على الفهرس هنا

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
              // إذا كان التكرار صفرًا، يمكن حذف الذكر من القائمتين
              if (repetitionCount[index] == 0) {
                eveningAzka.removeAt(index);
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

  void _addEveningZikr(String newZikr, int newAgin) {
    setState(() {
      eveningAzka.add(newZikr);
      repetitionCount.add(newAgin);
      _saveEveningAzkar(); // حفظ الأذكار الجديدة
    });
  }
}

class remmber1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _remmber1();
}

class _remmber1 extends State<remmber1> with SingleTickerProviderStateMixin {
  bool isLightTheme = true;
  double fontSize = 20;

  List<String> eveningAzka = [
    "اللّهُ لاَ إِلَـهَ إِلّا هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إلّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.",
    "آمَنَ الرَّسُولُ بِمَا أُنْزِلَ إِلَيْهِ مِنْ رَبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِنْ رُسُلِهِ ۚ وَقَالُوا سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ. لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ رَبَّنَا لَا تُؤَاخِذْنَا إِنْ نَسِينَا أَوْ أَخْطَأْنَا رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِنْ قَبْلِنَا رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا أَنْتَ مَوْلَانَا فَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ.",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ هُوَ اللهُ أَحَدٌ، اللهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ.",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّالنَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ.",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ.",
    "أَمْسَيْـنا وَأَمْسـى المـلكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذهِ اللَّـيْلَةِ وَخَـيرَ ما بَعْـدَهـا ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذهِ اللَّـيْلةِ وَشَرِّ ما بَعْـدَهـا ، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُبِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.",
    "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلّا أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ.",
    "رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً.",
    "اللّهُـمَّ إِنِّـي أَمسيتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلائكتَك ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك.",
    "اللّهُـمَّ ما أَمسى بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر.",
    "حَسْبِـيَ اللّهُ لا إلهَ إلّا هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم.",
    "بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم.",
    "اللّهُـمَّ بِكَ أَمْسَـينا وَبِكَ أَصْـبَحْنا، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ الْمَصِيرُ.",
    "أَمْسَيْنَا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.",
    "سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه.",
    "اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ.",
    "اللّهُـمَّ إِنّـي أَعـوذُ بِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُ بِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلّا أَنْـتَ.",
    "اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي.",
    "يا حَـيُّ يا قَيّـومُ بِـرَحْمَـتِكَ أَسْتَـغـيث ، أَصْلِـحْ لي شَـأْنـي كُلَّـه ، وَلا تَكِلـني إِلى نَفْـسي طَـرْفَةَ عَـين.",
    "أَمْسَيْنا وَأَمْسَى الْمُلْكُ للهِ رَبِّ الْعَالَمَيْنِ، اللَّهُمَّ إِنَّي أسْأَلُكَ خَيْرَ هَذَه اللَّيْلَةِ فَتْحُهَا وَنُصَرُّهَا، وَنورَهُا و برَكَتَهُا، وَهُداهُا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فيهِا وَشَرَّ مَا بَعْدَهَا.",
    "اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِـرْكِه ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم.",
    "أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق.",
    "اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ على نَبِيِّنَا مُحمَّد.",
    "اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئًا نَعْلَمُهُ ، وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُهُ.",
    "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنْ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنْ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ، وَقَهْرِ الرِّجَالِ.",
    "أسْتَغْفِرُ اللهَ العَظِيمَ الَّذِي لاَ إلَهَ إلاَّ هُوَ، الحَيُّ القَيُّومُ، وَأتُوبُ إلَيهِ.",
    "يَا رَبِّ , لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ , وَلِعَظِيمِ سُلْطَانِكَ.",
    "لا الهَ إلاّ اللهُ وَحْدَهُ لا شَريْكَ لهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ.",
    "اللَّهُمَّ أَنْتَ رَبِّي لا إِلَهَ إِلا أَنْتَ ، عَلَيْكَ تَوَكَّلْتُ ، وَأَنْتَ رَبُّ الْعَرْشِ الْكَرِيمِ , مَا شَاءَ اللَّهُ كَانَ ، وَمَا لَمْ يَشَأْ لَمْ يَكُنْ ، وَلا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ , أَعْلَمُ أَنَّ اللَّهَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، وَأَنَّ اللَّهَ قَدْ أَحَاطَ بِكُلِّ شَيْءٍ عِلْمًا , اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي ، وَمِنْ شَرِّ كُلِّ دَابَّةٍ أَنْتَ آخِذٌ بِنَاصِيَتِهَا ، إِنَّ رَبِّي عَلَى صِرَاطٍ مُسْتَقِيمٍ.",
    "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ"
  ];

  List<int> repetitionCount = [
    1,
    1,
    3,
    3,
    3,
    1,
    1,
    3,
    4,
    1,
    7,
    3,
    1,
    1,
    3,
    3,
    3,
    1,
    3,
    1,
    1,
    3,
    10,
    3,
    3,
    3,
    3,
    10,
    1,
    100
  ];

  late AnimationController _eveningController;
  late Animation<double> _eveningAnimation;

  @override
  void initState() {
    super.initState();
    _loadEveningPreferences(); // تحميل التفضيلات
    _eveningController = AnimationController(
      duration: const Duration(milliseconds: 500),
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
      isLightTheme = prefs.getBool('eveningTheme') ?? true; // default to true
      fontSize = prefs.getDouble('eveningFontSize') ?? 20; // استرجاع حجم الخط
      _loadEveningAzkar(); // تحميل الأذكار
    });
  }

  _loadEveningAzkar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedEveningAzkar = prefs.getStringList('eveningAzkar');
    List<String>? storedRepetitionCounts =
        prefs.getStringList('eveningRepetitionCounts');

    if (storedEveningAzkar != null) {
      eveningAzka = storedEveningAzkar;
    }

    if (storedRepetitionCounts != null) {
      repetitionCount =
          storedRepetitionCounts.map((e) => int.parse(e)).toList();
    }
  }

  _saveEveningAzkar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('eveningAzkar', eveningAzka);
    prefs.setStringList('eveningRepetitionCounts',
        repetitionCount.map((e) => e.toString()).toList());
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
        backgroundColor: isLightTheme ? Colors.teal : Colors.deepPurple,
        actions: [
          Container(
            child: Text(
              " حذف ذكر مساء",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(right: 5),
          ),
          Container(
            margin: EdgeInsets.only(right: 15, top: 20),
            child: Icon(
              size: 30,
              Icons.folder_delete_sharp,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: Container(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54.withOpacity(.8), // لون الخلفية مع شفافية
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Expanded(
                child: FadeTransition(
                  opacity: _eveningAnimation,
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(eveningAzka.length, (index) {
                        if (repetitionCount[index] > 0) {
                          return _buildEveningZekrCard(
                            eveningAzka[index],
                            repetitionCount[index],
                            index, // تمرير الفهرس لتحديد الذكر
                          );
                        } else {
                          return SizedBox(); // استخدم SizedBox بدلاً من Container
                        }
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEveningZekrCard(String zikr, int agin, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
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
              // إذا كان التكرار صفرًا، يمكن حذف الذكر من القائمتين
              if (repetitionCount[index] == 0) {
                _removeZikr(index);
              }
            });
          }
        },
        child: Column(
          children: [
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
            if (agin > 0) // تحقق مما إذا كان يجب عرض التكرار
              Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 40,
                          ),
                          onPressed: () {
                            _removeZikr(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _removeZikr(int index) {
    setState(() {
      eveningAzka.removeAt(index);
      repetitionCount.removeAt(index);
    });
    _saveEveningAzkar();
  }
}

class AddEveningZikrPage extends StatelessWidget {
  final Function(String, int) onAdd;

  AddEveningZikrPage({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    String newZikr = '';
    int newAgin = 1;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            child: Text(
              "إضافة ذكر المساء",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(right: 5),
          ),
          Container(
            margin: EdgeInsets.only(right: 12, top: 20),
            child: Icon(
              Icons.add_task,
              size: 25,
              color: Colors.blue.shade100,
            ),
          )
        ],
        backgroundColor: Colors.deepPurple,
        elevation: 5,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField("الذكر", (value) {
                      newZikr = value;
                    }, isMultiLine: true), // تمرير isMultiLine كـ true
                    SizedBox(height: 20),
                    _buildTextField("التكرار", (value) {
                      newAgin = int.tryParse(value) ?? 1;
                    },
                        isNumber: true,
                        isMultiLine: false), // تمرير isMultiLine كـ false
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                if (newZikr.isNotEmpty) {
                  onAdd(newZikr, newAgin);
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "إضافة",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged,
      {bool isNumber = false, bool isMultiLine = false}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // جعل الخلفية شفافة قليلاً
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        height: isMultiLine
            ? 200
            : 60, // تعيين ارتفاع أكبر للذكر وارتفاع أقل للتكرار
        child: TextField(
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          maxLines:
              isMultiLine ? null : 1, // يسمح بالتمرير إذا كانت متعددة الأسطر
          minLines: isMultiLine ? 10 : 1, // تعيين الحد الأدنى لعدد الأسطر
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.teal),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: onChanged,
          style: TextStyle(fontSize: 18), // زيادة حجم النص
        ),
      ),
    );
  }
}

class remmbersun extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RemmberSunState();
}

class _RemmberSunState extends State<remmbersun>
    with SingleTickerProviderStateMixin {
  bool isLightTheme = true;
  double fontSize = 30;

  List<String> morningAzkar = [
    "اللّهُ لاَ إِلَـهَ إِلّا هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إلّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ هُوَ اللهُ أَحَدٌ، اللهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ.",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّالنَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ",
    "أَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذا اليوم وَخَـيرَ ما بَعْـدَه ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذا اليوم وَشَرِّ ما بَعْـدَه، رَبِّ أَعـوذُ بِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.",
    "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُ بِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ .",
    "رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً.",
    "اللّهُـمَّ إِنِّـي أَصْبَـحْتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلائكتَك ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلّا أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك.",
    "اللّهُـمَّ ما أَصْبَـَحَ بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر.",
    "حَسْبِـيَ اللّهُ لا إلهَ إلّا هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم.",
    "بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم.",
    "اللّهُـمَّ بِكَ أَصْـبَحْنا وَبِكَ أَمْسَـينا ، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ النُّـشُور.",
    "أَصْبَـحْـنا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.",
    "سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه.",
    "اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ.",
    "اللّهُـمَّ إِنّـي أَعـوذُ بِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُ بِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلّا أَنْـتَ.",
    "اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي.",
    "يا حَـيُّ يا قَيّـومُ بِـرَحْمَـتِكَ أَسْتَـغـيث ، أَصْلِـحْ لي شَـأْنـي كُلَّـه ، وَلا تَكِلـني إِلى نَفْـسي طَـرْفَةَ عَـين.",
    "أَصْبَـحْـنا وَأَصبحَ المُـلكُ للهِ رَبِّ العـالَمـين ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ خَـيْرَ هـذا الـيَوْم ، فَـتْحَهُ ، وَنَصْـرَهُ ، وَنـورَهُ وَبَـرَكَتَـهُ ، وَهُـداهُ ، وَأَعـوذُ بِـكَ مِـنْ شَـرِّ ما فـيهِ وَشَـرِّ ما بَعْـدَه.",
    "اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِـرْكِه ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم.",
    "أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق.",
    "اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ على نَبِيِّنَا مُحمَّد.",
    "اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئاً نَعْلَمُهُ ، وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُهُ.",
    "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنْ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنْ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ، وَقَهْرِ الرِّجَالِ.",
    "أسْتَغْفِرُ اللهَ العَظِيمَ الَّذِي لاَ إلَهَ إلاَّ هُوَ، الحَيُّ القَيُّومُ، وَأتُوبُ إلَيهِ.",
    "يَا رَبِّ , لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ , وعظيم سُلْطَانِكَ."
        "لا إله إلّا الله وَحْدَهُ لا شَريْكَ لهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ.",
    "اللَّهُمَّ أَنْتَ رَبِّي لا إِلَهَ إِلا أَنْتَ ، عَلَيْكَ تَوَكَّلْتُ ، وَأَنْتَ رَبُّ الْعَرْشِ الْكَرِيمِ , مَا شَاءَ اللَّهُ كَانَ ، وَمَا لَمْ يَشَأْ لَمْ يَكُنْ ، وَلا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ , أَعْلَمُ أَنَّ اللَّهَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، وَأَنَّ الله قَدْ أَحَاطَ بِكُلِّ شَيْءٍ عِلْمًا , اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي ، وَمِنْ شَرِّ كُلِّ دَابَّةٍ أَنْتَ آخِذٌ بِنَاصِيَتِهَا ، إِنَّ رَبِّي عَلَى صِرَاطٍ مُسْتَقِيمٍ.",
    "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ"
  ];

  List<int> repetitionCounts = [
    1,
    3,
    3,
    3,
    1,
    1,
    3,
    4,
    1,
    7,
    3,
    1,
    1,
    3,
    3,
    3,
    1,
    3,
    1,
    1,
    3,
    10,
    3,
    3,
    3,
    3,
    1,
    100
  ];

  late AnimationController _morningController;

  @override
  void initState() {
    super.initState();
    _loadMorningPreferences();
    _morningController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  _loadMorningPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLightTheme = prefs.getBool('morningTheme') ?? true;
      fontSize = prefs.getDouble('morningFontSize') ?? 30;
      _loadMorningAzkar();
    });
  }

  _loadMorningAzkar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedMorningAzkar = prefs.getStringList('morningAzkar');
    List<String>? storedRepetitionCounts =
        prefs.getStringList('morningRepetitionCounts');

    if (storedMorningAzkar != null) {
      morningAzkar = storedMorningAzkar;
    }

    if (storedRepetitionCounts != null) {
      repetitionCounts =
          storedRepetitionCounts.map((e) => int.parse(e)).toList();
    }
  }

  _saveMorningThemePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('morningTheme', value);
  }

  _saveMorningFontSize(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('morningFontSize', value);
  }

  _saveMorningAzkar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('morningAzkar', morningAzkar);
    prefs.setStringList('morningRepetitionCounts',
        repetitionCounts.map((e) => e.toString()).toList());
  }

  @override
  void dispose() {
    _morningController.dispose();
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
            "أذكار الصباح",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: isLightTheme ? Colors.black : Colors.white,
            ),
          ),
          SizedBox(width: 3),
          Container(
            margin: EdgeInsets.only(right: 20, top: 10),
            child: Icon(
              shadows: [Shadow(color: Colors.redAccent, offset: Offset(3, 3))],
              Icons.wb_sunny_outlined,
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
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(morningAzkar.length, (index) {
                    return _buildMorningZekrCard(
                        morningAzkar[index], repetitionCounts[index], index);
                  }),
                ),
              ),
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
                        _saveMorningThemePreference(isLightTheme);
                      });
                    },
                    icon: Icon(
                      isLightTheme ? Icons.dark_mode : Icons.light_mode,
                      color:
                          isLightTheme ? Colors.black : Colors.yellow.shade600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (fontSize > 20) {
                          fontSize -= 2;
                          _saveMorningFontSize(fontSize);
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
                          _saveMorningFontSize(fontSize);
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_upward_outlined),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddZikrPage(onAdd: _addMorningZikr)),
                      );
                    },
                    color: isLightTheme
                        ? Colors.black.withOpacity(.5)
                        : Colors.white.withOpacity(.7),
                    iconSize: 35,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade800,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => remmberMorning1()),
                      );
                    },
                    color: Colors.white,
                    iconSize: 35,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMorningZekrCard(String zikr, int agin, int index) {
    return GestureDetector(
      onTap: () {
        if (agin > 0) {
          setState(() {
            repetitionCounts[index]--;
            if (repetitionCounts[index] == 0) {
              _morningController.forward().then((_) {
                setState(() {
                  morningAzkar.removeAt(index);
                  repetitionCounts.removeAt(index);
                });
                _morningController.reset();
              });
            }
          });
        }
      },
      child: AnimatedOpacity(
        opacity: repetitionCounts[index] > 0 ? 1.0 : 0.0,
        duration: Duration(milliseconds: 400),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: Offset(0, 0.2),
          ).animate(CurvedAnimation(
            parent: _morningController,
            curve: Curves.fastEaseInToSlowEaseOut,
          )),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
        ),
      ),
    );
  }

  void _addMorningZikr(String newZikr, int newAgin) {
    setState(() {
      morningAzkar.add(newZikr);
      repetitionCounts.add(newAgin);
      _saveMorningAzkar();
    });
  }
}

class AddZikrPage extends StatelessWidget {
  final Function(String, int) onAdd;

  AddZikrPage({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    String newZikr = '';
    int newAgin = 1;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            child: Text(
              "إضافة ذكر الصباح",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(right: 5),
          ),
          Container(
            margin: EdgeInsets.only(right: 12, top: 20),
            child: Icon(
              Icons.add_task,
              size: 25,
              color: Colors.blue.shade100,
            ),
          )
        ],
        backgroundColor: Colors.deepPurple,
        elevation: 5,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField("الذكر", (value) {
                      newZikr = value;
                    }, isMultiLine: true), // تمرير isMultiLine كـ true
                    SizedBox(height: 20),
                    _buildTextField("التكرار", (value) {
                      newAgin = int.tryParse(value) ?? 1;
                    },
                        isNumber: true,
                        isMultiLine: false), // تمرير isMultiLine كـ false
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                if (newZikr.isNotEmpty) {
                  onAdd(newZikr, newAgin);
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "إضافة",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged,
      {bool isNumber = false, bool isMultiLine = false}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // جعل الخلفية شفافة قليلاً
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        height: isMultiLine
            ? 200
            : 60, // تعيين ارتفاع أكبر للذكر وارتفاع أقل للتكرار
        child: TextField(
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          maxLines:
              isMultiLine ? null : 1, // يسمح بالتمرير إذا كانت متعددة الأسطر
          minLines: isMultiLine ? 10 : 1, // تعيين الحد الأدنى لعدد الأسطر
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.teal),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: onChanged,
          style: TextStyle(fontSize: 18), // زيادة حجم النص
        ),
      ),
    );
  }
}

class remmberMorning1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _remmberMorning1();
}

class _remmberMorning1 extends State<remmberMorning1>
    with SingleTickerProviderStateMixin {
  bool isLightTheme = true;
  double fontSize = 20; // الحجم الحالي

  List<String> morningAzkar = [
    "اللّهُ لاَ إِلَـهَ إِلّا هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إلّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ هُوَ اللهُ أَحَدٌ، اللهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ.",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّالنَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ",
    "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ",
    "أَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذا اليوم وَخَـيرَ ما بَعْـدَه ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذا اليوم وَشَرِّ ما بَعْـدَه، رَبِّ أَعـوذُ بِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.",
    "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُ بِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ .",
    "رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً.",
    "اللّهُـمَّ إِنِّـي أَصْبَـحْتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلائكتَك ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلّا أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك.",
    "اللّهُـمَّ ما أَصْبَـَحَ بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر.",
    "حَسْبِـيَ اللّهُ لا إلهَ إلّا هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم.",
    "بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم.",
    "اللّهُـمَّ بِكَ أَصْـبَحْنا وَبِكَ أَمْسَـينا ، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ النُّـشُور.",
    "أَصْبَـحْـنا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.",
    "سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه.",
    "اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ.",
    "اللّهُـمَّ إِنّـي أَعـوذُ بِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُ بِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلّا أَنْـتَ.",
    "اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي.",
    "يا حَـيُّ يا قَيّـومُ بِـرَحْمَـتِكَ أَسْتَـغـيث ، أَصْلِـحْ لي شَـأْنـي كُلَّـه ، وَلا تَكِلـني إِلى نَفْـسي طَـرْفَةَ عَـين.",
    "أَصْبَـحْـنا وَأَصبحَ المُـلكُ للهِ رَبِّ العـالَمـين ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ خَـيْرَ هـذا الـيَوْم ، فَـتْحَهُ ، وَنَصْـرَهُ ، وَنـورَهُ وَبَـرَكَتَـهُ ، وَهُـداهُ ، وَأَعـوذُ بِـكَ مِـنْ شَـرِّ ما فـيهِ وَشَـرِّ ما بَعْـدَه.",
    "اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِـرْكِه ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم.",
    "أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق.",
    "اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ على نَبِيِّنَا مُحمَّد.",
    "اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئاً نَعْلَمُهُ ، وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُهُ.",
    "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنْ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنْ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ، وَقَهْرِ الرِّجَالِ.",
    "أسْتَغْفِرُ اللهَ العَظِيمَ الَّذِي لاَ إلَهَ إلاَّ هُوَ، الحَيُّ القَيُّومُ، وَأتُوبُ إلَيهِ.",
    "يَا رَبِّ , لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ , وعظيم سُلْطَانِكَ."
        "لا إله إلّا الله وَحْدَهُ لا شَريْكَ لهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ.",
    "اللَّهُمَّ أَنْتَ رَبِّي لا إِلَهَ إِلا أَنْتَ ، عَلَيْكَ تَوَكَّلْتُ ، وَأَنْتَ رَبُّ الْعَرْشِ الْكَرِيمِ , مَا شَاءَ اللَّهُ كَانَ ، وَمَا لَمْ يَشَأْ لَمْ يَكُنْ ، وَلا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ , أَعْلَمُ أَنَّ اللَّهَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، وَأَنَّ الله قَدْ أَحَاطَ بِكُلِّ شَيْءٍ عِلْمًا , اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي ، وَمِنْ شَرِّ كُلِّ دَابَّةٍ أَنْتَ آخِذٌ بِنَاصِيَتِهَا ، إِنَّ رَبِّي عَلَى صِرَاطٍ مُسْتَقِيمٍ.",
    "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ"
  ];

  List<int> repetitionCounts = [
    1,
    3,
    3,
    3,
    1,
    1,
    3,
    4,
    1,
    7,
    3,
    1,
    1,
    3,
    3,
    3,
    1,
    3,
    1,
    1,
    3,
    10,
    3,
    3,
    3,
    3,
    1,
    100
  ];
  late AnimationController _morningController;
  late Animation<double> _morningAnimation;

  @override
  void initState() {
    super.initState();
    _loadMorningPreferences(); // تحميل التفضيلات
    _morningController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _morningAnimation = CurvedAnimation(
      parent: _morningController,
      curve: Curves.easeInOut,
    );
    _morningController.forward();
  }

  _loadMorningPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLightTheme = prefs.getBool('morningTheme') ?? true; // default to true
      fontSize = prefs.getDouble('morningFontSize') ?? 20; // استرجاع حجم الخط
      _loadMorningAzkar(); // تحميل الأذكار
    });
  }

  _loadMorningAzkar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedMorningAzkar = prefs.getStringList('morningAzkar');
    List<String>? storedRepetitionCounts =
        prefs.getStringList('morningRepetitionCounts');

    if (storedMorningAzkar != null) {
      morningAzkar = storedMorningAzkar;
    }

    if (storedRepetitionCounts != null) {
      repetitionCounts = storedRepetitionCounts
          .map((e) => int.parse(e))
          .toList(); // تحويل السلاسل إلى أعداد صحيحة
    }
  }

  _saveMorningAzkar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('morningAzkar', morningAzkar);
    prefs.setStringList(
        'morningRepetitionCounts',
        repetitionCounts
            .map((e) => e.toString())
            .toList()); // تحويل الأعداد إلى سلاسل
  }

  @override
  void dispose() {
    _morningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isLightTheme ? Colors.teal : Colors.deepPurple,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Text(
              " حذف ذكر صباح",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15, top: 20),
            child: Icon(
              size: 30,
              Icons.folder_delete_sharp,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black54.withOpacity(.6), // لون الخلفية مع شفافية
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: FadeTransition(
                opacity: _morningAnimation,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(morningAzkar.length, (index) {
                      if (repetitionCounts[index] > 0) {
                        return _buildMorningZekrCard(
                          morningAzkar[index],
                          repetitionCounts[index],
                          index, // تمرير الفهرس لتحديد الذكر
                        );
                      } else {
                        return SizedBox(); // استخدم SizedBox بدلاً من Container
                      }
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMorningZekrCard(String zikr, int agin, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
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
              repetitionCounts[index]--;
              // إذا كان التكرار صفرًا، يمكن حذف الذكر من القائمتين
              if (repetitionCounts[index] == 0) {
                _removeZikr(index);
              }
            });
          }
        },
        child: Column(
          children: [
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
            if (agin > 0) // تحقق مما إذا كان يجب عرض التكرار
              Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 40,
                          ),
                          onPressed: () {
                            _removeZikr(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _removeZikr(int index) {
    setState(() {
      morningAzkar.removeAt(index);
      repetitionCounts.removeAt(index);
    });
    _saveMorningAzkar(); // حفظ التحديثات في SharedPreferences
  }
}

class remmbermasged extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _remmbermasged();
}

class _remmbermasged extends State<remmbermasged>
    with SingleTickerProviderStateMixin {
  bool isLightTheme = false;
  bool isempty = false;
  double fontSize = 30;

  Map<String, Map<String, int>> prayerAzkaar = {
    "الفجر": {
      "لا الهَ إلاّ اللهُ وَحْدَهُ لا شَريْكَ لهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ":
          10,
      "أَسْتَغْفِرُ اللّهَ": 33,
      "اللّهُ لاَ إِلَـهَ إِلّا هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إلّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ":
          1,
      "سبحان الله": 33,
      "الحمد لله": 33,
      "الله أكبر": 33,
      "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ هُوَ اللهُ أَحَدٌ، اللهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَد":
          3,
      "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّالنَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ":
          3,
      "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ \n\nقُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ":
          3
    },
    "الظهر": {
      "أَسْتَغْفِرُ اللّهَ": 33,
      "اللّهُ لاَ إِلَـهَ إِلّا هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إلّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ":
          1,
      "سبحان الله": 33,
      "الحمد لله": 33,
      "الله أكبر": 33,
      "قُلْ هُوَ اللهُ أَحَدٌ، اللهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَد":
          1,
      "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّالنَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ":
          1,
      "قُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ":
          1
    },
    "العصر": {
      "أَسْتَغْفِرُ اللّهَ": 33,
      "اللّهُ لاَ إِلَـهَ إِلّا هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إلّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ":
          1,
      "سبحان الله": 33,
      "الحمد لله": 33,
      "الله أكبر": 33,
      "قُلْ هُوَ اللهُ أَحَدٌ، اللهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَد":
          1,
      "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّالنَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ":
          1,
      "قُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ":
          1
    },
    "المغرب": {
      "لا الهَ إلاّ اللهُ وَحْدَهُ لا شَريْكَ لهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ":
          10,
      "أَسْتَغْفِرُ اللّهَ": 33,
      "اللّهُ لاَ إِلَـهَ إِلّا هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إلّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ":
          1,
      "سبحان الله": 33,
      "الحمد لله": 33,
      "الله أكبر": 33,
      "قُلْ هُوَ اللهُ أَحَدٌ، اللهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَد":
          3,
      "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّالنَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ":
          3,
      "قُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ":
          3
    },
    "العشاء": {
      "أَسْتَغْفِرُ اللّهَ": 33,
      "اللّهُ لاَ إِلَـهَ إِلّا هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إلّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ":
          1,
      "سبحان الله": 33,
      "الحمد لله": 33,
      "الله أكبر": 33,
      "قُلْ هُوَ اللهُ أَحَدٌ، اللهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَد":
          1,
      "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّالنَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ":
          1,
      "قُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ":
          1
    },
  };

  late AnimationController _eveningController;
  late Animation<double> _eveningAnimation;
  int currentPrayerIndex = 0; // لتتبع الفرض الحالي
  late PageController _pageController; // للتحكم في PageView

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

    // تهيئة PageController
    _pageController = PageController(initialPage: currentPrayerIndex);
  }

  @override
  void dispose() {
    _eveningController.dispose();
    _pageController.dispose(); // التخلص من PageController
    super.dispose();
  }

  _loadEveningPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLightTheme = prefs.getBool('eveningTheme') ?? false; // default to true
      fontSize = prefs.getDouble('eveningFontSize') ?? 30; // استرجاع حجم الخط
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isLightTheme ? Colors.white : Colors.black,
        actions: [
          Text(
            "أذكار الصلاة",
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
              Icons.mosque_outlined,
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
            Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                height: 50,
                color: isLightTheme ? Colors.white : Colors.black,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: prayerAzkaar.length,
                  itemBuilder: (context, index) {
                    String prayerName = prayerAzkaar.keys.toList()[index];
                    bool isCurrent = index == currentPrayerIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPrayerIndex = index;
                          _pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? (isLightTheme
                                  ? Colors.teal
                                  : Colors.deepPurpleAccent)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            prayerName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isCurrent
                                  ? Colors.white
                                  : (isLightTheme
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController, // ربط PageController
                onPageChanged: (index) {
                  setState(() {
                    currentPrayerIndex = index;
                  });
                },
                itemCount: prayerAzkaar.length,
                itemBuilder: (context, index) {
                  String prayerName = prayerAzkaar.keys.toList()[index];
                  Map<String, int> azkaar = prayerAzkaar[prayerName]!;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ...azkaar.entries.map((entry) {
                          String zikr = entry.key;
                          int agin = entry.value;

                          return _buildEveningZekrCard(zikr, agin, prayerName);
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
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

  Widget _buildEveningZekrCard(String zikr, int agin, String prayerName) {
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
              prayerAzkaar[prayerName]![zikr] = agin - 1;
              if (prayerAzkaar[prayerName]![zikr] == 0) {
                prayerAzkaar[prayerName]!.remove(zikr);
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

class remmberanydikr extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _remmberanydikr();
}

class _remmberanydikr extends State<remmberanydikr>
    with SingleTickerProviderStateMixin {
  bool isLightTheme = false;
  bool isempty = false;
  double fontSize = 30;

  Map<String, Map<String, int>> prayerAzkaar = {
    "الذهاب إلى المسجد": {
      "اللَّهُمَّ اجْعَلْ فِي قَلْبِي نُورًا، وَفِي لِسَانِي نُورًا، وَاجْعَلْ فِي سَمْعِي نُورًا، وَاجْعَلْ فِي بَصَرِي نُورًا، وَاجْعَلْ مِنْ خَلْفِي نُورًا، وَمِنْ أَمَامِي نُورًا، وَاجْعَلْ مِنْ فَوْقِي نُورًا، وَمِنْ تَحْتِي نُورًا، اللَّهُمَّ أَعْطِنِي نُورًا":
          1,
      "اللَّهُمَّ إِنِّي أَسْأَلُكَ بِحَقِّ السَّائِلِينَ عَلَيْكَ، وَبِحَقِّ مَخْرَجِي هَذَا، إِنِّي لَمْ أَخْرُجْ أَشَرًا، وَلَا بَطَرًا، وَلَا رِيَاءً، وَلَا سُمْعَةً، خَرَجْتُ اتِّقَاءَ سُخْطِكَ، وَابْتِغَاءَ مَرْضَاتِكَ، فَأَسْأَلُكَ أَنْ تُعِيذَنِي مِنَ النَّارِ، وَأَنْ تَغْفِرَ لِي ذُنُوبِي، إِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ":
          1,
    },
    "عند هطول الأمطار": {
      "اللَّهُمَّ صَيِّبًا نَافِعًا": 3,
      "اللَّهُمَّ حَوَالَيْنَا وَلَا عَلَيْنَا، اللَّهُمَّ عَلَى الْآكَامِ وَالْجِبَالِ وَالظِّرَابِ وَالْأَوْدِيَةِ وَمَنَابِتِ الشَّجَرِ":
          1,
      "مُطِرْنَا بِفَضْلِ اللَّهِ وَرَحْمَتِهِ": 1,
    },
    "عند سماع الرعد": {
      "سُبْحَانَ الَّذِي يُسَبِّحُ الرَّعْدُ بِحَمْدِهِ وَالْمَلَائِكَةُ مِنْ خِيفَتِهِ":
          3,
      "اللَّهُمَّ لَا تَقْتُلْنَا بِغَضَبِكَ، وَلَا تُهْلِكْنَا بِعَذَابِكَ، وَعَافِنَا قَبْلَ ذَلِكَ":
          1,
    },
    "عند الخروج من المنزل": {
      "بِسْمِ اللَّهِ تَوَكَّلْتُ عَلَى اللَّهِ، لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ":
          1,
      "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ أَنْ أَضِلَّ أَوْ أُضَلَّ، أَوْ أَزِلَّ أَوْ أُزَلَّ، أَوْ أَظْلِمَ أَوْ أُظْلَمَ، أَوْ أَجْهَلَ أَوْ يُجْهَلَ عَلَيَّ":
          1,
    },
    "عند دخول المنزل": {
      "بِسْمِ اللَّهِ وَلَجْنَا، وَبِسْمِ اللَّهِ خَرَجْنَا، وَعَلَى اللَّهِ رَبِّنَا تَوَكَّلْنَا":
          1,
      "اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَ الْمَوْلِجِ وَخَيْرَ الْمَخْرَجِ، بِسْمِ اللَّهِ وَلَجْنَا، وَبِسْمِ اللَّهِ خَرَجْنَا، وَعَلَى اللَّهِ رَبِّنَا تَوَكَّلْنَا":
          1,
    },
    "عند النوم": {
      "بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي، وَبِكَ أَرْفَعُهُ، إِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِينَ":
          1,
      "اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ عِبَادَكَ": 1,
    },
    "عند سماع الأذان": {
      "اللَّهُمَّ رَبَّ هَذِهِ الدَّعْوَةِ التَّامَّةِ، وَالصَّلَاةِ الْقَائِمَةِ، آتِ مُحَمَّدًا الْوَسِيلَةَ وَالْفَضِيلَةَ، وَابْعَثْهُ مَقَامًا مَحْمُودًا الَّذِي وَعَدْتَهُ":
          1,
      "أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ، رَضِيتُ بِاللَّهِ رَبًّا، وَبِمُحَمَّدٍ رَسُولًا، وَبِالْإِسْلَامِ دِينًا":
          1,
    },
    "عند دخول الخلاء": {
      "بِسْمِ اللَّهِ، اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبْثِ وَالْخَبَائِثِ":
          1,
    },
    "عند الخروج من الخلاء": {
      "غُفْرَانَكَ، الْحَمْدُ لِلَّهِ الَّذِي أَذْهَبَ عَنِّي الْأَذَى وَعَافَانِي":
          1,
    },
    "عند لبس الثوب الجديد": {
      "الْحَمْدُ لِلَّهِ الَّذِي كَسَانِي هَذَا وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ":
          1,
    },
    "عند رؤية الهلال": {
      "اللَّهُمَّ أَهِلَّهُ عَلَيْنَا بِالْأَمْنِ وَالْإِيمَانِ، وَالسَّلَامَةِ وَالْإِسْلَامِ، رَبِّي وَرَبُّكَ اللَّهُ":
          1,
    },
    "عند الذهاب إلى السوق": {
      "لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، يُحْيِي وَيُمِيتُ، وَهُوَ حَيٌّ لَا يَمُوتُ، بِيَدِهِ الْخَيْرُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ":
          1,
    },
    "عند دخول السوق": {
      "لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، يُحْيِي وَيُمِيتُ، وَهُوَ حَيٌّ لَا يَمُوتُ، بِيَدِهِ الْخَيْرُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ":
          1,
    },
    "عند ركوب السيارة أو الدابة": {
      "سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ، وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ":
          1,
    },
    "عند دخول المسجد": {
      "اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ": 1,
    },
    "عند الخروج من المسجد": {
      "اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ": 1,
    },
    "عند البدء في الطعام": {
      "بِسْمِ اللَّهِ": 1,
      "بِسْمِ اللَّهِ وَعَلَى بَرَكَةِ اللَّهِ": 1,
    },
    "عند الانتهاء من الطعام": {
      "الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ":
          1,
    },
    "عند سماع الأخبار السيئة": {
      "إِنَّا لِلَّهِ وَإِنَّا إِلَيْهِ رَاجِعُونَ، اللَّهُمَّ أْجُرْنِي فِي مُصِيبَتِي، وَاخْلُفْ لِي خَيْرًا مِنْهَا":
          1,
    },
    "عند زيارة المريض": {
      "لَا بَأْسَ طَهُورٌ إِنْ شَاءَ اللَّهُ": 1,
    },
    "عند رؤية المصائب": {
      "الْحَمْدُ لِلَّهِ عَلَى كُلِّ حَالٍ": 1,
    },
    "عند الخوف من شيء": {
      "حَسْبِيَ اللَّهُ وَنِعْمَ الْوَكِيلُ": 1,
    },
    "عند الفرح": {
      "الْحَمْدُ لِلَّهِ الَّذِي بِنِعْمَتِهِ تَتِمُّ الصَّالِحَاتُ": 1,
    },
    "عند الحزن": {
      "اللَّهُمَّ إِنِّي عَبْدُكَ، ابْنُ عَبْدِكَ، ابْنُ أَمَتِكَ، نَاصِيَتِي بِيَدِكَ، مَاضٍ فِيَّ حُكْمُكَ، عَدْلٌ فِيَّ قَضَاؤُكَ، أَسْأَلُكَ بِكُلِّ اسْمٍ هُوَ لَكَ، سَمَّيْتَ بِهِ نَفْسَكَ، أَوْ أَنْزَلْتَهُ فِي كِتَابِكَ، أَوْ عَلَّمْتَهُ أَحَدًا مِنْ خَلْقِكَ، أَوِ اسْتَأْثَرْتَ بِهِ فِي عِلْمِ الْغَيْبِ عِنْدَكَ، أَنْ تَجْعَلَ الْقُرْآنَ رَبِيعَ قَلْبِي، وَنُورَ صَدْرِي، وَجِلَاءَ حُزْنِي، وَذَهَابَ هَمِّي":
          1,
    },
    "أذكار": {
      "اللَّهُمَّ إِنِّي أَسْأَلُكَ بِأَنَّ لَكَ الْحَمْدُ لَا إِلَهَ إِلَّا أَنْتَ، الْمَنَّانُ، بَدِيعُ السَّمَاوَاتِ وَالْأَرْضِ، ذُو الْجَلَالِ وَالْإِكْرَامِ، يَا حَيُّ يَا قَيُّومُ، إِنِّي أَسْأَلُكَ الْجَنَّةَ، وَأَعُوذُ بِكَ مِنَ النَّارِ":
          1,
      "اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ خَيْرِ مَا سَأَلَكَ مِنْهُ نَبِيُّكَ مُحَمَّدٌ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا اسْتَعَاذَ مِنْهُ نَبِيُّكَ مُحَمَّدٌ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ، أَنْتَ الْمُقْتَدِرُ وَأَنَا الْعَبْدُ الضَّعِيفُ":
          1,
      "اللَّهُمَّ إِنِّي أَسْأَلُكَ بِأَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ، الْأَحَدُ الصَّمَدُ، الَّذِي لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ، أَنْ تَغْفِرَ لِي ذُنُوبِي، إِنَّكَ أَنْتَ الْغَفُورُ الرَّحِيمُ":
          1,
      "اللَّهُمَّ إِنِّي أَسْأَلُكَ بِأَنَّ لَكَ الْحَمْدُ لَا إِلَهَ إِلَّا أَنْتَ، وَحْدَكَ لَا شَرِيكَ لَكَ، الْمَلِكُ الْقُدُّوسُ، السَّلَامُ الْمُؤْمِنُ الْمُهَيْمِنُ الْعَزِيزُ الْجَبَّارُ الْمُتَكَبِّرُ، سُبْحَانَ اللَّهِ رَبِّ الْعَالَمِينَ":
          1,
      "اللَّهُمَّ إِنِّي أَسْأَلُكَ بِأَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ، الْعَلِيُّ الْعَظِيمُ، الْحَلِيمُ الْكَرِيمُ، سُبْحَانَ اللَّهِ رَبِّ الْعَرْشِ الْعَظِيمِ":
          1,
    },
  };

  late AnimationController _eveningController;

  int currentPrayerIndex = 0; // لتتبع الفرض الحالي
  late PageController _pageController; // للتحكم في PageView

  @override
  void initState() {
    super.initState();
    _loadEveningPreferences(); // تحميل التفضيلات
    _eveningController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _eveningController.forward();

    _pageController = PageController(initialPage: currentPrayerIndex);
  }

  @override
  void dispose() {
    _eveningController.dispose();
    _pageController.dispose(); // التخلص من PageController
    super.dispose();
  }

  _loadEveningPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLightTheme = prefs.getBool('eveningTheme') ?? false; // default to true
      fontSize = prefs.getDouble('eveningFontSize') ?? 30; // استرجاع حجم الخط
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isLightTheme ? Colors.white : Colors.black,
        actions: [
          Text(
            "أذكار",
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
              Icons.diamond,
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
            Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                height: 50,
                color: isLightTheme ? Colors.white : Colors.black,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: prayerAzkaar.length,
                  itemBuilder: (context, index) {
                    String prayerName = prayerAzkaar.keys.toList()[index];
                    bool isCurrent = index == currentPrayerIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPrayerIndex = index;
                          _pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? (isLightTheme
                                  ? Colors.teal
                                  : Colors.deepPurpleAccent)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            prayerName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isCurrent
                                  ? Colors.white
                                  : (isLightTheme
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController, // ربط PageController
                onPageChanged: (index) {
                  setState(() {
                    currentPrayerIndex = index;
                  });
                },
                itemCount: prayerAzkaar.length,
                itemBuilder: (context, index) {
                  String prayerName = prayerAzkaar.keys.toList()[index];
                  Map<String, int> azkaar = prayerAzkaar[prayerName]!;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ...azkaar.entries.map((entry) {
                          String zikr = entry.key;
                          int agin = entry.value;

                          return _buildEveningZekrCard(zikr, agin, prayerName);
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
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

  Widget _buildEveningZekrCard(String zikr, int agin, String prayerName) {
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
              prayerAzkaar[prayerName]![zikr] = agin - 1;
              if (prayerAzkaar[prayerName]![zikr] == 0) {
                prayerAzkaar[prayerName]!.remove(zikr);
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
