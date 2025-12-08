import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/weight_track_page/business/weight_model.dart';
import 'package:gymproject/_lib/features/weight_track_page/data/weight_service.dart';
import 'package:gymproject/_lib/features/weight_track_page/presentation/widgets/track_panel.dart';
import 'package:gymproject/_lib/features/weight_track_page/presentation/widgets/weight_control.dart';
//import 'package:lottie/lottie.dart';



class WeightTrackPage extends StatefulWidget {
  const WeightTrackPage({Key? key}) : super(key: key);

  @override
  State<WeightTrackPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightTrackPage> {
  final WeightService _service = WeightService();
  WeightModel? _weightData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadWeight();
  }

  Future<void> loadWeight() async {
    final data = await _service.loadUserWeight();
    setState(() {
      _weightData = data;
      _isLoading = false;
    });
  }

  void changeWeight(bool increase) {
    setState(() {
      double w = _weightData!.weight;
      _weightData = WeightModel(weight: increase ? w + 1 : w - 1);
    });
  }

  Future<void> updateBackend() async {
    await _service.updateWeight(_weightData!.weight);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Updated.")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F2EC), // beige
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // Animation
                    /*Lottie.asset(
                      "assets/animations/bmi.json",
                      height: 160,
                    ),*/

                    const SizedBox(height: 32),

                    Text(
                      "How much weight the user should lose to have a healthy BMI",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1C1C1C),
                      ),
                    ),

                    const SizedBox(height: 36),

                    WeightControl(
                      weight: _weightData!.weight,
                      onIncrease: () => changeWeight(true),
                      onDecrease: () => changeWeight(false),
                    ),

                    const SizedBox(height: 36),

                    const TrackPanel(),

                    const SizedBox(height: 36),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1C1C1C), // black
                          foregroundColor: Colors.white, // text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0, // flat design
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
                  ],
                ),
              ),
      ),
    );
  }
}
