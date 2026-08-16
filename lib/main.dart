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
        scaffoldBackgroundColor: const Color(0xFF070B19),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'CYBER // RAY',
          style: TextStyle(
            color: Color(0xFF00FFE0),
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ویژوالایزر وضعیت پینگ و سرور
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1424),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isConnected ? const Color(0xFF00FFE0) : const Color(0xFFFF0055),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isConnected ? const Color(0xFF00FFE0) : const Color(0xFFFF0055)).withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetric('STATUS', isConnected ? 'ONLINE' : 'OFFLINE', isConnected ? Colors.cyanAccent : Colors.redAccent),
                _buildMetric('PING', isConnected ? '42 ms' : '---', Colors.amberAccent),
                _buildMetric('PROTOCOL', 'VLESS-REALITY', Colors.purpleAccent),
              ],
            ),
          ),
          const SizedBox(height: 70),

          // دکمه اتصال هولوگرافیک نئونی
          GestureDetector(
            onTap: () {
              setState(() {
                isConnected = !isConnected;
              });
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0D1424),
                    border: Border.all(
                      color: isConnected ? const Color(0xFF00FFE0) : const Color(0xFFFF0055),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (isConnected ? const Color(0xFF00FFE0) : const Color(0xFFFF0055))
                            .withOpacity(0.4 + (_controller.value * 0.3)),
                        blurRadius: 30 + (_controller.value * 15),
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.power_settings_new_rounded,
                      size: 80,
                      color: isConnected ? const Color(0xFF00FFE0) : const Color(0xFFFF0055),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Text(
            isConnected ? 'CORE ACTIVE // SECURE' : 'TAP TO INITIALIZE CORE',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              letterSpacing: 2,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11, letterSpacing: 1.5)),
        const SizedBox(height: 6),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }
}
