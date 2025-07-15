import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Spair extends StatefulWidget {
  @override
  _SpairState createState() => _SpairState();
}

class _SpairState extends State<Spair> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        automaticallyImplyLeading: false,
        title: TabBar(
          labelColor: Colors.greenAccent.shade700,
          controller: _tabController,
          tabs: [
            Tab(text: "أذكار البرنامج"),
            Tab(text: "أذكارك"),
          ],
        ),
        actions: [
          IconButton(
            icon: Row(
              children: [
                Text("💚 اضافة ذكرك",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Icon(Icons.add, color: Colors.green.shade200),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDhikrScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: _tabController,
        children: [
          SystemDhikrScreen(defaultDhikrList: _getDefaultDhikrList()),
          UserDhikrScreen(),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getDefaultDhikrList() {
    return [
      {
        'dhikr': 'سُبْحَانَ اللّهِ وَبِحَمْدِهِ',
        'fadl':
            'مَنْ قَالَ: سُبْحَانَ اللَّهِ وَبِحَمْدِهِ، فِي يَوْمٍ مِائَةَ مَرَّةٍ، حُطَّتْ خَطَايَاهُ، وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. (رواه البخاري ومسلم)',
        'isFadlVisible': false,
      },
      {
        'dhikr': 'الْحَمْدُ لِلّهِ',
        'fadl':
            'الْحَمْدُ لِلَّهِ تَمْلَأُ الْمِيزَانَ، وَسُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ تَمْلَآَنِ - أَوْ تَمْلَأُ - مَا بَيْنَ السَّمَاوَاتِ وَالْأَرْضِ. (رواه مسلم)',
        'isFadlVisible': false,
      },
      {
        'dhikr': 'اللّهُ أَكْبَرُ',
        'fadl':
            'مَنْ قَالَ: اللَّهُ أَكْبَرُ، كَبَّرَ اللَّهُ عَلَيْهِ، وَمَنْ قَالَ: لَا إِلَهَ إِلَّا اللَّهُ، بَعَثَ اللَّهُ عَلَيْهِ طَائِرًا يَطِيرُ بِهَا فِي الْجَنَّةِ. (رواه الترمذي وحسنه الألباني)',
        'isFadlVisible': false,
      },
      {
        'dhikr': 'لَا إِلَٰهَ إِلَّا اللّهُ',
        'fadl':
            'أَفْضَلُ الذِّكْرِ: لَا إِلَهَ إِلَّا اللَّهُ، وَأَفْضَلُ الدُّعَاءِ: الْحَمْدُ لِلَّهِ. (رواه الترمذي وحسنه الألباني)',
        'isFadlVisible': false,
      },
      {
        'dhikr': 'أَسْتَغْفِرُ اللّهَ',
        'fadl':
            'مَنْ لَزِمَ الِاسْتِغْفَارَ، جَعَلَ اللَّهُ لَهُ مِنْ كُلِّ ضِيقٍ مَخْرَجًا، وَمِنْ كُلِّ هَمٍّ فَرَجًا، وَرَزَقَهُ مِنْ حَيْثُ لَا يَحْتَسِبُ. (رواه أبو داود وحسنه الألباني)',
        'isFadlVisible': false,
      },
      {
        'dhikr': 'اللّهُمَّ صَلِّ عَلَى مُحَمَّدٍ',
        'fadl':
            'مَنْ صَلَّى عَلَيَّ صَلَاةً وَاحِدَةً، صَلَّى اللَّهُ عَلَيْهِ عَشْرًا، وَرَفَعَ لَهُ عَشْرَ دَرَجَاتٍ، وَكَتَبَ لَهُ عَشْرَ حَسَنَاتٍ، وَمَحَا عَنْهُ عَشْرَ سَيِّئَاتٍ. (رواه النسائي وصححه الألباني)',
        'isFadlVisible': false,
      },
      {
        'dhikr':
            'سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ وَلَا إِلَهَ إِلَّا اللَّهُ وَاللَّهُ أَكْبَرُ',
        'fadl':
            'هَذِهِ الْكَلِمَاتُ أَحَبُّ إِلَى النَّبِيِّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ مِمَّا طَلَعَتْ عَلَيْهِ الشَّمْسُ، وَهِيَ مِنْ أَفْضَلِ الذِّكْرِ. (رواه مسلم)',
        'isFadlVisible': false,
      },
      {
        'dhikr': 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
        'fadl':
            'هِيَ كَنْزٌ مِنْ كُنُوزِ الْجَنَّةِ، وَمَنْ قَالَهَا كَثِيرًا، كَانَتْ لَهُ نُورًا يَوْمَ الْقِيَامَةِ. (رواه البخاري ومسلم)',
        'isFadlVisible': false,
      },
      {
        'dhikr': 'سُبْحَانَ اللَّهِ الْعَظِيمِ وَبِحَمْدِهِ',
        'fadl':
            'مَنْ قَالَ: سُبْحَانَ اللَّهِ الْعَظِيمِ وَبِحَمْدِهِ، غُرِسَتْ لَهُ نَخْلَةٌ فِي الْجَنَّةِ. (رواه الترمذي وحسنه الألباني)',
        'isFadlVisible': false,
      },
      {
        'dhikr':
            'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ',
        'fadl':
            'مَنْ قَالَهَا مِنْ قَلْبِهِ، كَانَ حَقًّا عَلَى اللَّهِ أَنْ يُكَفِّرَ عَنْهُ ذُنُوبَهُ، وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. (رواه البخاري)',
        'isFadlVisible': false,
      },
      {
        'dhikr':
            'رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ نَبِيًّا',
        'fadl':
            'مَنْ قَالَهَا ثَلَاثَ مَرَّاتٍ، كَانَ حَقًّا عَلَى اللَّهِ أَنْ يُرْضِيَهُ يَوْمَ الْقِيَامَةِ. (رواه أبو داود وصححه الألباني)',
        'isFadlVisible': false,
      },
      {
        'dhikr':
            'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْجَنَّةَ وَأَعُوذُ بِكَ مِنَ النَّارِ',
        'fadl':
            'مَنْ سَأَلَ اللَّهَ الْجَنَّةَ ثَلَاثَ مَرَّاتٍ، قَالَتِ الْجَنَّةُ: اللَّهُمَّ أَدْخِلْهُ الْجَنَّةَ، وَمَنْ اسْتَجَارَ بِاللَّهِ مِنَ النَّارِ ثَلَاثَ مَرَّاتٍ، قَالَتِ النَّارُ: اللَّهُمَّ أَجِرْهُ مِنَ النَّارِ. (رواه الترمذي وحسنه الألباني)',
        'isFadlVisible': false,
      },
      {
        'dhikr':
            'اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ، تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ',
        'fadl':
            'مَنْ قَالَهَا فِي دُبُرِ كُلِّ صَلَاةٍ، كَانَتْ لَهُ كَفَّارَةً لِمَا بَيْنَ الصَّلَوَاتِ. (رواه مسلم)',
        'isFadlVisible': false,
      },
      {
        'dhikr':
            'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
        'fadl':
            'مَنْ قَالَهَا فِي يَوْمٍ مِائَةَ مَرَّةٍ، كَانَتْ لَهُ عَدْلَ عَشْرِ رِقَابٍ، وَكُتِبَتْ لَهُ مِائَةُ حَسَنَةٍ، وَمُحِيَتْ عَنْهُ مِائَةُ سَيِّئَةٍ، وَكَانَتْ لَهُ حِرْزًا مِنَ الشَّيْطَانِ يَوْمَهُ ذَلِكَ حَتَّى يُمْسِيَ. (رواه البخاري ومسلم)',
        'isFadlVisible': false,
      },
      {
        'dhikr': 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ، سُبْحَانَ اللَّهِ الْعَظِيمِ',
        'fadl':
            'كَلِمَتَانِ خَفِيفَتَانِ عَلَى اللِّسَانِ، ثَقِيلَتَانِ فِي الْمِيزَانِ، حَبِيبَتَانِ إِلَى الرَّحْمَنِ. (رواه البخاري ومسلم)',
        'isFadlVisible': false,
      },
    ];
  }
}

class SystemDhikrScreen extends StatelessWidget {
  final List<Map<String, dynamic>> defaultDhikrList;

  const SystemDhikrScreen({Key? key, required this.defaultDhikrList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: defaultDhikrList
                .asMap()
                .map((index, dhikrData) => MapEntry(
                      index,
                      _buildDhikrCard(dhikrData, context),
                    ))
                .values
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDhikrCard(Map<String, dynamic> dhikrData, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DhikrDetailScreen(
              dhikr: dhikrData['dhikr']!,
              fadl: dhikrData['fadl']!,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 10, offset: Offset(0, 5))
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('img/مسبحة.jpg'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    dhikrData['dhikr']!,
                    style: TextStyle(
                        color: Colors.orangeAccent.shade700,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    dhikrData['isFadlVisible']
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: Colors.orangeAccent,
                  ),
                  onPressed: () {
                    // يمكن إضافة تغيير حالة isFadlVisible هنا إذا لزم الأمر
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.copy,
                    color: Colors.blue,
                    size: 20,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: dhikrData['dhikr']!));
                  },
                ),
              ],
            ),
            if (dhikrData['isFadlVisible'] && dhikrData['fadl']!.isNotEmpty)
              Text(
                dhikrData['fadl']!,
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.right,
              ),
          ],
        ),
      ),
    );
  }
}

