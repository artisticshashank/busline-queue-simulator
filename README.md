# 🚌 BusLine Queue Simulator
## 🚀 Try It Out

Curious to see it in action?  
👉 [**Try it for free here**](https://busline-queue.netlify.app/)

![Flutter](https://badgen.net/badge/Flutter/3.10.3/blue)
[![Dart](https://img.shields.io/badge/Dart-3.10.3-0175C2?logo=dart)](https://dart.dev)
[![Supabase](https://img.shields.io/badge/Supabase-Realtime-3ECF8E?logo=supabase)](https://supabase.com)
> **An interactive, real-time queue visualization app** demonstrating classic **Data Structures & Algorithms** concepts through a beautiful Flutter UI powered by Supabase's real-time database.

---

## 🎯 What Is This? 

**BusLine** transforms the abstract concept of **Queue (FIFO - First In, First Out)** into a tangible, visual experience. Watch as virtual passengers line up at a bus stop, and see them board in perfect order—all synchronized across multiple devices in real-time! 

Perfect for: 
- 📚 **CS Students** learning data structures
- 👨‍🏫 **Educators** teaching queue algorithms
- 🧑‍💻 **Developers** exploring Flutter + Supabase integration
- 🎨 **Anyone** who loves clean code architecture

---

## ✨ Features

### 🎨 **Visual Queue Management**
- **Colorful Avatars**: Each person gets a unique avatar with their initial
- **Position Indicators**: See everyone's place in line (#1, #2, #3...)
- **Smooth Animations**: Watch the queue flow naturally as people join and leave

### ⚡ **Real-Time Synchronization**
- **Multi-Device Sync**: Open on phone + tablet = instant updates everywhere
- **WebSocket Magic**: Powered by Supabase's real-time subscriptions
- **Zero Refresh**:  No manual reloading needed—it just works!

### 📊 **Educational Operations Log**
- **Learning Mode**: See exactly what happens with each operation
- **Enqueue/Dequeue Events**: Track every addition and removal
- **Error Handling**: Understand edge cases (empty queue, race conditions)

### 🏗️ **Clean Architecture**
- **Provider Pattern** (MVVM-style) for state management
- **Service Layer** abstracting Supabase complexity
- **Model-View-Provider** separation for scalability

---

## 🚀 Quick Start

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (≥3.10.3)
- [Supabase Account](https://supabase.com) (free tier works!)
- A code editor (VS Code, Android Studio, etc.)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/artisticshashank/busline-queue-simulator.git
   cd busline-queue-simulator
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Supabase**
   
   Create a `.env` file in the project root:
   ```env
   SUPABASE_URL=https://your-project. supabase.co
   SUPABASE_ANON_KEY=your-anon-key-here
   ```

   Create a `queue` table in your Supabase database: 
   ```sql
   CREATE TABLE queue (
     id TEXT PRIMARY KEY,
     name TEXT NOT NULL,
     joined_at TIMESTAMP NOT NULL,
     avatar_index INTEGER DEFAULT 0
   );
   
   -- Enable real-time (in Supabase Dashboard > Database > Replication)
   -- Enable real-time for the 'queue' table
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🎮 How to Use

### Adding People (Enqueue)
Tap the green **"+ Add Person (Enqueue)"** button to add someone to the queue.  They'll appear at the back of the line with: 
- A random name (Alice, Bob, Charlie, etc.)
- A colorful avatar
- Their position number

### Boarding the Bus (Dequeue)
Tap the red **"🚌 Board Bus (Dequeue)"** button to let the **first** person in line board.  They'll disappear from the queue—that's FIFO in action!

### Real-Time Testing
Open the app on multiple devices/browsers and watch them sync instantly. Add a person on your phone → see it appear on your tablet! 

---

## 🏛️ Architecture

```
┌─────────────────────────────────────────────────────┐
│                 PRESENTATION LAYER                  │
│  (Screens & Widgets - What the user sees)          │
│  • bus_stop_screen.dart                            │
│  • person_avatar.dart                              │
└──────────────────┬──────────────────────────────────┘
                   │ User Actions (Tap buttons)
                   ▼
┌─────────────────────────────────────────────────────┐
│            STATE MANAGEMENT LAYER                   │
│  (Provider - Business Logic)                       │
│  • queue_provider.dart                             │
│    - Holds queue list                              │
│    - addPerson() / removePerson()                  │
│    - Listens to Supabase stream                    │
└──────────────────┬──────────────────────────────────┘
                   │ Calls API methods
                   ▼
┌─────────────────────────────────────────────────────┐
│                 DATA LAYER                          │
│  (Service & Models)                                │
│  • supabase_service.dart (Singleton)               │
│  • queue_item.dart (Data Model)                    │
└──────────────────┬──────────────────────────────────┘
                   │ HTTPS + WebSockets
                   ▼
┌─────────────────────────────────────────────────────┐
│                   BACKEND                           │
│  • Supabase PostgreSQL (queue table)              │
│  • Real-time subscriptions                         │
└─────────────────────────────────────────────────────┘
```

👉 **[Full Architecture Documentation](./ARCHITECTURE.md)**

---

## 🧩 Tech Stack

| Category | Technology |
|----------|-----------|
| **Framework** | Flutter 3.10.3 |
| **Language** | Dart |
| **State Management** | Provider Pattern |
| **Backend** | Supabase (PostgreSQL + Real-time) |
| **UI Components** | Material 3 Design |
| **Fonts** | Google Fonts (Roboto) |
| **Key Packages** | `supabase_flutter`, `provider`, `uuid`, `intl`, `flutter_dotenv` |

---

## 📂 Project Structure

```
busline-queue-simulator/
├── lib/
│   ├── main.dart                    # App entry point & initialization
│   ├── models/
│   │   └── queue_item.dart         # Data model for a person in queue
│   ├── providers/
│   │   └── queue_provider.dart     # State management & business logic
│   ├── screens/
│   │   └── bus_stop_screen.dart    # Main UI screen
│   ├── services/
│   │   └── supabase_service.dart   # Backend API wrapper
│   └── widgets/
│       └── person_avatar. dart      # Reusable avatar component
├── . env                             # Supabase credentials (gitignored)
├── pubspec.yaml                     # Dependencies & assets
└── ARCHITECTURE.md                  # Detailed architecture guide
```

---

## 🎓 Learning Outcomes

By exploring this project, you'll understand: 

### 🗂️ **Data Structures**
- **Queue (FIFO)**: How elements maintain insertion order
- **Stream Processing**: Real-time data flow patterns

### 🏗️ **Software Architecture**
- **Separation of Concerns**: UI ↔ Logic ↔ Data layers
- **Provider Pattern**:  Reactive state management
- **Singleton Pattern**: Service layer design

### 🔄 **Real-Time Systems**
- **WebSocket Subscriptions**: Push-based updates
- **Optimistic UI**: Instant feedback before server confirmation
- **Race Condition Handling**: Multi-device synchronization

### 🎨 **Flutter Development**
- **Custom Widgets**: Building reusable components
- **Responsive Layouts**: `Expanded`, `ListView`, `Stack`
- **Material Design 3**: Modern UI patterns

---

## 🛠️ Customization Ideas

Want to make it your own? Try: 

- 🎨 **Theme Customization**: Change colors in `main.dart`
- 👥 **New Avatar Styles**:  Modify `PersonAvatar` widget
- 🚌 **Multiple Queues**: Add different bus lines (express, local, etc.)
- 📊 **Analytics Dashboard**: Track wait times, queue length over time
- 🔔 **Notifications**: Alert when queue reaches a certain size
- 🎮 **Gamification**: Points for efficient queue management

---

## 🐛 Troubleshooting

### "Supabase credentials missing"
Make sure your `.env` file exists with valid credentials. 

### Real-time not working
Check Supabase Dashboard → Database → Replication → Enable for `queue` table.

### Build errors
```bash
flutter clean
flutter pub get
flutter run
```

---

## 🤝 Contributing

Contributions are welcome! Please: 

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

---

## 👤 Author

**Shashank** ([@artisticshashank](https://github.com/artisticshashank))

- 🐙 GitHub: [artisticshashank](https://github.com/artisticshashank)
- 📧 Feel free to reach out for questions or collaboration!

---

## 🌟 Show Your Support

If this project helped you learn something new, give it a ⭐️!

---

## 🔗 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Supabase Docs](https://supabase.com/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [Queue Data Structure](https://en.wikipedia.org/wiki/Queue_(abstract_data_type))

---

<p align="center">
  Made with ❤️ and Flutter
</p>

<p align="center">
  <i>Happy Queueing! 🚌✨</i>
</p>
