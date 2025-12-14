import 'package:flutter/material.dart';

class HealthTrackerPage extends StatefulWidget {
  const HealthTrackerPage({super.key});

  @override
  State<HealthTrackerPage> createState() => _HealthTrackerPageState();
}

class _HealthTrackerPageState extends State<HealthTrackerPage> {
  final _sysCtrl = TextEditingController();
  final _diaCtrl = TextEditingController();
  final _sugarCtrl = TextEditingController();

  String _sysStatus = "-";
  String _diaStatus = "-";
  String _sugarStatus = "-";

  void _check() {
    final sys = int.tryParse(_sysCtrl.text.trim());
    final dia = int.tryParse(_diaCtrl.text.trim());
    final sugar = double.tryParse(_sugarCtrl.text.trim());

    if (sys == null || dia == null || sugar == null || sys <= 0 || dia <= 0 || sugar <= 0) {
      _showSnack("Enter valid values");
      return;
    }

    // Demo rules (not medical advice)
    String sysSt;
    if (sys < 90) {
      sysSt = "Low";
    } else if (sys <= 119) {
      sysSt = "Normal";
    } else if (sys <= 139) {
      sysSt = "Elevated";
    } else {
      sysSt = "High";
    }

    String diaSt;
    if (dia < 60) {
      diaSt = "Low";
    } else if (dia <= 79) {
      diaSt = "Normal";
    } else if (dia <= 89) {
      diaSt = "Elevated";
    } else {
      diaSt = "High";
    }

    String sugSt;
    if (sugar < 70) {
      sugSt = "Low";
    } else if (sugar <= 140) {
      sugSt = "Normal";
    } else {
      sugSt = "High";
    }

    setState(() {
      _sysStatus = sysSt;
      _diaStatus = diaSt;
      _sugarStatus = sugSt;
    });
  }

  void _reset() {
    _sysCtrl.clear();
    _diaCtrl.clear();
    _sugarCtrl.clear();
    setState(() {
      _sysStatus = "-";
      _diaStatus = "-";
      _sugarStatus = "-";
    });
  }

  Color _statusColor(BuildContext context, String s) {
    final cs = Theme.of(context).colorScheme;
    switch (s) {
      case "Normal":
        return cs.primary;
      case "Elevated":
        return cs.tertiary;
      case "Low":
        return cs.secondary;
      case "High":
        return cs.error;
      default:
        return cs.outline;
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    _sysCtrl.dispose();
    _diaCtrl.dispose();
    _sugarCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ====== INPUTS (Blood Pressure) ======
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Blood Pressure", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),

                TextField(
                  controller: _sysCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Systolic (SYS)",
                    border: OutlineInputBorder(),
                    hintText: "e.g. 120",
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: _diaCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Diastolic (DIA)",
                    border: OutlineInputBorder(),
                    hintText: "e.g. 80",
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        // ====== INPUTS (Blood Sugar) ======
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Blood Sugar", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),

                TextField(
                  controller: _sugarCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Sugar (mg/dL)",
                    border: OutlineInputBorder(),
                    hintText: "e.g. 110",
                    prefixIcon: Icon(Icons.bloodtype_rounded),
                  ),
                  onSubmitted: (_) => _check(),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _check,
                        icon: const Icon(Icons.health_and_safety_rounded),
                        label: const Text("Check"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _reset,
                        icon: const Icon(Icons.restart_alt_rounded),
                        label: const Text("Reset"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        // ====== RESULTS (Below with ranges) ======
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Results", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),

                ListTile(
                  leading: const Icon(Icons.monitor_heart_rounded),
                  title: const Text("Systolic (SYS)"),
                  subtitle: const Text(
                    "Range: Normal 90–119 | Elevated 120–139 | High ≥ 140 | Low < 90",
                  ),
                  trailing: Text(
                    _sysStatus,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _statusColor(context, _sysStatus),
                    ),
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.monitor_heart_rounded),
                  title: const Text("Diastolic (DIA)"),
                  subtitle: const Text(
                    "Range: Normal 60–79 | Elevated 80–89 | High ≥ 90 | Low < 60",
                  ),
                  trailing: Text(
                    _diaStatus,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _statusColor(context, _diaStatus),
                    ),
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.bloodtype_rounded),
                  title: const Text("Blood Sugar"),
                  subtitle: const Text(
                    "Range: Normal 70–140 | Low < 70 | High > 140",
                  ),
                  trailing: Text(
                    _sugarStatus,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _statusColor(context, _sugarStatus),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  "Note: Demo ranges for assignment only (not medical diagnosis).",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
