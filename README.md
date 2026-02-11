# 💝 Compliment Me

> An AI-powered mobile app that generates hyper-specific, meaningful compliments using Gemini Vision API, n8n workflows, and Flutter.

![Flutter](https://img.shields.io/badge/Flutter-3.5.1-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.5.1-0175C2?logo=dart)
![n8n](https://img.shields.io/badge/n8n-Workflow-FF6D5A?logo=n8n)
![Gemini](https://img.shields.io/badge/Gemini-AI-4285F4?logo=google)


# Demo




Uploading Untitled video - Made with Clipchamp (1).mp4…


<img width="947" height="557" alt="image" src="https://github.com/user-attachments/assets/f2799672-0cf3-4a5b-9954-9f24a4c7cf8f" />

## 🎯 What It Does

Compliment Dealer analyzes your photo using AI and generates 4-5 unique, specific compliments that notice details people usually overlook. Instead of generic "you look nice," you get insights like *"your eyes have this warm amber ring around the pupils that catches light beautifully"* or *"the way your smile creates subtle asymmetry shows genuine emotion."*

## ✨ Features

- 📸 **Camera & Gallery Support** - Take a selfie or choose from your gallery
- 🤖 **AI-Powered Analysis** - Uses Google's Gemini Vision API for detailed photo analysis
- 🔄 **n8n Workflow Integration** - Serverless backend orchestration without traditional server code
- 🎨 **Glassmorphism UI** - Modern blur effects and beautiful gradients
- ⚡ **Riverpod State Management** - Clean architecture without code generation
- 🎭 **Animated UI** - Smooth, staggered animations for compliment reveals
- 🌐 **RESTful API** - Easy integration with webhook-based architecture

## 🏗️ Architecture

```
┌─────────────┐       ┌─────────────┐       ┌─────────────┐
│   Flutter   │──────▶│     n8n     │──────▶│   Gemini    │
│     App     │◀──────│  Workflow   │◀──────│   Vision    │
└─────────────┘       └─────────────┘       └─────────────┘
```

**How it works:**
1. User takes/selects a photo in Flutter app
2. Image converted to base64 and sent to n8n webhook
3. n8n orchestrates the workflow:
   - Sends image to Gemini Vision for detailed analysis
   - Gemini generates compliments based on observations
   - Returns structured JSON response
4. Flutter displays compliments with beautiful animations

## 🛠️ Tech Stack

### Frontend
- **Flutter 3.5.1** - Cross-platform mobile framework
- **Riverpod 2.6.1** - State management (without code generation)
- **Image Picker 1.1.2** - Camera and gallery access
- **Glassmorphism 3.0.0** - UI blur effects

### Backend (n8n Workflow)
- **n8n** - Workflow automation and API orchestration
- **Gemini Vision API** - AI-powered image analysis
- **Gemini 2.5 Flash** - Fast, cost-effective AI model

## 📂 Project Structure

lib/
├── main.dart                       # App entry point with Riverpod setup
├── models/
│   └── compliment_response.dart    # Data model for API responses
├── providers/
│   └── compliment_provider.dart    # Riverpod state management
├── services/
│   └── api_service.dart           # HTTP client for n8n webhook
├── screens/
│   ├── home_screen.dart           # Camera/Gallery selection
│   └── compliment_screen.dart     # Compliment display with animations
└── widgets/
    ├── glass_container.dart       # Reusable glassmorphism widget
    └── compliment_card.dart       # Individual compliment card
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.5.1+
- Dart 3.5.1+
- n8n account (free tier works)
- Google Gemini API key (free credits available)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/compliment-dealer.git
cd compliment-dealer
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Set up n8n workflow**
   - Import the n8n workflow from `/n8n-workflow/` folder
   - Add your Gemini API key to the workflow
   - Activate the workflow
   - Copy the production webhook URL

4. **Configure API endpoint**

Open `lib/services/api_service.dart` and update:
```dart
static const String _baseUrl = 'YOUR_N8N_WEBHOOK_URL_HERE';
```

5. **Run the app**
```bash
flutter run
```

## 🔧 n8n Workflow Setup

The n8n workflow consists of these nodes:

1. **Webhook** - Receives image from Flutter (POST endpoint)
2. **Extract Image Data** - Parses base64 image from request
3. **Gemini Vision Analysis** - Analyzes photo for details
4. **Parse Response** - Extracts analysis text
5. **Gemini Generate Compliments** - Creates specific compliments
6. **Format Response** - Structures JSON for Flutter
7. **Respond to Webhook** - Returns compliments to app

### Workflow Benefits of Using n8n

- ✅ No traditional backend server required
- ✅ Visual workflow editor - easy to modify
- ✅ Built-in error handling and retries
- ✅ API orchestration without code
- ✅ Easy to add features (logging, databases, notifications)



## 🎓 What I Learned

This project was an exploration of:
- **n8n for mobile backend** - Using workflow automation instead of Express/FastAPI
- **Serverless architecture** - No server management, just workflows
- **AI integration** - Working with Gemini Vision API
- **Flutter + n8n** - Connecting mobile apps to workflow automation
- **Glassmorphism** - Creating modern blur effects in Flutter
- **Riverpod without generators** - Clean state management



## 🔗 Links

- **n8n Documentation**: https://docs.n8n.io
- **Gemini API**: https://ai.google.dev
- **Flutter**: https://flutter.dev

## 💬 Feedback

If you try this app or build something similar with n8n + Flutter, I'd love to hear about it!

---

**Built with ❤️ exploring the intersection of workflow automation and mobile development**
