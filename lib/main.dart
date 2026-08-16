import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const CyberRayApp());
}

class CyberRayApp extends StatelessWidget {
  const CyberRayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CyberRay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF030712),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFE0),
          secondary: Color(0xFFFF0055),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool isConnected = false;
  late AnimationController _controller;
  
  // لیست تستی کانفیگ‌ها
  List<Map<String, String>> servers = [
    {"name": "🇩🇪 Germany - HETZNER", "type": "VLESS", "ping": "42ms"},
    {"name": "🇫🇮 Finland - CLOUDFLARE", "type": "TROJAN", "ping": "78ms"},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showAddConfigDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildAddConfigSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // پس‌زمینه با افکت نئونی محو
          Positioned(
            top: 100,
            left: -50,
            child: Container(
              width: 200, height: 200,
              decoration: const BoxDecoration(color: Color(0xFF00FFE0), shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 250, height: 250,
              decoration: const BoxDecoration(color: Color(0xFFFF0055), shape: BoxShape.circle),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          // رابط کاربری اصلی
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'CYBER // RAY',
                  style: TextStyle(color: Color(0xFF00FFE0), letterSpacing: 6, fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 40),

                // دکمه اتصال مرکزی
                GestureDetector(
                  onTap: () => setState(() => isConnected = !isConnected),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        width: 180, height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF0D1424).withOpacity(0.6),
                          border: Border.all(
                            color: isConnected ? const Color(0xFF00FFE0) : const Color(0xFFFF0055),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: (isConnected ? const Color(0xFF00FFE0) : const Color(0xFFFF0055))
                                  .withOpacity(0.2 + (_controller.value * 0.4)),
                              blurRadius: 40, spreadRadius: 5,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.fingerprint,
                          size: 80,
                          color: isConnected ? const Color(0xFF00FFE0) : const Color(0xFFFF0055),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  isConnected ? 'SYSTEM ONLINE' : 'SYSTEM OFFLINE',
                  style: TextStyle(color: Colors.white.withOpacity(0.8), letterSpacing: 3, fontWeight: FontWeight.w600),
                ),
                
                const SizedBox(height: 40),

                // هدر لیست سرورها
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('NODE LIST', style: TextStyle(color: Colors.white54, letterSpacing: 2, fontSize: 12)),
                      IconButton(
                        onPressed: _showAddConfigDialog,
                        icon: const Icon(Icons.add_box_outlined, color: Color(0xFF00FFE0)),
                      )
                    ],
                  ),
                ),

                // لیست سرورها
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: servers.length,
                    itemBuilder: (context, index) {
                      final server = servers[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.radar, color: Color(0xFFFF0055)),
                          title: Text(server['name']!, style: const TextStyle(color: Colors.white, fontSize: 14)),
                          subtitle: Text(server['type']!, style: const TextStyle(color: Color(0xFF00FFE0), fontSize: 10, letterSpacing: 1)),
                          trailing: Text(server['ping']!, style: const TextStyle(color: Colors.greenAccent, fontSize: 12)),
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دیالوگ اضافه کردن کانفیگ
  Widget _buildAddConfigSheet() {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F1D),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: const Color(0xFF00FFE0).withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('IMPORT CONFIG', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 20),
            TextField(
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Paste vless://, vmess://, or trojan://',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                filled: true,
                fillColor: Colors.black.withOpacity(0.3),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF00FFE0))),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00FFE0).withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFF00FFE0))),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('DECODE & ADD', style: TextStyle(color: Color(0xFF00FFE0), letterSpacing: 2, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
