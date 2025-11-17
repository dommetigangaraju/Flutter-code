import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting date/time

void main() {
  runApp(const MedicalChatApp());
}

class MedicalChatApp extends StatelessWidget {
  const MedicalChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediBot Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ChatBotScreen(),
    const DietTableScreen(),
    const EmergencyScreen(),
    const HospitalScreen(),
    const AppointmentScreen(),
  ];

  final List<String> _titles = [
    "MediBot Chat",
    "Healthy Diet",
    "Emergency Help",
    "Nearby Hospitals",
    "Book Appointment"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: _selectedIndex,
        indicatorColor: Colors.teal[100],
        onDestinationSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.smart_toy_outlined), label: "Chat"),
          NavigationDestination(
              icon: Icon(Icons.food_bank_outlined), label: "Diet"),
          NavigationDestination(
              icon: Icon(Icons.local_hospital_outlined), label: "Emergency"),
          NavigationDestination(
              icon: Icon(Icons.location_on_outlined), label: "Hospitals"),
          NavigationDestination(
              icon: Icon(Icons.calendar_today_outlined), label: "Appointment"),
        ],
      ),
    );
  }
}

// -------------------- CHATBOT ---------------------
class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      "sender": "bot",
      "text": "👋 Hi! I’m MediBot — your health assistant.\nHow can I help you today?"
    }
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({"sender": "user", "text": _controller.text.trim()});
      _messages.add({
        "sender": "bot",
        "text":
            "🤖 Thanks for your question! Please consult a doctor for professional advice."
      });
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top logo/avatar
        Container(
          padding: const EdgeInsets.all(12),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.teal[100],
            child: const Icon(Icons.smart_toy, color: Colors.teal, size: 45),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              final isUser = msg["sender"] == "user";
              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.teal[300] : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Text(
                    msg["text"]!,
                    style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 15),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      hintText: "Ask me anything...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.teal,
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: _sendMessage,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

// -------------------- DIET TABLE ---------------------
class DietTableScreen extends StatelessWidget {
  const DietTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final diet = [
      {"Meal": "Breakfast", "Items": "Oats, Fruits, Green Tea"},
      {"Meal": "Lunch", "Items": "Rice, Dal, Vegetables, Curd"},
      {"Meal": "Snacks", "Items": "Sprouts, Juice"},
      {"Meal": "Dinner", "Items": "Soup, Chapati, Salad"},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🥗 Healthy Diet Plan",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: ListView(
                children: diet
                    .map((d) => ListTile(
                          leading: const Icon(Icons.restaurant_menu,
                              color: Colors.teal),
                          title: Text(d["Meal"]!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(d["Items"]!),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------- EMERGENCY ---------------------
class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emergency, size: 100, color: Colors.red),
          const SizedBox(height: 20),
          const Text("Emergency Ambulance Service",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.call, color: Colors.white),
            label: const Text("Call Ambulance",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("🚑 Calling Ambulance (Demo only)")));
            },
          )
        ],
      ),
    );
  }
}

// -------------------- HOSPITALS ---------------------
class HospitalScreen extends StatelessWidget {
  const HospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hospitals = [
      {"name": "City Hospital", "distance": "1.2 km"},
      {"name": "Apollo Medical Center", "distance": "2.5 km"},
      {"name": "Star Health Clinic", "distance": "3.1 km"},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.local_hospital, color: Colors.teal),
              title: Text(hospitals[index]["name"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle:
                  Text("Distance: ${hospitals[index]["distance"]}", maxLines: 1),
              trailing:
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}

// -------------------- APPOINTMENT ---------------------
class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _nameController = TextEditingController();
  final _issueController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _pickTime() async {
    final picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const Text("📅 Doctor Appointment",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
                labelText: "Your Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _issueController,
            decoration: const InputDecoration(
                labelText: "Health Issue / Symptoms",
                prefixIcon: Icon(Icons.healing),
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.date_range),
                  label: Text(_selectedDate == null
                      ? "Pick Date"
                      : DateFormat('EEE, MMM d').format(_selectedDate!)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickTime,
                  icon: const Icon(Icons.access_time),
                  label: Text(_selectedTime == null
                      ? "Pick Time"
                      : _selectedTime!.format(context)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          ElevatedButton.icon(
            icon: const Icon(Icons.check_circle_outline, color: Colors.white),
            label: const Text("Confirm Appointment",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Appointment booked for ${_selectedDate != null ? DateFormat('MMM d').format(_selectedDate!) : 'selected date'} at ${_selectedTime?.format(context) ?? 'selected time'} ✅ (UI Demo only)")));
            },
          )
        ],
      ),
    );
  }
}
