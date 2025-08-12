import 'package:flutter/material.dart';
import 'package:gemini_chatbot/models/chat_message.dart';
import 'package:gemini_chatbot/providers/theme_provider.dart';
import 'package:gemini_chatbot/widgets/chat_bubble.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  final Map<String, String> _responseCache = {}; // Cache storage
  int _apiCallCount = 0;
  DateTime? _lastApiCallTime;

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
      return;
    }
    setState(() {
      _messages.add(ChatMessage(text: message, isUser: true));
      _isLoading = true;
    });
    _messageController.clear();
    _lastApiCallTime = now;

    try {
      // Initialize model (using latest recommended version)
      final model = GenerativeModel(
        model: 'gemini-1.5-flash', // More quota-efficient model
        apiKey: dotenv.env['GEMINI_API_KEY']!,
      );

      // Track API calls
      _apiCallCount++;
      if (_apiCallCount % 5 == 0) {
        debugPrint('API calls made: $_apiCallCount');
      }

      final response = await model.generateContent([Content.text(message)]);
      final responseText = response.text ?? "I didn't understand that";

      // Cache the response
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
    }
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<Themeprovider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[300],
        title: Text(
          'Gemini Chatbot',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _responseCache.clear();
                _messages.clear();
              });
            },
            tooltip: 'Clear cache and history',
          ),
          IconButton(
            onPressed: () {
              Provider.of<Themeprovider>(context, listen: false).toggleTheme();
            },
            icon: Icon(
              Provider.of<Themeprovider>(context, listen: false).isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(10),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    message: _messages[index].text,
                    isUser: _messages[index].isUser,
                  );
                },
              ),
            ),
            if (_isLoading) LinearProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Message Gemini",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(width: 15),
                  FloatingActionButton.small(
                    backgroundColor: Colors.blue,
                    onPressed: _sendMessage,
                    child: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
