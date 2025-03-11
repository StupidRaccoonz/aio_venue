import 'package:aio_sport/controllers/veneue_manager_controller.dart';
import 'package:aio_sport/screens/venue/add_ground_to_pause.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';
import 'edit_pause_setting_screen.dart';

class PauseGroundScreen extends StatefulWidget {
  const PauseGroundScreen({super.key});

  @override
  State<PauseGroundScreen> createState() => _PauseGroundScreenState();
}

class _PauseGroundScreenState extends State<PauseGroundScreen> {
  final manager = Get.find<VenueManagerController>();

  @override
  void initState() {
    manager.venueService.getPausedGrounds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 10.vh),
        child: AppbarWidget(
          title: "Pause Booking",
          leading: IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff303345)),
                shape: MaterialStateProperty.all(CircleBorder()),
              ),
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          actionIcon: IconButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff303345)),
              shape: MaterialStateProperty.all(CircleBorder()),
            ),
            onPressed: () => Get.to(() => const AddGroundToPauseScreen()),
            icon: const Icon(Icons.add_rounded),
            color: Colors.white,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Paused grounds", style: Get.textTheme.displayLarge),
              const SizedBox(height: 20.0),
              Expanded(
                child: Material(
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      return manager.pausedGroundes.isEmpty
                          ? Center(child: Text("No Pasued Grounds"))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: manager.pausedGroundes.length,
                              itemBuilder: (context, index) {
                                final ground = manager.pausedGroundes[index];
                                final sport =
                                    manager.profileController.sportsList.firstWhere((e) => e?.id == ground.sportsId);
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text(ground.name ?? "N/A"),
                                      subtitle: Text(sport?.name ?? "N/A"),
                                      onTap: () {
                                        Get.to(EditPauseSettingScreen(), arguments: manager.pausedGroundes[index].id);
                                      },
                                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                                    ),
                                    const Divider(),
                                  ],
                                );
                              });
                    }),
                  ),
                ),
              ),
              // SingleChildScrollView(
              //   child: Container(
              //     decoration: BoxDecoration(
              //         border: Border.all(color: Color(0xffE9E8EB)), borderRadius: BorderRadius.circular(20)),
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: ListView.builder(
              //         shrinkWrap: true,
              //         physics: NeverScrollableScrollPhysics(),
              //         itemCount: 4,
              //         itemBuilder: (context, index) {
              //           return Column(
              //             children: [
              //               ListTile(
              //                 title: Text("East side g1"),
              //                 subtitle: Text("Football ground"),
              //                 onTap: () {
              //                   Get.to(EditPauseSettingScreen());
              //                 },
              //                 trailing: const Icon(Icons.arrow_forward_ios_rounded),
              //               ),
              //               const Divider(color: Color(0xffE9E8EB)),
              //             ],
              //           );
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 40.0),
            ],
          ),
        );
      }),
    );
  }
}