class UserDhikrScreen extends StatefulWidget {
  @override
  _UserDhikrScreenState createState() => _UserDhikrScreenState();
}

class _UserDhikrScreenState extends State<UserDhikrScreen> {
  List<Map<String, dynamic>> customDhikrList = [];

  @override
  void initState() {
    super.initState();
    _loadCustomDhikr();
  }

  Future<void> _loadCustomDhikr() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? customDhikrList =
        prefs.getStringList('customDhikrList1');
    final List<String>? customFadlList = prefs.getStringList('customFadlList1');

    setState(() {
      if (customDhikrList != null) {
        this.customDhikrList = List.generate(customDhikrList.length, (index) {
          return {
            'dhikr': customDhikrList[index],
            'fadl': customFadlList != null && index < customFadlList.length
                ? customFadlList[index]
                : '',
            'isFadlVisible': false,
          };
        });
      }
    });
  }

  Future<void> _deleteDhikr(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customDhikrList.removeAt(index); // إزالة الذكر من القائمة
    });

    // تحديث القائمة في SharedPreferences
    List<String> updatedDhikrList =
        customDhikrList.map((dhikr) => dhikr['dhikr'] as String).toList();
    List<String> updatedFadlList =
        customDhikrList.map((dhikr) => dhikr['fadl'] as String).toList();

    await prefs.setStringList('customDhikrList1', updatedDhikrList);
    await prefs.setStringList('customFadlList1', updatedFadlList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: customDhikrList
                .asMap()
                .map((index, dhikrData) => MapEntry(
                      index,
                      _buildDhikrCard(dhikrData, context, index),
                    ))
                .values
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDhikrCard(
      Map<String, dynamic> dhikrData, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DhikrDetailScreen(
              dhikr: dhikrData['dhikr']!,
              fadl: dhikrData['fadl']!,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 10, offset: Offset(0, 5))
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('img/مسبحة.jpg'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    dhikrData['dhikr']!,
                    style: TextStyle(
                        color: Colors.orangeAccent.shade700,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                  onPressed: () {
                    _deleteDhikr(index); // حذف الذكر
                  },
                ),
                IconButton(
                  icon: Icon(
                    dhikrData['isFadlVisible']
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: Colors.orangeAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      dhikrData['isFadlVisible'] = !dhikrData['isFadlVisible'];
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.copy,
                    color: Colors.blue,
                    size: 20,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: dhikrData['dhikr']!));
                  },
                ),
              ],
            ),
            if (dhikrData['isFadlVisible'] && dhikrData['fadl']!.isNotEmpty)
              Text(
                dhikrData['fadl']!,
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.right,
              ),
          ],
        ),
      ),
    );
  }
}

