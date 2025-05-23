import 'package:flutter/material.dart';
import 'package:student_portal/widgets/custom_app_bar.dart';
import 'package:student_portal/widgets/footer.dart';

class AcademicsPage extends StatefulWidget {
  const AcademicsPage({super.key});

  @override
  State<AcademicsPage> createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  int selectedSection =
      0; // 0=Course, 1=Results, 2=Program Info, 3=Lecture TT, 4=Exam TT

  // Dropdown for timetables
  String selectedLectureClass = "MBChB Year 1, Semester 2";
  String selectedExamClass = "MBChB Year 1, Semester 2";

  final List<String> classOptions = [
    "MBChB Year 1, Semester 2",
    "BSc Software Engineering Year 3, Semester 1",
    "BBA Year 2, Semester 1",
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      appBar: CustomAppBar(
        onLogout: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
      body: Row(
        children: [
          _Sidebar(isMobile: isMobile, selectedIndex: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Top Frame ---
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 32),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child:
                          isMobile
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ProgramCard(
                                    title: "Bachelors of Medicine and Bachelors of Surgery",
                                    faculty: "Faculty of clinical medicine and Dentidtry",
                                    year: "Year 3, Semester 1",
                                    admission: "2022",
                                    gradYear: "2026",
                                  ),
                                  const SizedBox(height: 24),
                                  AcademicProgressIndicator(
                                    percent: 0.643,
                                    completedCredits: 90,
                                    totalCredits: 140,
                                  ),
                                  const SizedBox(height: 16),
                                  MotivationalQuote(progressPercent: 64.3),
                                  const SizedBox(height: 16),
                                  ProgressSection(
                                    totalCredits: 140,
                                    completedCredits: 90,
                                    progressPercent: 64.3,
                                  ),
                                ],
                              )
                              : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Program Info
                                  Expanded(
                                    flex: 2,
                                    child: ProgramCard(
                                      title: "Bachelors of Medicine and Surgery ",
                                      faculty: "School of Computing",
                                      year: "Year 3, Semester 1",
                                      admission: "2022",
                                      gradYear: "2026",
                                    ),
                                  ),
                                  // Progress Indicator
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AcademicProgressIndicator(
                                          percent: 0.643,
                                          completedCredits: 90,
                                          totalCredits: 140,
                                        ),
                                        const SizedBox(height: 12),
                                        MotivationalQuote(
                                          progressPercent: 64.3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Progress Section
                                  Expanded(
                                    flex: 2,
                                    child: ProgressSection(
                                      totalCredits: 140,
                                      completedCredits: 90,
                                      progressPercent: 64.3,
                                    ),
                                  ),
                                ],
                              ),
                    ),
                  ),
                  // --- End Top Frame ---

                  // Title and Profile
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile widget
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: const AssetImage('myprofile.png'),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Watiti Nicholas",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Reg No: 2024-08-27962",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Content
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _TabButton(
                          label: "Course",
                          selected: selectedSection == 0,
                          onTap: () => setState(() => selectedSection = 0),
                        ),
                        const SizedBox(width: 8),
                        _TabButton(
                          label: "Results",
                          selected: selectedSection == 1,
                          onTap: () => setState(() => selectedSection = 1),
                        ),
                        const SizedBox(width: 8),
                        _TabButton(
                          label: "Program Info",
                          selected: selectedSection == 2,
                          onTap: () => setState(() => selectedSection = 2),
                        ),
                        const SizedBox(width: 8),
                        _TabButton(
                          label: "Lecture Timetable",
                          selected: selectedSection == 3,
                          onTap: () => setState(() => selectedSection = 3),
                        ),
                        const SizedBox(width: 8),
                        _TabButton(
                          label: "Exam Timetable",
                          selected: selectedSection == 4,
                          onTap: () => setState(() => selectedSection = 4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Section Content ---
                  if (selectedSection == 0) _CourseContent(),
                  if (selectedSection == 1) _ResultsContent(),
                  if (selectedSection == 2)
                    ProgramCard(
                      title: "BSc Software Engineering",
                      faculty: "School of Computing",
                      year: "Year 3, Semester 1",
                      admission: "2022",
                      gradYear: "2026",
                    ),
                  if (selectedSection == 3)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Select Class: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: selectedLectureClass,
                              items:
                                  classOptions
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedLectureClass = val!;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (selectedLectureClass == "MBChB Year 1, Semester 2")
                          MBChBLectureTimetable()
                        else if (selectedLectureClass ==
                            "BSc Software Engineering Year 3, Semester 1")
                          MockLectureTimetable(
                            title:
                                "BSc Software Engineering Year 3, Semester 1",
                          )
                        else
                          MockLectureTimetable(title: "BBA Year 2, Semester 1"),
                      ],
                    ),
                  if (selectedSection == 4)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Select Class: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: selectedExamClass,
                              items:
                                  classOptions
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedExamClass = val!;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (selectedExamClass == "MBChB Year 1, Semester 2")
                          MBChBExamTimetable()
                        else if (selectedExamClass ==
                            "BSc Software Engineering Year 3, Semester 1")
                          MockExamTimetable(
                            title:
                                "BSc Software Engineering Year 3, Semester 1",
                          )
                        else
                          MockExamTimetable(title: "BBA Year 2, Semester 1"),
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

