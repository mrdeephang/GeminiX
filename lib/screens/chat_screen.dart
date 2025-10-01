import 'package:flutter/material.dart';
import 'package:gemini_chatbot/const/colors.dart';
import 'package:gemini_chatbot/models/chat_message.dart';
import 'package:gemini_chatbot/providers/theme_provider.dart';
import 'package:gemini_chatbot/widgets/chat_bubble.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  final Map<String, String> _responseCache = {};
  int _apiCallCount = 0;
  DateTime? _lastApiCallTime;
  final ScrollController _scrollController = ScrollController();

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    // Check cache first
    if (_responseCache.containsKey(message)) {
      setState(() {
        _messages.add(
          ChatMessage(text: _responseCache[message]!, isUser: false),
        );
      });
      _messageController.clear();
      _scrollToBottom();
      return;
    }

    // Rate limiting
    final now = DateTime.now();
    if (_lastApiCallTime != null &&
        now.difference(_lastApiCallTime!) < Duration(seconds: 1)) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: "Please wait a moment before sending another message",
            isUser: false,
          ),
        );
      });
      _scrollToBottom();
      return;
    }

    setState(() {
      _messages.add(ChatMessage(text: message, isUser: true));
      _isLoading = true;
    });
    _messageController.clear();
    _lastApiCallTime = now;

    try {
      final model = GenerativeModel(
        model: 'gemini-flash-latest',
        apiKey: dotenv.env['GEMINI_API_KEY']!,
      );

      // Track API calls
      _apiCallCount++;
      if (_apiCallCount % 5 == 0) {
        debugPrint('API calls made: $_apiCallCount');
      }

      final response = await model.generateContent([Content.text(message)]);
      final responseText = response.text ?? "I didn't understand that";
      _responseCache[message] = responseText;

      setState(() {
        _messages.add(ChatMessage(text: responseText, isUser: false));
      });
    } catch (e) {
      String errorMessage = "Error: $e";
      if (e.toString().contains('quota')) {
        errorMessage = "I'm getting too many requests. Please try again later.";
      }

      setState(() {
        _messages.add(ChatMessage(text: errorMessage, isUser: false));
      });
    } finally {
      setState(() => _isLoading = false);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: themeProvider.isDarkMode
            ? darkColor
            : Colors.blue[600],
        title: Text('GeminiX', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              setState(() {
                _responseCache.clear();
                _messages.clear();
              });
            },
            tooltip: 'Clear chat',
          ),
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    message: _messages[index].text,
                    isUser: _messages[index].isUser,
                  );
                },
              ),
            ),
          ),
          if (_isLoading)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: LinearProgressIndicator(),
            ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode
                  ? Colors.grey[900]
                  : Colors.grey[100],
              border: Border(
                top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor:
                            Provider.of<ThemeProvider>(
                              context,
                              listen: false,
                            ).isDarkMode
                            ? Colors.black
                            : Colors.grey[100],
                        hintText: "Ask GeminiX...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? darkColor
                        : Colors.blue[600],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