class AddDhikrScreen extends StatefulWidget {
  const AddDhikrScreen({super.key});

  @override
  _AddDhikrScreenState createState() => _AddDhikrScreenState();
}

class _AddDhikrScreenState extends State<AddDhikrScreen> {
  final TextEditingController _dhikrController = TextEditingController();
  final TextEditingController _fadlController = TextEditingController();

  Future<void> _saveDhikr() async {
    final String dhikr = _dhikrController.text;
    final String fadl = _fadlController.text;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? customDhikrList =
        prefs.getStringList('customDhikrList1') ?? [];
    List<String>? customFadlList1 =
        prefs.getStringList('customFadlList1') ?? [];

    customDhikrList.add(dhikr);
    customFadlList1.add(fadl);

    await prefs.setStringList('customDhikrList1', customDhikrList);
    await prefs.setStringList('customFadlList1', customFadlList1);

    _dhikrController.clear();
    _fadlController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم حفظ الذكر وفضيلته بنجاح!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          '💚 أدخل ذكرك',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white.withOpacity(.2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(_dhikrController, 'أدخل الذكر', TextAlign.right),
              SizedBox(height: 20),
              _buildMultilineTextField(_fadlController, 'أدخل فضيلة الذكر'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveDhikr,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(.5),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('حفظ', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, TextAlign textAlign) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepPurpleAccent),
        ),
      ),
      textAlign: textAlign,
    );
  }

  Widget _buildMultilineTextField(
      TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      maxLines: 10, // السماح بإدخال نص متعدد الأسطر
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepPurpleAccent),
        ),
      ),
    );
  }
}

class DhikrDetailScreen extends StatefulWidget {
  final String dhikr;
  final String fadl;

  DhikrDetailScreen({required this.dhikr, required this.fadl});

  @override
  _DhikrDetailScreenState createState() => _DhikrDetailScreenState();
}

class _DhikrDetailScreenState extends State<DhikrDetailScreen> {
  int customCount = 33; // العدد الافتراضي
  int originalCount = 33; // العدد الأصلي
  bool isDarkMode = true; // حالة الاستايل
  bool isPopping = false; // حالة التأثير الانبثاقي
  Map<String, int> resetCountMap =
      {}; // خريطة لتخزين عدد مرات الوصول إلى الصفر لكل ذكر

