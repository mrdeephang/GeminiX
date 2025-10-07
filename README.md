# 🤖 GeminiX

> **AI-powered chatbot application** — Intelligent conversations using Google's Gemini AI

---

## 📸 Screenshot

<p align="center">
  <img src="https://github.com/user-attachments/assets/f099b0e5-8ce0-4702-928f-1185bac065dd" alt="GeminiX Chat Interface" width="300"/>
</p>

---

## ✨ Features

- 💬 **Real-time conversations** — Instant AI responses powered by Gemini
- 🚀 **Efficient model** — Uses gemini-flash-latest for speed
- 📦 **Smart caching** — Reduces redundant API calls
- ⏱️ **Rate limiting** — Built-in request throttling
- 🎨 **Modern UI** — Clean interface with themed chat bubbles
- 🔄 **Conversation history** — Persistent chat memory
- 🗑️ **Clear history** — Reset cache and conversations anytime

---

## 📋 Requirements

- Flutter SDK (v3.19+)
- Dart (v3.3+)
- VS Code with Flutter/Dart extensions (recommended)
- **Development environment**:
  - Android Studio/Xcode for emulators
  - OR physical device (Android/iOS)

---

## 📦 Dependencies

```yaml
http: ^1.5.0
google_generative_ai: ^0.4.7
flutter_dotenv: ^5.2.1
provider: ^6.1.5
```

---

## 📁 Folder Structure

```
lib/
├── models/
│   └── chatmessage.dart         # Message data model
├── providers/
│   └── theme_provider.dart      # Theme state management
├── screens/
│   └── chat_screen.dart         # Main chat interface
├── widgets/
│   └── chat_bubble.dart         # Message bubble widget
└── main.dart                    # App entry point
```

---

## 🔧 Setup Instructions

### 1. Get Your Gemini API Key

Visit [Google AI Studio](https://aistudio.google.com/) and create an API key under the "Get API Key" section.

### 2. Configure Environment Variables

Create a `.env` file in the project root:

```bash
# Option 1: Create manually
# /GeminiX/.env
GEMINI_API_KEY=your_api_key_here

# Option 2: Use command line
echo "GEMINI_API_KEY=your_api_key_here" > .env
```

### 3. Add Assets to pubspec.yaml

```yaml
flutter:
  assets:
    - .env
```

---

## 🚀 Installation & Running

```bash
# 1. Clone the repository
git clone https://github.com/mrdeephang/GeminiX.git
cd GeminiX

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
# Or press Ctrl + F5 in VS Code
```

---

## 🔐 Security Note

⚠️ **Never commit your `.env` file!** Add it to `.gitignore`:

```
.env
```

---

## 🔮 Future Enhancements

- 🎙️ **Voice input** — Speech-to-text integration
- 🖼️ **Image support** — Send and analyze images
- 💾 **Cloud sync** — Save conversations across devices
- 🌍 **Multi-language** — Support for multiple languages
- 📊 **Export chats** — Save conversations as text/PDF

---

## 👨‍💻 Author

**Deephang Thegim**  
GitHub: [@mrdeephang](https://github.com/mrdeephang)

---

## 📄 License

Copyright © 2025 Deephang Thegim. All rights reserved.
