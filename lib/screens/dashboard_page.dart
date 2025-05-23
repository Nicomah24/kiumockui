import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';

import '../widgets/news_feed_section.dart';
import '../widgets/calendar_dialog.dart';
import 'news_list_page.dart';
import 'news_article_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    // Mock news data
    final List<Map<String, String>> mockNews = [
      {
        'title': 'Semester Registration Open',
        'summary':
            'Registration for Semester II is now open. Please register before the deadline.',
        'date': '2025-05-22',
      },
      {
        'title': 'New Library Resources',
        'summary':
            'The university library has added new e-books and journals for all students.',
        'date': '2025-05-20',
      },
      {
        'title': 'Upcoming Career Fair',
        'summary':
            'Join the annual career fair to meet top employers and explore opportunities.',
        'date': '2025-05-18',
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(
        onLogout: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
      body: Row(
        children: [
          _Sidebar(isMobile: isMobile, selectedIndex: 0),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top right buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.calendar_today),
                        label: const Text("Calendar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => CalendarDialog(),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.app_registration),
                        label: const Text("Register for Semester"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Profile Frame
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF145A32), Color(0xFF27AE60)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.15),
                          blurRadius: 24,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: const AssetImage('myprofile.png'),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(height: 8),
                              Text(
                                "Watiti Nicholas",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Reg No: 2024-08-27962",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                "Admission No: 639806",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // News Feed Section
                  NewsFeedSection(
                    newsList: mockNews,
                    onReadMore: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewsListPage(newsList: mockNews),
                        ),
                      );
                    },
                    onArticleTap: (i) {
                      final news = mockNews[i];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => NewsArticlePage(
                                title: news['title']!,
                                content:
                                    news['summary']! +
                                    "\n\nFull article content here...",
                                date: news['date']!,
                              ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  // Info Sections: Responsive Layout
                  isMobile
                      ? Column(
                        children: [
                          _SectionCard(
                            title: "Basic Information",
                            children: const [
                              _InfoRow(label: "First Name", value: "Watiti"),
                              _InfoRow(label: "Second Name", value: "Nicholas"),
                              _InfoRow(label: "Other Names", value: ""),
                              _InfoRow(
                                label: "Primary Phone",
                                value: "+256 700 000000",
                              ),
                              _InfoRow(
                                label: "Secondary Phone",
                                value: "+256 701 111111",
                              ),
                              _InfoRow(
                                label: "Email",
                                value: "john.doe@gmail.com",
                              ),
                              _InfoRow(
                                label: "University Email",
                                value: "20240827962@stdwc.kiu.ac.ug",
                              ),
                              _InfoRow(label: "Nationality", value: "Ugandan"),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _SectionCard(
                            title: "Academic Details",
                            children: const [
                              _InfoRow(
                                label: "Campus",
                                value: "Western campus",
                              ),
                              _InfoRow(
                                label: "College/School",
                                value: "Faculty of Biomedical Sciences",
                              ),
                              _InfoRow(label: "Department", value: "Anatomy"),
                              _InfoRow(
                                label: "Programme",
                                value:
                                    "Bachelor of Medicine and Bachelor of Surgery",
                              ),
                              _InfoRow(label: "Entry Mode", value: "Direct"),
                              _InfoRow(
                                label: "Registration Number",
                                value: "2024-08-27962",
                              ),
                              _InfoRow(
                                label: "Admission Number",
                                value: "639806",
                              ),
                              _InfoRow(
                                label: "Intake",
                                value: "Aug/Sep - 2024/2025",
                              ),
                              _InfoRow(label: "Session", value: "Day"),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _SectionCard(
                            title: "Disciplinary Status",
                            children: const [
                              _InfoRow(label: "Status", value: "Clean History"),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _SectionCard(
                            title: "Financial Information",
                            children: const [
                              _InfoRow(
                                label: "Sponsorship",
                                value: "KIU Scholarship Scheme (Bursaries)",
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _SectionCard(
                            title: "Residence Information",
                            children: const [
                              _InfoRow(
                                label: "Place of Residence",
                                value: "Off campus housing",
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _SectionCard(
                            title: "Academic Information",
                            children: const [
                              _InfoRow(label: "Study Year", value: "1"),
                              _InfoRow(label: "Semester", value: "II"),
                              _InfoRow(
                                label: "Academic Status",
                                value: "Reported",
                              ),
                            ],
                          ),
                        ],
                      )
                      : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left column
                          Expanded(
                            child: Column(
                              children: [
                                _SectionCard(
                                  title: "Basic Information",
                                  children: const [
                                    _InfoRow(
                                      label: "First Name",
                                      value: "Watiti",
                                    ),
                                    _InfoRow(
                                      label: "Second Name",
                                      value: "Nicholas",
                                    ),
                                    _InfoRow(label: "Other Names", value: ""),
                                    _InfoRow(
                                      label: "Primary Phone",
                                      value: "+256 700 000000",
                                    ),
                                    _InfoRow(
                                      label: "Secondary Phone",
                                      value: "+256 701 111111",
                                    ),
                                    _InfoRow(
                                      label: "Email",
                                      value: "john.doe@gmail.com",
                                    ),
                                    _InfoRow(
                                      label: "University Email",
                                      value: "20240827962@stdwc.kiu.ac.ug",
                                    ),
                                    _InfoRow(
                                      label: "Nationality",
                                      value: "Ugandan",
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                _SectionCard(
                                  title: "Disciplinary Status",
                                  children: const [
                                    _InfoRow(
                                      label: "Status",
                                      value: "Clean History",
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                _SectionCard(
                                  title: "Residence Information",
                                  children: const [
                                    _InfoRow(
                                      label: "Place of Residence",
                                      value: "Off campus housing",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Right column
                          Expanded(
                            child: Column(
                              children: [
                                _SectionCard(
                                  title: "Academic Details",
                                  children: const [
                                    _InfoRow(
                                      label: "Campus",
                                      value: "Western campus",
                                    ),
                                    _InfoRow(
                                      label: "College/School",
                                      value: "Faculty of Biomedical Sciences",
                                    ),
                                    _InfoRow(
                                      label: "Department",
                                      value: "Anatomy",
                                    ),
                                    _InfoRow(
                                      label: "Programme",
                                      value:
                                          "Bachelor of Medicine and Bachelor of Surgery",
                                    ),
                                    _InfoRow(
                                      label: "Entry Mode",
                                      value: "Direct",
                                    ),
                                    _InfoRow(
                                      label: "Registration Number",
                                      value: "2024-08-27962",
                                    ),
                                    _InfoRow(
                                      label: "Admission Number",
                                      value: "639806",
                                    ),
                                    _InfoRow(
                                      label: "Intake",
                                      value: "Aug/Sep - 2024/2025",
                                    ),
                                    _InfoRow(label: "Session", value: "Day"),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                _SectionCard(
                                  title: "Financial Information",
                                  children: const [
                                    _InfoRow(
                                      label: "Sponsorship",
                                      value:
                                          "KIU Scholarship Scheme (Bursaries)",
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                _SectionCard(
                                  title: "Academic Information",
                                  children: const [
                                    _InfoRow(label: "Study Year", value: "1"),
                                    _InfoRow(label: "Semester", value: "II"),
                                    _InfoRow(
                                      label: "Academic Status",
                                      value: "Reported",
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/finance');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/support');
    } else if (index == 4) {
      Navigator.pushReplacementNamed(context, '/settings');
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
class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 170,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}
