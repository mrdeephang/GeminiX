import 'package:flutter/material.dart';
import 'package:gemini_chatbot/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(
      context,
      listen: false,
    ).isDarkMode;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isUser
                    ? isDarkMode
                          ? Colors.blue[700]
                          : Colors.blue[500]
                    : isDarkMode
                    ? Colors.grey[800]
                    : Colors.grey[500],
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
