import 'package:flutter/material.dart';
import 'package:student_portal/widgets/custom_app_bar.dart';
import 'package:student_portal/widgets/footer.dart';
import 'academics_page.dart'; // for _Sidebar

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});
  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  String selectedRequest = "Change Course";
  final List<String> requestTypes = [
    "Change Course",
    "Close Account",
    "Dead Semester",
    "Dead Year",
    "Repeat",
    "Special Exams",
  ];
  final TextEditingController requestController = TextEditingController();
  final TextEditingController inquiryController = TextEditingController();

  // Mock admin responses
  final List<Map<String, String>> adminResponses = [
    {
      "title": "Special Exams Request",
      "response":
          "Your request for special exams has been approved. Please check your email for further instructions.",
      "date": "2025-05-20",
    },
    {
      "title": "Dead Semester",
      "response":
          "Your dead semester application is under review. You will be notified soon.",
      "date": "2025-05-18",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Scaffold(
      appBar: CustomAppBar(
        onLogout: () => Navigator.pushReplacementNamed(context, '/login'),
      ),
      body: Row(
        children: [
          _Sidebar(isMobile: isMobile, selectedIndex: 3),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Support",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Admin Responses Section
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Responses from Admin",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...adminResponses.map(
                            (resp) => ListTile(
                              leading: const Icon(
                                Icons.mark_email_read,
                                color: Colors.green,
                              ),
                              title: Text(resp["title"]!),
                              subtitle: Text(resp["response"]!),
                              trailing: Text(
                                resp["date"]!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Send Request Section
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Send a Request",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                "Request Type: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              DropdownButton<String>(
                                value: selectedRequest,
                                items:
                                    requestTypes
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    selectedRequest = val!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: requestController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: "Describe your request / Reasoning",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.send),
                            label: const Text("Send Request"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // You can add logic to send the request here
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Request sent!")),
                              );
                              requestController.clear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // General Inquiry Section
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "General Inquiry / Support",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: inquiryController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: "Type your inquiry or support request",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.support_agent),
                            label: const Text("Send Inquiry"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // You can add logic to send the inquiry here
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Inquiry sent!")),
                              );
                              inquiryController.clear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppFooter(),
    );
  }
}

// --- Sidebar Widget (unchanged, but ensure selectedIndex is passed correctly) ---
class _Sidebar extends StatefulWidget {
  final bool isMobile;
  final int selectedIndex;
  const _Sidebar({required this.isMobile, required this.selectedIndex});

  @override
  State<_Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<_Sidebar> {
  int? hoveredIndex;

  final items = const [
    {'icon': Icons.dashboard, 'label': 'Dashboard'},
    {'icon': Icons.school, 'label': 'Academics'},
    {'icon': Icons.account_balance_wallet, 'label': 'Finance'},
    {'icon': Icons.support_agent, 'label': 'Support'},
    {'icon': Icons.settings, 'label': 'Settings'},
  ];

  void _onTap(int index) {
    if (index == widget.selectedIndex) return;
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/academics');
    } else if (index == 4) {
      Navigator.pushReplacementNamed(context, '/settings');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/support');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/finance');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sidebarHeight =
        MediaQuery.of(context).size.height * (widget.isMobile ? 0.9 : 0.85);

    return Container(
      width: widget.isMobile ? 70 : 220,
      height: sidebarHeight,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.05,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF145A32), Color(0xFF27AE60)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          for (int i = 0; i < items.length; i++)
            MouseRegion(
              onEnter: (_) => setState(() => hoveredIndex = i),
              onExit: (_) => setState(() => hoveredIndex = null),
              child: GestureDetector(
                onTap: () => _onTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  padding:
                      widget.isMobile
                          ? const EdgeInsets.symmetric(vertical: 8)
                          : const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                  decoration: BoxDecoration(
                    color:
                        widget.selectedIndex == i
                            ? Colors.white.withOpacity(0.18)
                            : hoveredIndex == i
                            ? Colors.white.withOpacity(0.10)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child:
                      widget.isMobile
                          ? Column(
                            children: [
                              Icon(
                                items[i]['icon'] as IconData,
                                color:
                                    widget.selectedIndex == i
                                        ? Colors.white
                                        : hoveredIndex == i
                                        ? Colors.greenAccent
                                        : Colors.white70,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                items[i]['label'] as String,
                                style: TextStyle(
                                  color:
                                      widget.selectedIndex == i
                                          ? Colors.white
                                          : hoveredIndex == i
                                          ? Colors.greenAccent
                                          : Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          )
                          : Row(
                            children: [
                              const SizedBox(width: 12),
                              Icon(
                                items[i]['icon'] as IconData,
                                color:
                                    widget.selectedIndex == i
                                        ? Colors.white
                                        : hoveredIndex == i
                                        ? Colors.greenAccent
                                        : Colors.white70,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                items[i]['label'] as String,
                                style: TextStyle(
                                  color:
                                      widget.selectedIndex == i
                                          ? Colors.white
                                          : hoveredIndex == i
                                          ? Colors.greenAccent
                                          : Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Tab Button Widget
class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
