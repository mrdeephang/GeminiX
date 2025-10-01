# GeminiX

A Flutter-based chatbot application powered by Google's Gemini AI.

## Screenshot

<img src="https://github.com/user-attachments/assets/f099b0e5-8ce0-4702-928f-1185bac065dd" alt="Screenshot 0" width="300"/>

## 📋 Requirements

- **Flutter SDK** (v3.19 or later)
- **Dart** (v3.3 or later)
- **VS Code** (with Flutter/Dart extensions recommended)
- **Development Environment**:
  - Android Studio/Xcode (for emulators)
  - OR a physical device (Android/iOS)

## Features

- 💬 Real-time conversation with Gemini AI
- 🚀 Uses efficient gemini-flash-latest model
- 📦 Response caching to reduce API calls
- ⏱️ Built-in rate limiting
- 🎨 Clean, modern UI with themed chat bubbles
- 🔄 Conversation history
- 🗑️ Clear cache/history functionality

## Prerequisites

- Flutter SDK (>=3.0.0)
- Google Gemini API key
- Dart (>=3.0.0)

## Dependencies

http: ^1.5.0
google_generative_ai: ^0.4.7
flutter_dotenv: ^5.2.1
provider: ^6.1.5

## Folder Structure

├── lib/
│ ├── models/
| | ├── chatmessage.dart
│ ├── widgets/
| | ├── chat_bubble.dart
│ ├── providers/
│ │ ├──theme_provider.dart
│ ├── screens/
│ │ ├── chat_screen.dart
│ ├── main.dart #main entry

## Setup Instructions

1. **Get API Key**:

   - Visit [Google AI Studio](https://aistudio.google.com/)
   - Create an API key under "Get API Key" section

   ```

   ```

2. **Configure Environment**:
   /Gemini_Chatbot/.env //create .env if not present
   GEMINI_API_KEY=your_api_key_here //inside .env
   or

   ```bash
   echo "GEMINI_API_KEY=your_api_key_here" > .env

   ```

3. Add Assets
   assets:
   - .env

## 🛠️ Installation

**Clone the repository**:

```bash
git clone https://github.com/mrdeephang/https://github.com/mrdeephang/GeminiX.git
cd GeminiX
flutter pub get
flutter run or Ctrl + F5

```

Copyright © 2025 Deephang Thegim. All rights reserved.