  @override
  void initState() {
    super.initState();
    _loadCustomCount(); // تحميل العدد المخزن عند بدء التطبيق
    _loadTheme(); // تحميل الاستايل المخزن
    _loadResetCount(); // تحميل عدد مرات الوصول إلى الصفر
  }

  void _loadCustomCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customCount = prefs.getInt('customCount') ??
          originalCount; // تعيين العدد المخزن أو القيمة الأصلية
    });
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ??
          true; // تعيين الاستايل المخزن أو القيمة الافتراضية
    });
  }

  void _loadResetCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? resetCountJson =
        prefs.getString('resetCountMap'); // تحميل الخريطة كـ JSON
    if (resetCountJson != null) {
      setState(() {
        resetCountMap = Map<String, int>.from(
            jsonDecode(resetCountJson)); // تحويل JSON إلى Map
      });
    }
  }

  void _saveCustomCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('customCount', customCount); // حفظ العدد في التخزين
  }

  void _saveResetCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String resetCountJson = jsonEncode(resetCountMap); // تحويل Map إلى JSON
    prefs.setString('resetCountMap', resetCountJson); // حفظ الخريطة في التخزين
  }

  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = !isDarkMode; // تغيير حالة الاستايل
      prefs.setBool('isDarkMode', isDarkMode); // حفظ الاستايل
    });
  }

  void _decrementCounter() async {
    setState(() {
      if (customCount > 0) {
        customCount--; // تقليل العداد فقط إذا كان أكبر من 0
      }
      // إعادة العداد إلى القيمة الأصلية عندما يصل إلى الصفر
      if (customCount == 0) {
        isPopping = true; // تفعيل التأثير الانبثاقي
        customCount = originalCount; // إعادة العداد إلى القيمة الأصلية

        // زيادة عدد مرات الوصول إلى الصفر للذكر الحالي
        String currentDhikr = widget.dhikr;
        resetCountMap[currentDhikr] = (resetCountMap[currentDhikr] ?? 0) + 1;
        _saveResetCount(); // حفظ الخريطة بعد التحديث
      }
    });

    // إعادة تعيين التأثير بعد فترة زمنية
    if (isPopping) {
      await Future.delayed(Duration(milliseconds: 300)); // مدة التأثير
      setState(() {
        isPopping = false; // إعادة تعيين التأثير
      });
    }
  }

  void _setCustomCount(String input) {
    setState(() {
      customCount = int.tryParse(input) ?? originalCount; // تعيين العداد
      _saveCustomCount(); // حفظ العدد بعد التعديل
    });
  }

  void _showCustomCountDialog() {
    final TextEditingController customCountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "أدخل عدد الذكر",
            style: TextStyle(
                color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: customCountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "عدد الذكر",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: Text("إلغاء"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "تعيين",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                _setCustomCount(customCountController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    setState(() {
      customCount = originalCount; // تعيين العداد إلى القيمة الأصلية
    });
    return true; // استمر في العودة
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black : Colors.white),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 150),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.white12 : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: isDarkMode ? Colors.white12 : Colors.grey,
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  isDarkMode
                                      ? Icons.wb_sunny
                                      : Icons.nights_stay,
                                  color: isDarkMode
                                      ? Colors.amber.shade600
                                      : Colors.black.withOpacity(.5),
                                  size: 30,
                                ),
                                onPressed: _toggleTheme,
                                tooltip: "تغيير الاستايل",
                              ),
                              Spacer(),
                              Text(
                                "${resetCountMap[widget.dhikr] ?? 0}",
                                style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.amber.shade600
                                        : Colors.black.withOpacity(.5),
                                    fontSize: 20),
                                textScaler: TextScaler.noScaling,
                              )
                            ],
                          ),
                          Text(
                            widget.dhikr,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15),
                          Text(
                            widget.fadl,
                            style: TextStyle(
                                color: isDarkMode
                                    ? Colors.yellowAccent
                                    : Colors.black54,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          AnimatedContainer(
                            duration:
                                Duration(milliseconds: 300), // مدة التأثير
                            width: isPopping
                                ? 170
                                : 150, // تغيير الحجم عند الانبثاق
                            height:
                                isPopping ? 90 : 70, // تغيير الحجم عند الانبثاق
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(.2)
                                  : Colors.black.withOpacity(.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    "$customCount",
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      size: 30),
                                  onPressed: _showCustomCountDialog,
                                  tooltip: "تعيين العدد",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _decrementCounter,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: isDarkMode
                                ? [Colors.lightBlueAccent, Colors.deepPurple]
                                : [Colors.deepPurple, Colors.lightBlueAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.fingerprint,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
