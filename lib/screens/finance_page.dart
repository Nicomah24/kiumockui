import 'package:flutter/material.dart';
import 'package:student_portal/widgets/custom_app_bar.dart';
import 'package:student_portal/widgets/footer.dart';
import 'academics_page.dart'; // for _Sidebar

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});
  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  int selectedSection =
      0; // 0=Breakdown, 1=Deadlines, 2=History, 3=Reminders, 4=Make Payment, 5=Help
  String deadlineFilter = "Upcoming";
  final List<String> deadlineFilters = ["Upcoming", "Exceeded", "All"];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    // Mock data
    final double tuitionTotal = 2500000;
    final double tuitionPaid = 1800000;
    final double tuitionBalance = tuitionTotal - tuitionPaid;
    final double tuitionPercent = tuitionPaid / tuitionTotal;

    return Scaffold(
      appBar: CustomAppBar(
        onLogout: () => Navigator.pushReplacementNamed(context, '/login'),
      ),
      body: Row(
        children: [
          _Sidebar(isMobile: isMobile, selectedIndex: 2),
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
                                children: [
                                  _StudentProfileCard(),
                                  const SizedBox(height: 16),
                                  _TuitionStatus(
                                    total: tuitionTotal,
                                    paid: tuitionPaid,
                                    balance: tuitionBalance,
                                  ),
                                  const SizedBox(height: 16),
                                  _TuitionProgressIndicator(
                                    percent: tuitionPercent,
                                  ),
                                ],
                              )
                              : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: _StudentProfileCard(),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: _TuitionStatus(
                                      total: tuitionTotal,
                                      paid: tuitionPaid,
                                      balance: tuitionBalance,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: _TuitionProgressIndicator(
                                      percent: tuitionPercent,
                                    ),
                                  ),
                                ],
                              ),
                    ),
                  ),
                  // --- Toggles ---
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _TabButton(
                          label: "Tuition Breakdown",
                          selected: selectedSection == 0,
                          onTap: () => setState(() => selectedSection = 0),
                        ),
                        const SizedBox(width: 8),
                        _TabButton(
                          label: "Deadlines",
                          selected: selectedSection == 1,
                          onTap: () => setState(() => selectedSection = 1),
                        ),
                        const SizedBox(width: 8),
                        _TabButton(
                          label: "Payment History",
                          selected: selectedSection == 2,
                          onTap: () => setState(() => selectedSection = 2),
                        ),
                        const SizedBox(width: 8),
                        _TabButton(
                          label: "Reminders",
                          selected: selectedSection == 3,
                          onTap: () => setState(() => selectedSection = 3),
                        ),
                        const SizedBox(width: 8),
                        _TabButton(
                          label: "Make Payment",
                          selected: selectedSection == 4,
                          onTap: () => setState(() => selectedSection = 4),
                        ),
                        const SizedBox(width: 8),
                        _TabButton(
                          label: "Help",
                          selected: selectedSection == 5,
                          onTap: () => setState(() => selectedSection = 5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // --- Section Content ---
                  if (selectedSection == 0) _TuitionBreakdown(),
                  if (selectedSection == 1)
                    _DeadlinesSection(
                      filter: deadlineFilter,
                      onFilterChanged:
                          (val) => setState(
                            () => deadlineFilter = val ?? deadlineFilter,
                          ),
                    ),
                  if (selectedSection == 2) _PaymentHistorySection(),
                  if (selectedSection == 3) _RemindersSection(),
                  if (selectedSection == 4) _MakePaymentSection(),
                  if (selectedSection == 5) _FinanceHelpSection(),
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

// --- Student Profile Card ---
class _StudentProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: const AssetImage('assets/KIU_logo.png'),
            ),
            const SizedBox(width: 14),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Watiti Nicholas",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Reg No: 2024-08-27962",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                Text(
                  "BSc Software Engineering",
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Tuition Status ---
class _TuitionStatus extends StatelessWidget {
  final double total, paid, balance;
  const _TuitionStatus({
    required this.total,
    required this.paid,
    required this.balance,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tuition Status",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.account_balance_wallet, color: Colors.green),
            const SizedBox(width: 8),
            Text("Total: UGX ${total.toStringAsFixed(0)}"),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Text("Paid: UGX ${paid.toStringAsFixed(0)}"),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.warning, color: Colors.red),
            const SizedBox(width: 8),
            Text("Balance: UGX ${balance.toStringAsFixed(0)}"),
          ],
        ),
      ],
    );
  }
}

