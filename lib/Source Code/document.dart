import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late Database database;
  List<Map<String, dynamic>> notes = [];
  List<Map<String, dynamic>> filteredNotes = [];
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      final String dbPath = join(await getDatabasesPath(), 'notes_database.db');
      database = await openDatabase(
        dbPath,
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, createdAt TEXT)',
          );
        },
        version: 1,
      );

      await _loadNotes();
    } catch (e) {
      print("Error initializing database: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadNotes() async {
    try {
      final List<Map<String, dynamic>> maps = await database.query('notes');
      setState(() {
        notes = maps;
        filteredNotes = maps;
      });
    } catch (e) {
      print("Error loading notes: $e");
    }
  }

  void _filterNotes(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredNotes = notes;
      } else {
        filteredNotes = notes
            .where((note) =>
                note['title'].toLowerCase().contains(query.toLowerCase()) ||
                note['content'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _sortNotes(String sortBy) {
    setState(() {
      if (sortBy == 'title') {
        filteredNotes.sort((a, b) => a['title'].compareTo(b['title']));
      } else if (sortBy == 'date') {
        filteredNotes.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
      }
    });
  }

  Future<void> _addOrUpdateNote({Map<String, dynamic>? note}) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    if (note != null) {
      titleController.text = note['title'];
      contentController.text = note['content'];
    }

    await showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(note == null ? 'إضافة ملاحظة' : 'تعديل الملاحظة'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: "عنوان الملاحظة"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: contentController,
                  maxLines: 5,
                  decoration: InputDecoration(hintText: "محتوى الملاحظة"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  if (note == null) {
                    await database.insert('notes', {
                      'title': titleController.text,
                      'content': contentController.text,
                      'createdAt': DateTime.now().toString(),
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تمت إضافة الملاحظة بنجاح!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    await database.update(
                      'notes',
                      {
                        'title': titleController.text,
                        'content': contentController.text,
                      },
                      where: 'id = ?',
                      whereArgs: [note['id']],
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم تعديل الملاحظة بنجاح!'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  }
                  await _loadNotes();
                  Navigator.of(context).pop();
                }
              },
              child: Text(note == null ? 'إضافة' : 'حفظ'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteNote(int id) async {
    await database.delete('notes', where: 'id = ?', whereArgs: [id]);
    await _loadNotes();
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text('تم حذف الملاحظة بنجاح!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('ملاحضتـ✒ـي'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NotesSearchDelegate(filteredNotes, _filterNotes),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: _sortNotes,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'title',
                child: Text('ترتيب حسب العنوان'),
              ),
              PopupMenuItem(
                value: 'date',
                child: Text('ترتيب حسب التاريخ'),
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : filteredNotes.isEmpty
              ? Center(
                  child: Text(
                    'لا توجد ملاحظات',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView.builder(
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = filteredNotes[index];
                      return Dismissible(
                        key: Key(note['id'].toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          _deleteNote(note['id']);
                        },
                        child: Card(
                          margin: EdgeInsets.all(10),
                          elevation: 3,
                          child: ListTile(
                            title: Text(
                              note['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(note['content']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    _addOrUpdateNote(note: note);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _deleteNote(note['id']);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrUpdateNote(),
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue.shade800,
      ),
    );
  }

  @override
  void dispose() {
    if (database != null) {
      database.close();
    }
    super.dispose();
  }
}

class NotesSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> notes;
  final Function(String) onFilter;

  NotesSearchDelegate(this.notes, this.onFilter);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          onFilter('');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final filtered = notes
        .where((note) =>
            note['title'].toLowerCase().contains(query.toLowerCase()) ||
            note['content'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final note = filtered[index];
        return ListTile(
          title: Text(note['title']),
          subtitle: Text(note['content']),
          onTap: () {
            close(context, note['id'].toString());
          },
        );
      },
    );
  }
}
