import 'package:flutter/material.dart';

class LightMeter extends StatefulWidget {
  const LightMeter({super.key});

  @override
  State<LightMeter> createState() => _LightMeterState();
}

class _LightMeterState extends State<LightMeter> {
  // Biến lưu độ sáng giả lập
  double _luxValue = 0; 

  @override
  Widget build(BuildContext context) {
    // Logic xác định sáng/tối vẫn giữ nguyên như bài tập yêu cầu
    bool isDark = _luxValue < 50;
    String status = _luxValue < 10 ? "TỐI OM (Phòng kín)" 
                  : (_luxValue < 500 ? "SÁNG VỪA (Trong nhà)" : "RẤT SÁNG (Ngoài trời)");

    return Scaffold(
      // Thay đổi màu nền theo độ sáng
      backgroundColor: isDark ? Colors.black87 : Colors.white,
      appBar: AppBar(
        title: const Text("Light Meter (Giả lập)"),
        backgroundColor: isDark ? Colors.grey[900] : Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon bóng đèn đổi màu
            Icon(
              Icons.lightbulb, 
              size: 100, 
              color: isDark ? Colors.grey : Colors.orangeAccent
            ),
            const SizedBox(height: 20),
            
            // Hiển thị chỉ số Lux
            Text(
              "${_luxValue.toStringAsFixed(0)} LUX",
              style: TextStyle(
                fontSize: 60, 
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black
              ),
            ),
            
            // Hiển thị trạng thái text
            Text(
              status,
              style: TextStyle(
                fontSize: 20, 
                color: isDark ? Colors.white70 : Colors.black54
              ),
            ),
            
            const SizedBox(height: 50),
            
            // --- KHU VỰC GIẢ LẬP (SIMULATION) ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.grey[200],
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                children: [
                  Text(
                    "Kéo để giả lập ánh sáng:",
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  ),
                  Slider(
                    value: _luxValue,
                    min: 0,
                    max: 1000,
                    divisions: 100,
                    label: _luxValue.round().toString(),
                    activeColor: isDark ? Colors.white : Colors.orange,
                    onChanged: (double value) {
                      setState(() {
                        _luxValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Lưu ý: Chế độ giả lập dùng cho Máy ảo (Emulator) vì không có cảm biến phần cứng.",
                textAlign: TextAlign.center, 
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey, fontSize: 12)
              ),
            )
          ],
        ),
      ),
    );
  }
}