// --- Program Card Widget ---
class ProgramCard extends StatelessWidget {
  final String title, faculty, year, admission, gradYear;
  const ProgramCard({
    required this.title,
    required this.faculty,
    required this.year,
    required this.admission,
    required this.gradYear,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          faculty,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        Text(year, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 6),
        Text("Admission: $admission", style: const TextStyle(fontSize: 14)),
        Text(
          "Expected Graduation: $gradYear",
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

// --- Academic Progress Indicator Widget ---
class AcademicProgressIndicator extends StatelessWidget {
  final double percent;
  final int completedCredits;
  final int totalCredits;
  const AcademicProgressIndicator({
    required this.percent,
    required this.completedCredits,
    required this.totalCredits,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 90,
          height: 90,
          child: CircularProgressIndicator(
            value: percent,
            strokeWidth: 8,
            backgroundColor: Colors.green[100],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${(percent * 100).toStringAsFixed(1)}%",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              "$completedCredits/$totalCredits CU",
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}

// --- Motivational Quote Widget ---
class MotivationalQuote extends StatelessWidget {
  final double progressPercent;
  const MotivationalQuote({required this.progressPercent, super.key});

  @override
  Widget build(BuildContext context) {
    String quote;
    if (progressPercent < 30) {
      quote = "Every step counts. Keep going!";
    } else if (progressPercent < 60) {
      quote = "Great progress! Stay focused and persistent.";
    } else if (progressPercent < 90) {
      quote = "You're almost there. Finish strong!";
    } else {
      quote = "Congratulations! You're close to graduation.";
    }
    return Text(
      quote,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontStyle: FontStyle.italic,
        color: Colors.green,
        fontSize: 14,
      ),
    );
  }
}

// --- Progress Section Widget ---
class ProgressSection extends StatelessWidget {
  final int totalCredits;
  final int completedCredits;
  final double progressPercent;
  const ProgressSection({
    required this.totalCredits,
    required this.completedCredits,
    required this.progressPercent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Academic Progress",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Completed Credits: $completedCredits / $totalCredits",
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              "Progress: ${progressPercent.toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 14),
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

// Course Content Widget
class _CourseContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example: Only Year 1 Semester II shown, add more as needed
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SemesterSection(
          title: "Year 1 Semester II",
          courses: const [
            [
              "MHA110",
              "Human Anatomy I",
              "Semester II",
              "1",
              "4",
              "0",
              "10",
              "20",
              "45",
            ],
            [
              "MPH110",
              "Medical Physiology I",
              "Semester II",
              "1",
              "5",
              "0",
              "10",
              "20",
              "45",
            ],
            [
              "MBC110",
              "Medical Biochemistry I",
              "Semester II",
              "1",
              "2",
              "0",
              "0",
              "0",
              "0",
            ],
            [
              "MCO110",
              "Introduction to community and community diagnosis (COBERMS)",
              "Semester II",
              "1",
              "6",
              "0",
              "0",
              "60",
              "0",
            ],
            [
              "MSN110",
              "Nursing Skills/Process",
              "Semester II",
              "1",
              "2",
              "0",
              "10",
              "20",
              "45",
            ],
          ],
        ),
        // Add more _SemesterSection widgets for other semesters if needed
      ],
    );
  }
}

class _SemesterSection extends StatelessWidget {
  final String title;
  final List<List<String>> courses;
  const _SemesterSection({required this.title, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("S/N")),
                  DataColumn(label: Text("Course code")),
                  DataColumn(label: Text("Course name")),
                  DataColumn(label: Text("Semester")),
                  DataColumn(label: Text("Year")),
                  DataColumn(label: Text("CU")),
                  DataColumn(label: Text("LH")),
                  DataColumn(label: Text("TH")),
                  DataColumn(label: Text("PH")),
                  DataColumn(label: Text("CH")),
                ],
                rows: List.generate(
                  courses.length,
                  (i) => DataRow(
                    cells: [
                      DataCell(Text("${i + 1}")),
                      ...courses[i].map((e) => DataCell(Text(e))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Results Content Widget
class _ResultsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example: Only Year 1 Semester I and II shown, add more as needed
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ResultsSection(
          title: "Year 1 Semester I  2024/2025",
          results: const [
            ["MPP1108", "Chemistry", "33", "43", "--", "76", "2", "B+", "4.5"],
            [
              "MPP 1101",
              "Communication & Counseling Skills",
              "33",
              "43",
              "--",
              "76",
              "2",
              "B+",
              "4.5",
            ],
            ["MPP1105", "Biology", "33", "48", "--", "81", "2", "A", "5"],
            ["MPP1106", "Mathematics", "34", "59", "--", "93", "2", "A", "5"],
            ["MPP1107", "Physics", "32", "47", "--", "79", "2", "B+", "4.5"],
            [
              "MPP1102*",
              "Computer Applications",
              "34",
              "50",
              "--",
              "84",
              "2",
              "A",
              "5",
            ],
            [
              "MPP 1110",
              "Biostatistics",
              "39",
              "39",
              "--",
              "78",
              "2",
              "B+",
              "4.5",
            ],
            [
              "MPP 1111",
              "Research Methodology",
              "31",
              "35",
              "--",
              "66",
              "2",
              "C+",
              "3.5",
            ],
            [
              "MPP1103",
              "Behavioral Sciences",
              "36",
              "45",
              "--",
              "81",
              "2",
              "A",
              "5",
            ],
            [
              "MPP1104",
              "Principles of Ethics and Integrity",
              "25",
              "36",
              "--",
              "61",
              "2",
              "C",
              "3",
            ],
            [
              "MPP 1112",
              "Principles of Community Health and Epidemiology",
              "26",
              "24",
              "--",
              "50",
              "1",
              "D",
              "2",
            ],
            [
              "MPP1109*",
              "Entrepreneurship",
              "29",
              "31",
              "--",
              "60",
              "2",
              "C",
              "3",
            ],
          ],
          sgpa: "4.22",
        ),
        _ResultsSection(
          title: "Year 1 Semester II  2024/2025",
          results: const [
            [
              "MBC110",
              "Medical Biochemistry I",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
            ],
            [
              "MHA110",
              "Human Anatomy I",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
            ],
            [
              "MPH110",
              "Medical Physiology I",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
            ],
            [
              "MSN110",
              "Nursing Skills/process",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
            ],
            [
              "MCO110",
              "Introduction to Community and Community Diagnosis( Coberms)",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
              "PA",
            ],
          ],
          sgpa: "PA",
        ),
        const SizedBox(height: 16),
        const Text(
          "PA = Pending Approval   FF = Financial Flag   DF = Disciplinary Flag   NE = Not Examinable",
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }
}

class _ResultsSection extends StatelessWidget {
  final String title;
  final List<List<String>> results;
  final String sgpa;
  const _ResultsSection({
    required this.title,
    required this.results,
    required this.sgpa,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Course code")),
                  DataColumn(label: Text("Course title")),
                  DataColumn(label: Text("CW")),
                  DataColumn(label: Text("EXM")),
                  DataColumn(label: Text("Viva")),
                  DataColumn(label: Text("TT")),
                  DataColumn(label: Text("CU")),
                  DataColumn(label: Text("LG")),
                  DataColumn(label: Text("GP")),
                ],
                rows:
                    results
                        .map(
                          (row) => DataRow(
                            cells: row.map((e) => DataCell(Text(e))).toList(),
                          ),
                        )
                        .toList(),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  "SGPA: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  sgpa,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LectureTimetableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lecture Timetable",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            DataTable(
              columns: const [
                DataColumn(label: Text("Day")),
                DataColumn(label: Text("Time")),
                DataColumn(label: Text("Course")),
                DataColumn(label: Text("Venue")),
              ],
              rows: const [
                DataRow(
                  cells: [
                    DataCell(Text("Mon")),
                    DataCell(Text("8-10am")),
                    DataCell(Text("Software Eng. I")),
                    DataCell(Text("Lab 1")),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("Tue")),
                    DataCell(Text("10-12pm")),
                    DataCell(Text("Database Systems")),
                    DataCell(Text("Lab 2")),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("Wed")),
                    DataCell(Text("2-4pm")),
                    DataCell(Text("Networks")),
                    DataCell(Text("Room 5")),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExamTimetableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Exam Timetable",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            DataTable(
              columns: const [
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("Time")),
                DataColumn(label: Text("Course")),
                DataColumn(label: Text("Venue")),
              ],
              rows: const [
                DataRow(
                  cells: [
                    DataCell(Text("2025-06-10")),
                    DataCell(Text("9-12am")),
                    DataCell(Text("Software Eng. I")),
                    DataCell(Text("Main Hall")),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("2025-06-12")),
                    DataCell(Text("2-5pm")),
                    DataCell(Text("Database Systems")),
                    DataCell(Text("Lab 2")),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- MBChB Lecture Timetable Widget ---
class MBChBLectureTimetable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timetable = [
      [
        "8:00–9:00 AM",
        "Anatomy (Upper Limb)",
        "Physiology (Renal)",
        "Biochemistry (Metabolism)",
        "Anatomy (Lower Limb)",
        "Physiology (CVS)",
      ],
      [
        "9:00–10:00 AM",
        "Anatomy (Upper Limb)",
        "Physiology (Renal)",
        "Biochemistry (Metabolism)",
        "Anatomy (Lower Limb)",
        "Physiology (CVS)",
      ],
      ["10:00–11:00 AM", "BREAK", "BREAK", "BREAK", "BREAK", "BREAK"],
      [
        "11:00–12:00 PM",
        "Biochemistry (Enzymes)",
        "Community Health",
        "Anatomy (Embryology)",
        "Physiology (Respiratory)",
        "Biochemistry (Clinical)",
      ],
      [
        "12:00–1:00 PM",
        "Biochemistry (Enzymes)",
        "Community Health",
        "Anatomy (Embryology)",
        "Physiology (Respiratory)",
        "Biochemistry (Clinical)",
      ],
      ["1:00–2:00 PM", "LUNCH", "LUNCH", "LUNCH", "LUNCH", "LUNCH"],
      [
        "2:00–4:00 PM",
        "Dissection / Anatomy Practical",
        "Histology Practical",
        "Skills Lab (BP, Injection)",
        "Physiology Practical",
        "Library / PBL",
      ],
      [
        "4:00–5:00 PM",
        "Group Study / Tutorial",
        "Tutorial / Case-Based Learning",
        "Mentor Session / Free",
        "Group Discussion",
        "Reflection / Journal Club",
      ],
    ];
    final days = [
      "Time",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
    ];
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: days.map((d) => DataColumn(label: Text(d))).toList(),
            rows:
                timetable
                    .map(
                      (row) => DataRow(
                        cells: row.map((cell) => DataCell(Text(cell))).toList(),
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}

// --- Mock Lecture Timetable Widget ---
class MockLectureTimetable extends StatelessWidget {
  final String title;
  const MockLectureTimetable({required this.title});
  @override
  Widget build(BuildContext context) {
    final timetable = [
      [
        "8:00–10:00 AM",
        "Software Design",
        "Database Systems",
        "Networks",
        "Mobile Dev",
        "AI Fundamentals",
      ],
      [
        "10:00–12:00 PM",
        "Web Dev",
        "Software Design",
        "Database Systems",
        "Networks",
        "Mobile Dev",
      ],
      ["12:00–1:00 PM", "LUNCH", "LUNCH", "LUNCH", "LUNCH", "LUNCH"],
      [
        "1:00–3:00 PM",
        "Project",
        "Web Dev",
        "Software Design",
        "Database Systems",
        "Networks",
      ],
    ];
    final days = [
      "Time",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
    ];
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: days.map((d) => DataColumn(label: Text(d))).toList(),
                rows:
                    timetable
                        .map(
                          (row) => DataRow(
                            cells:
                                row
                                    .map((cell) => DataCell(Text(cell)))
                                    .toList(),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- MBChB Exam Timetable Widget ---
class MBChBExamTimetable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timetable = [
      ["2025-06-10", "9-12am", "Human Anatomy I", "Main Hall"],
      ["2025-06-12", "2-5pm", "Medical Physiology I", "Lab 2"],
      ["2025-06-14", "9-12am", "Medical Biochemistry I", "Lab 1"],
      ["2025-06-16", "2-5pm", "Community Health", "Room 5"],
      ["2025-06-18", "9-12am", "Nursing Skills/Process", "Skills Lab"],
    ];
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Exam Timetable – MBChB Year 1, Semester 2",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            DataTable(
              columns: const [
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("Time")),
                DataColumn(label: Text("Course")),
                DataColumn(label: Text("Venue")),
              ],
              rows:
                  timetable
                      .map(
                        (row) => DataRow(
                          cells:
                              row.map((cell) => DataCell(Text(cell))).toList(),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Mock Exam Timetable Widget ---
class MockExamTimetable extends StatelessWidget {
  final String title;
  const MockExamTimetable({required this.title});
  @override
  Widget build(BuildContext context) {
    final timetable = [
      ["2025-06-11", "9-12am", "Software Design", "Main Hall"],
      ["2025-06-13", "2-5pm", "Database Systems", "Lab 2"],
      ["2025-06-15", "9-12am", "Networks", "Lab 1"],
      ["2025-06-17", "2-5pm", "Mobile Dev", "Room 5"],
      ["2025-06-19", "9-12am", "AI Fundamentals", "Lab 3"],
    ];
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Exam Timetable – $title",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            DataTable(
              columns: const [
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("Time")),
                DataColumn(label: Text("Course")),
                DataColumn(label: Text("Venue")),
              ],
              rows:
                  timetable
                      .map(
                        (row) => DataRow(
                          cells:
                              row.map((cell) => DataCell(Text(cell))).toList(),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
