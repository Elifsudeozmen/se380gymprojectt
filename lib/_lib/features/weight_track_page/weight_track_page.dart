import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/profile_picture_page/profile_picture_page.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/registration_page.dart';
import 'package:gymproject/_lib/features/weight_height_page/data/services/bmi_service.dart';
import 'package:gymproject/_lib/features/weight_track_page/business/weight_model.dart';
import 'package:gymproject/_lib/features/weight_track_page/presentation/widgets/track_panel.dart';
import 'package:gymproject/_lib/features/weight_track_page/presentation/widgets/weight_control.dart';
import 'package:gymproject/_lib/features/weight_height_page/data/bmi_record_dto.dart';
import 'package:lottie/lottie.dart';

class WeightTrackPage extends StatefulWidget {
  const WeightTrackPage({Key? key}) : super(key: key);

  @override
  State<WeightTrackPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightTrackPage> {
  final BmiService _bmiService = BmiService();

  WeightModel _weightData = WeightModel(weight: 70);
  List<BmiRecordDto> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBmiRecords();
  }

  Future<void> loadBmiRecords() async {
    final list = await _bmiService.getAllBmiRecords();

    setState(() {
      _records = list;
      if (_records.isNotEmpty) {
        _weightData = WeightModel(weight: _records.first.weight);
      }
      _isLoading = false;
    });
  }

  void changeWeight(bool increase) {
    setState(() {
      final w = _weightData.weight;
      _weightData = WeightModel(weight: increase ? w + 1 : w - 1);
    });
  }

  Future<void> updateBackend() async {
    final height = _records.isNotEmpty ? _records.first.height : 170.0;

    await _bmiService.calculateAndSaveBmi(
      height: height,
      weight: _weightData.weight,
    );

    await loadBmiRecords();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("BMI measured again")));
  }

  String daysAgo(DateTime date) {
    final diff = DateTime.now().difference(date).inDays;
    if (diff == 0) return "Today";
    if (diff == 1) return "1 day ago";
    return "$diff days ago";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F2EC),
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F2EC),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff1C1C1C)),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegistrationPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePicturePage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    Lottie.asset(
                      "assets/animations/Weight scale.json",
                      height: 160,
                    ),

                    const SizedBox(height: 32),

                    const Text(
                      "How much weight the user should lose to have a healthy BMI",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1C1C1C),
                      ),
                    ),

                    const SizedBox(height: 36),

                    WeightControl(
                      weight: _weightData.weight,
                      onIncrease: () => changeWeight(true),
                      onDecrease: () => changeWeight(false),
                    ),

                    const SizedBox(height: 36),

                    const SizedBox(height: 36),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1C1C1C),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                        ),
                        onPressed: updateBackend,
                        child: const Text(
                          "UPDATE",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // 🔽 BMI RECORD LIST
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _records.length,
                      itemBuilder: (context, index) {
                        final r = _records[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BMI ${r.bmi.toStringAsFixed(1)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text("Height: ${r.height} cm"),
                              Text("Weight: ${r.weight} kg"),
                              const SizedBox(height: 6),
                              Text(
                                daysAgo(r.createdAt),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
      ),
    );
  }
}
