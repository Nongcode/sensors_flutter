import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';

class ExplorerTool extends StatefulWidget {
  const ExplorerTool({super.key});

  @override
  State<ExplorerTool> createState() => _ExplorerToolState();
}

class _ExplorerToolState extends State<ExplorerTool> {
  // Không dùng biến String tĩnh nữa, ta sẽ dùng StreamBuilder cho cả GPS

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Explorer Tool"), backgroundColor: Colors.grey[900]),
      body: Column(
        children: [
          // PHẦN 1: GPS (Dùng StreamBuilder để tự cập nhật khi đi lại)
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            color: Colors.blueGrey[900],
            child: StreamBuilder<Position>(
              // Lắng nghe vị trí liên tục
              stream: Geolocator.getPositionStream(
                locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Text("Lỗi quyền hoặc GPS tắt", style: TextStyle(color: Colors.red));
                if (!snapshot.hasData) return const Text("Đang chờ vệ tinh...", style: TextStyle(color: Colors.yellow));

                final position = snapshot.data!;
                return Text(
                  "Lat: ${position.latitude}\nLong: ${position.longitude}\nAlt: ${position.altitude.toStringAsFixed(1)}m",
                  style: const TextStyle(color: Colors.greenAccent, fontSize: 18, fontFamily: 'monospace'),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          
          // PHẦN 2: LA BÀN (Giữ nguyên)
          Expanded(
            child: StreamBuilder<MagnetometerEvent>(
              stream: magnetometerEventStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: Text("Đang chờ cảm biến...", style: TextStyle(color: Colors.white)));
                
                final event = snapshot.data!;
                double heading = atan2(event.y, event.x);
                double headingDegrees = heading * 180 / pi; 
                if (headingDegrees < 0) headingDegrees += 360;

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${headingDegrees.toStringAsFixed(0)}°", 
                        style: const TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                      const Text("HƯỚNG BẮC", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 30),
                      Transform.rotate(
                        angle: -heading, 
                        child: const Icon(Icons.navigation, size: 150, color: Colors.redAccent),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}