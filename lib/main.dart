import 'package:flutter/material.dart';

// Import 3 file màn hình vừa tạo
// Lưu ý: Thay 'tên_project_của_bạn' bằng tên thật trong pubspec.yaml
// Hoặc dùng đường dẫn tương đối như bên dưới:
import 'screens/motion_tracker.dart';
import 'screens/explorer_tool.dart';
import 'screens/light_meter.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bài Tập Chương 20: Sensors")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavButton(context, "Bài 1: Motion Tracker (Lắc tay)", Icons.vibration, const MotionTracker()),
            _buildNavButton(context, "Bài 2: Explorer Tool (GPS + La bàn)", Icons.explore, const ExplorerTool()),
            _buildNavButton(context, "Bài 3: Light Meter (Ánh sáng)", Icons.lightbulb, const LightMeter()),
          ],
        ),
      ),
    );
  }

  // Hàm tiện ích để tạo nút bấm cho gọn code
  Widget _buildNavButton(BuildContext context, String title, IconData icon, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          icon: Icon(icon),
          label: Text(title, style: const TextStyle(fontSize: 16)),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
        ),
      ),
    );
  }
}