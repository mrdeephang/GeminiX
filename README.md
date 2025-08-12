# Gemini Chatbot (Flutter)

A Flutter-based chatbot application powered by Google's Gemini AI (using gemini-1.5-flash model). This app features intelligent conversation capabilities with response caching and rate limiting.

## 📋 Requirements

- **Flutter SDK** (v3.19 or later)
- **Dart** (v3.3 or later)
- **VS Code** (with Flutter/Dart extensions recommended)
- **Development Environment**:
  - Android Studio/Xcode (for emulators)
  - OR a physical device (Android/iOS)

## Features

- 💬 Real-time conversation with Gemini AI
- 🚀 Uses efficient gemini-1.5-flash model
- 📦 Response caching to reduce API calls
- ⏱️ Built-in rate limiting
- 🎨 Clean, modern UI with themed chat bubbles
- 🔄 Conversation history
- 🗑️ Clear cache/history functionality

## Prerequisites

- Flutter SDK (>=3.0.0)
- Google Gemini API key
- Dart (>=3.0.0)

## Folder Structure

├── lib/
│ ├── models/
| | ├── chatmessage.dart
│ ├── widgets/
| | ├── chat_bubble.dart
│ ├── easyconst/
│ │ ├── color.dart #constant color values used for the
│ ├── screens/
│ │ ├── chat_screen.dart
│ ├── main.dart #main entry

## Setup Instructions

1. **Get API Key**:

   - Visit [Google AI Studio](https://aistudio.google.com/)
   - Create an API key under "Get API Key" section

   ```

2. **Configure Environment**:

   ```bash
   echo "GEMINI_API_KEY=your_api_key_here" > .env

   ```

3. Add Assets
   assets:
   - .env

## 🛠️ Installation

**Clone the repository**:

```bash
git clone https://github.com/mrdeephang/FlutterPortfolio.git
cd flutter-portfolio
flutter pub get
flutter run or Ctrl + F5

```

Copyright © 2025 Deephang Thegim. All rights reserved.
