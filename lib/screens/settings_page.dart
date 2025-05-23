import 'package:flutter/material.dart';
import 'package:student_portal/widgets/custom_app_bar.dart';
import 'package:student_portal/widgets/footer.dart';
// for _Sidebar

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Scaffold(
      appBar: CustomAppBar(
        onLogout: () => Navigator.pushReplacementNamed(context, '/login'),
      ),
      body: Row(
        children: [
          _Sidebar(isMobile: isMobile, selectedIndex: 4),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      _settingsCard(
                        Icons.person,
                        "Profile Settings",
                        "Update your profile information",
                      ),
                      _settingsCard(
                        Icons.lock,
                        "Change Password",
                        "Update your account password",
                      ),
                      _settingsCard(
                        Icons.notifications,
                        "Notifications",
                        "Manage notification preferences",
                      ),
                      _settingsCard(
                        Icons.language,
                        "Language",
                        "Select your preferred language",
                      ),
                      _settingsCard(
                        Icons.dark_mode,
                        "Theme",
                        "Switch between light and dark mode",
                      ),
                    ],
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

  Widget _settingsCard(IconData icon, String title, String subtitle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.green, size: 32),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
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