// --- Tuition Progress Indicator ---
class _TuitionProgressIndicator extends StatelessWidget {
  final double percent;
  const _TuitionProgressIndicator({required this.percent});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
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
            Text(
              "${(percent * 100).toStringAsFixed(1)}%",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          percent >= 1.0 ? "Fully Paid" : "In Progress",
          style: TextStyle(
            color: percent >= 1.0 ? Colors.green : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// --- Tuition Breakdown Section ---
class _TuitionBreakdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Tuition Breakdown",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.school, color: Colors.green),
              title: Text("Tuition"),
              trailing: Text("UGX 2,000,000"),
            ),
            ListTile(
              leading: Icon(Icons.receipt_long, color: Colors.green),
              title: Text("Functional Fees"),
              trailing: Text("UGX 300,000"),
            ),
            ListTile(
              leading: Icon(Icons.warning_amber, color: Colors.red),
              title: Text("Surcharges"),
              trailing: Text("UGX 50,000"),
            ),
            ListTile(
              leading: Icon(Icons.menu_book, color: Colors.green),
              title: Text("Practical Manual Fees"),
              trailing: Text("UGX 150,000"),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Deadlines Section ---
class _DeadlinesSection extends StatelessWidget {
  final String filter;
  final ValueChanged<String?> onFilterChanged;
  const _DeadlinesSection({
    required this.filter,
    required this.onFilterChanged,
  });
  @override
  Widget build(BuildContext context) {
    // Mock deadlines
    final allDeadlines = [
      {"title": "Tuition Payment", "date": "2025-06-10", "status": "Upcoming"},
      {
        "title": "Exam Registration",
        "date": "2025-06-15",
        "status": "Upcoming",
      },
      {
        "title": "Surcharge Payment",
        "date": "2025-05-10",
        "status": "Exceeded",
      },
      {"title": "Library Fine", "date": "2025-05-05", "status": "Exceeded"},
      {
        "title": "Practical Manual Fee",
        "date": "2025-06-20",
        "status": "Upcoming",
      },
      {"title": "Graduation Fee", "date": "2025-07-01", "status": "Upcoming"},
    ];
    final filtered =
        filter == "All"
            ? allDeadlines
            : allDeadlines.where((d) => d["status"] == filter).toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Deadlines",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: filter,
                  items:
                      ["Upcoming", "Exceeded", "All"]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: onFilterChanged,
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...filtered.map(
              (d) => ListTile(
                leading: Icon(
                  d["status"] == "Upcoming"
                      ? Icons.schedule
                      : Icons.warning_amber,
                  color: d["status"] == "Upcoming" ? Colors.green : Colors.red,
                ),
                title: Text(d["title"]!),
                subtitle: Text("Due: ${d["date"]}"),
                trailing: Text(
                  d["status"]!,
                  style: TextStyle(
                    color:
                        d["status"] == "Upcoming" ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
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

// --- Payment History Section ---
class _PaymentHistorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock payment history
    final payments = [
      {"date": "2025-05-01", "method": "MTN", "amount": "500,000"},
      {"date": "2025-04-15", "method": "Airtel", "amount": "300,000"},
      {"date": "2025-03-20", "method": "Bank Card", "amount": "700,000"},
      {"date": "2025-02-10", "method": "Bank Transfer", "amount": "300,000"},
    ];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment History",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            DataTable(
              columns: const [
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("Method")),
                DataColumn(label: Text("Amount")),
              ],
              rows:
                  payments
                      .map(
                        (p) => DataRow(
                          cells: [
                            DataCell(Text(p["date"]!)),
                            DataCell(
                              Row(
                                children: [
                                  Icon(
                                    p["method"] == "MTN"
                                        ? Icons.phone_android
                                        : p["method"] == "Airtel"
                                        ? Icons.phone_iphone
                                        : p["method"] == "Bank Card"
                                        ? Icons.credit_card
                                        : Icons.account_balance,
                                    color: Colors.green,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(p["method"]!),
                                ],
                              ),
                            ),
                            DataCell(Text("UGX ${p["amount"]}")),
                          ],
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

// --- Reminders Section ---
class _RemindersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock reminders
    final reminders = [
      "Your next tuition installment is due soon.",
      "Exam registration deadline is approaching.",
      "Outstanding balance must be cleared before exams.",
    ];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Reminders",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            ...reminders.map(
              (r) => ListTile(
                leading: const Icon(
                  Icons.notifications_active,
                  color: Colors.orange,
                ),
                title: Text(r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Make Payment Section ---
class _MakePaymentSection extends StatefulWidget {
  @override
  State<_MakePaymentSection> createState() => _MakePaymentSectionState();
}

class _MakePaymentSectionState extends State<_MakePaymentSection> {
  final List<String> paymentMethods = [
    "MTN Mobile Money",
    "Airtel Money",
    "Bank Card",
    "Bank Transfer",
  ];
  String selectedMethod = "MTN Mobile Money";
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cardController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  bool isProcessing = false;
  bool showReceipt = false;
  Map<String, dynamic>? receiptData;

  double get processingFee => 1000;

  void _showConfirmDialog() {
    final amount = double.tryParse(amountController.text) ?? 0;
    final total = amount + processingFee;
    String account = "";
    if (selectedMethod == "MTN Mobile Money" ||
        selectedMethod == "Airtel Money") {
      account = phoneController.text;
    } else if (selectedMethod == "Bank Card") {
      account = cardController.text;
    } else if (selectedMethod == "Bank Transfer") {
      account = bankController.text;
    }
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Confirm Payment"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You are about to pay UGX ${amount.toStringAsFixed(0)} + UGX 1,000 processing fee.",
                ),
                const SizedBox(height: 8),
                Text("Total to be charged: UGX ${total.toStringAsFixed(0)}"),
                const SizedBox(height: 8),
                Text("From: $account"),
                const SizedBox(height: 8),
                const Text("Student: Watiti Nicholas"),
                const Text("Reg No: 2024-08-27962"),
              ],
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text("Confirm"),
                onPressed: () {
                  Navigator.pop(context);
                  _simulatePayment(amount, total, account);
                },
              ),
            ],
          ),
    );
  }

  void _simulatePayment(double amount, double total, String account) async {
    setState(() {
      isProcessing = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isProcessing = false;
      showReceipt = true;
      receiptData = {
        "amount": amount,
        "total": total,
        "account": account,
        "method": selectedMethod,
        "date": DateTime.now(),
        "student": "Watiti Nicholas",
        "regNo": "2024-08-27962",
        "class": "BSc Software Engineering, Year 3, Semester 1",
        "receiptNo": "KIU${DateTime.now().millisecondsSinceEpoch}",
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isProcessing) {
      return Center(
        child: Column(
          children: const [
            SizedBox(height: 40),
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Processing payment...", style: TextStyle(fontSize: 16)),
          ],
        ),
      );
    }
    if (showReceipt && receiptData != null) {
      final r = receiptData!;
      return Center(
        child: Card(
          color: Colors.grey[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/KIU_logo.png', width: 60),
                const SizedBox(height: 8),
                const Text(
                  "KAMPALA INTERNATIONAL UNIVERSITY",
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "RECEIPT NO: ${r['receiptNo']}",
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                ),
                const Divider(thickness: 1.2),
                Text(
                  "Paid to: KIU Student Account",
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  "Student: ${r['student']}\nReg No: ${r['regNo']}\nClass: ${r['class']}",
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Payment Method: ${r['method']}\nFrom: ${r['account']}",
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Amount Paid: UGX ${r['amount'].toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Processing Fee: UGX 1,000",
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                ),
                const Divider(thickness: 1.2),
                Text(
                  "Total Charged: UGX ${r['total'].toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Date: ${r['date'].toString().substring(0, 16)}",
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Thank you for your payment!",
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.close),
                  label: const Text("Close"),
                  onPressed: () {
                    setState(() {
                      showReceipt = false;
                      receiptData = null;
                      phoneController.clear();
                      cardController.clear();
                      bankController.clear();
                      amountController.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Payment form
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Make Payment",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  "Payment Method: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedMethod,
                  items:
                      paymentMethods
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedMethod = val!;
                      phoneController.clear();
                      cardController.clear();
                      bankController.clear();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (selectedMethod == "MTN Mobile Money" ||
                selectedMethod == "Airtel Money")
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: const Icon(Icons.phone_android),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            if (selectedMethod == "Bank Card")
              TextField(
                controller: cardController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Card Number",
                  prefixIcon: const Icon(Icons.credit_card),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            if (selectedMethod == "Bank Transfer")
              TextField(
                controller: bankController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Bank Account Number",
                  prefixIcon: const Icon(Icons.account_balance),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount (UGX)",
                prefixIcon: const Icon(Icons.attach_money),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.info, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  "You will be debited your tuition amount plus a processing fee of UGX 1,000.",
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.payment),
              label: const Text("Confirm Payment"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (amountController.text.isEmpty ||
                    ((selectedMethod == "MTN Mobile Money" ||
                            selectedMethod == "Airtel Money") &&
                        phoneController.text.isEmpty) ||
                    (selectedMethod == "Bank Card" &&
                        cardController.text.isEmpty) ||
                    (selectedMethod == "Bank Transfer" &&
                        bankController.text.isEmpty)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill all required fields."),
                    ),
                  );
                  return;
                }
                _showConfirmDialog();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- Finance Help Section ---
class _FinanceHelpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController helpController = TextEditingController();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Finance Office Help",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            const Text(
              "Reach out to the finance office for any inquiries or support.",
            ),
            const SizedBox(height: 12),
            TextField(
              controller: helpController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Type your message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.support_agent),
              label: const Text("Send"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Message sent to finance office!"),
                  ),
                );
                helpController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- Tab Button Widget ---
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
