import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Message> _messages = [];
  String API_KEY = 'AIzaSyCZVuenJfMv6I7uOdSm7zRRfmk2ety-GF0';
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String? messagesString = prefs.getString('messages');
    if (messagesString != null) {
      List<dynamic> messagesList = json.decode(messagesString);
      setState(() {
        _messages =
            messagesList.map((message) => Message.fromJson(message)).toList();
      });
    }
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String messagesString =
        json.encode(_messages.map((message) => message.toJson()).toList());
    await prefs.setString('messages', messagesString);
  }

  Future<void> sendMessage(String message) async {
    setState(() {
      _messages.add(Message(text: message, isUser: true));
      _isTyping = true;
    });

    final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$API_KEY");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'contents': [
          {
            'parts': [
              {'text': message}
            ]
          }
        ]
      }),
    );

    String botResponse;

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      botResponse =
          responseData['candidates'][0]['content']['parts'][0]['text'];
    } else {
      botResponse = 'Error: ${response.statusCode}';
    }

    setState(() {
      _isTyping = false;
      _messages.add(Message(text: botResponse, isUser: false));
    });

    _saveMessages();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _showMessageOptions(BuildContext context, Message message) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.copy),
                  title: Text('نسخ'),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: message.text));
                    Fluttertoast.showToast(msg: "تم نسخ الرسالة");
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('تعديل'),
                  onTap: () {
                    _editMessage(message);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('حذف'),
                  onTap: () {
                    setState(() {
                      _messages.remove(message);
                    });
                    _saveMessages(); // حفظ الرسائل بعد الحذف
                    Fluttertoast.showToast(msg: "تم حذف الرسالة");
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editMessage(Message message) {
    _controller.text = message.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                return GestureDetector(
                  onLongPress: () =>
                      _showMessageOptions(context, _messages[index]),
                  child: _buildMessageBubble(_messages[index]),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.pink : Colors.black87,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message.text,
          style: TextStyle(
              fontSize: 16,
              color: message.isUser ? Colors.white : Colors.greenAccent),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 100, // يمكنك تعديل الارتفاع الأقصى حسب الحاجة
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: null, // يسمح بالكتابة على أكثر من سطر
                  minLines: 1, // الحد الأدنى لعدد الأسطر
                  decoration: InputDecoration(
                    hintText: 'أدخل رسالتك',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  textInputAction: TextInputAction.newline,
                  textAlign:
                      _getTextAlign(), // تعيين اتجاه النص بناءً على اللغة
                  onChanged: (text) {
                    setState(() {}); // تحديث الواجهة عند تغيير النص
                  },
                  onSubmitted: (text) {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(text);
                      _controller.clear();
                    }
                  },
                  onTap: () {},
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.green),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                sendMessage(_controller.text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }

// وظيفة لتحديد اتجاه النص بناءً على اللغة المدخلة
  TextAlign _getTextAlign() {
    String text = _controller.text;
    if (text.isEmpty) {
      return TextAlign.right; // الاتجاه الافتراضي من اليمين
    }
    // التحقق إذا كان النص يحتوي على أحرف عربية
    bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    return isArabic ? TextAlign.right : TextAlign.left;
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: SpinKitThreeBounce(
            color: Colors.grey,
            size: 20.0,
          ),
        ),
        Text(
          'يكتب',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});

  Map<String, dynamic> toJson() => {
        'text': text,
        'isUser': isUser,
      };

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      isUser: json['isUser'],
    );
  }
}
