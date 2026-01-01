# BusLine Application Architecture

The **BusLine** app follows a clean, layered architecture designed for separation of concerns and scalability. It primarily uses the **Provider Pattern** (similar to MVVM) to separate the UI from the business logic and data layers.

## High-Level Diagram

```mermaid
graph TD
    User[User Interaction] --> UI[Presentation Layer<br>(Screens & Widgets)]
    
    subgraph Frontend Logic
        UI -- Triggers Actions --> Provider[State Management Layer<br>(QueueProvider)]
        Provider -- Notifies Changes --> UI
    end
    
    subgraph Data Layer
        Provider -- Calls API --> Service[Service Layer<br>(SupabaseService)]
        Service -- Returns Data/Stream --> Provider
        Service -- JSON Serialization --> Model[Data Models<br>(QueueItem)]
    end
    
    subgraph Backend
        Service -- HTTPS/WebSockets --> Supabase[Supabase Cloud<br>(Database & Realtime)]
    end
```

## Layers Breakdown

### 1. Presentation Layer (UI)
**Responsibility**: Renders the interface and captures user input. It observes the `QueueProvider` and rebuilds when state changes.
- **Files**:
    - `lib/screens/bus_stop_screen.dart`: Main screen showing the queue and controls.
    - `lib/widgets/person_avatar.dart`: Visual representation of a single person.
- **Key Concept**: "Dumb" widgets that just display data provided by the state layer.

### 2. State Management Layer (Provider)
**Responsibility**: Holds the application state, executes business logic, and acts as the bridge between UI and Backend.
- **File**: `lib/providers/queue_provider.dart`
- **Key Duties**:
    - Holds the list of `QueueItem`.
    - Contains logic for `addPerson()` and `removePerson()`.
    - Listens to the Supabase stream and updates the local list automatically.
    - Manages the "Operations Log" for educational purposes.

### 3. Data Layer (Service & Models)
**Responsibility**: Handles external communication and data structuring.
- **Service**: `lib/services/supabase_service.dart`
    - A singleton class that wraps the Supabase client.
    - Abstracts the database complexity (insert, delete, select commands).
- **Model**: `lib/models/queue_item.dart`
    - Defines the data structure (schema) for a person.
    - Handles JSON serialization (`fromJson`, `toJson`).

### 4. Backend (Supabase)
**Responsibility**: Persists data and broadscasts changes to other devices.
- **Database**: PostgreSQL table `queue`.
- **Realtime**: Pushes updates to the app via WebSockets whenever the table changes.

## Data Flow Scenarios

### Scenario A: User Adds a Person (Action)
1.  **UI**: User taps "Add Person" button.
2.  **Provider**: `addPerson()` is called. It creates a new `QueueItem`.
3.  **Service**: `SupabaseService.enqueue()` sends an `INSERT` command to the cloud.
4.  **Backend**: Supabase saves the row.

### Scenario B: Real-Time Sync (Reaction)
1.  **Backend**: Defines that a new row was inserted (by anyone).
2.  **Service**: The active `Stream` receives the new list of data.
3.  **Provider**: The listener inside `_initSubscription()` receives the data and calls `notifyListeners()`.
4.  **UI**: The `Consumer<QueueProvider>` rebuilds the widget tree to show the new person.
