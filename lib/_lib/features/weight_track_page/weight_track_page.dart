import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/profile_picture_page/profile_picture_page.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/registration_page.dart';
import 'package:gymproject/_lib/features/weight_height_page/data/services/bmi_service.dart';
import 'package:gymproject/_lib/features/weight_track_page/business/weight_model.dart';
import 'package:gymproject/_lib/features/weight_track_page/presentation/widgets/track_panel.dart';
import 'package:gymproject/_lib/features/weight_track_page/presentation/widgets/weight_control.dart';
import 'package:gymproject/_lib/features/weight_height_page/data/bmi_record_dto.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeightTrackPage extends StatefulWidget {
  const WeightTrackPage({super.key});

  @override
  State<WeightTrackPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightTrackPage> {
  final BmiService _bmiService = BmiService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  WeightModel _weightData = WeightModel(weight: 70);
  List<BmiRecordDto> _records = [];
  bool _isLoading = true;
  double _userHeight = 170.0; // Kullanıcının gerçek boyu

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  /// Kullanıcı verilerini ve BMI kayıtlarını yükle
  Future<void> _initializeData() async {
    await _loadUserProfile();
    await loadBmiRecords();
  }

  /// Firestore'dan kullanıcının boy ve kilo bilgilerini çek
  Future<void> _loadUserProfile() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          // Boy bilgisini al (String'den double'a çevir)
          final heightStr = data['height'] as String?;
          if (heightStr != null) {
            _userHeight = double.tryParse(heightStr) ?? 170.0;
          }

          // Kilo bilgisini al (eğer BMI kaydı yoksa kullanılacak)
          final weightStr = data['weight'] as String?;
          if (weightStr != null) {
            final userWeight = double.tryParse(weightStr) ?? 70.0;

            // Eğer hiç BMI kaydı yoksa, kullanıcının kayıt sırasındaki kilosunu kullan
            if (_records.isEmpty) {
              _weightData = WeightModel(weight: userWeight);
            }
          }
        }
      }
    } catch (e) {
      debugPrint("Error loading user profile: $e");
    }
  }

  Future<void> loadBmiRecords() async {
    final list = await _bmiService.getAllBmiRecords();

    setState(() {
      _records = list;
      if (_records.isNotEmpty) {
        _weightData = WeightModel(weight: _records.first.weight);
        // İlk kayıttaki boy bilgisini de güncelle
        _userHeight = _records.first.height;
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
    await _bmiService.calculateAndSaveBmi(
      height: _userHeight,
      weight: _weightData.weight,
    );

    await loadBmiRecords();

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("BMI measured again")));
    }
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
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
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

                    // BMI RECORD LIST
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
                            color: Theme.of(context).cardColor,
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
