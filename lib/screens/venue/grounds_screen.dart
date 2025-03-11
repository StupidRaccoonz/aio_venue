import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/controllers/veneue_manager_controller.dart';
import 'package:aio_sport/models/venue_details_model.dart';
import 'package:aio_sport/screens/venue/add_new_ground.dart';
import 'package:aio_sport/screens/venue/manage_ground_screen.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/filled_selection_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class GroundsScreen extends StatefulWidget {
  const GroundsScreen({super.key});

  @override
  State<GroundsScreen> createState() => _GroundsScreenState();
}

class _GroundsScreenState extends State<GroundsScreen> {
  final profileController = Get.find<ProfileController>();
  final manager = Get.find<VenueManagerController>();

  @override
  void initState() {
    profileController.getVenuesListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 10.vh),
          child: AppbarWidget(
            title: "Manage Grounds",
            leading: IconButton(icon: const Icon(Icons.arrow_back_rounded, color: Colors.white), onPressed: () => Get.back()),
            actionIcon: IconButton(
                onPressed: () => Get.to(
                      () => AddNewGroundScreen(
                          selectedSport: profileController.sportsList.firstWhere((element) => element!.id == manager.selectedGroundSportId.value)!),
                    ),
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                icon: const Icon(Icons.add)),
          )),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SizedBox(
                height: 60,
                width: constraints.maxHeight * 0.85,
                child: Obx(() {
                  return ListView.builder(
                    itemCount: profileController.selectedSportsList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: constraints.maxHeight * 0.05,
                          width: constraints.maxHeight * 0.22,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16.0),
                            onTap: () {
                              manager.selectedGroundSportId.value = profileController.selectedSportsList[index].id;
                              manager.selectedGroundSportId.refresh();
                            },
                            child: FilledSelectionChip(
                              isSelected: manager.selectedGroundSportId.value == index,
                              index: index,
                              sportModel: profileController.selectedSportsList[index],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
            Flexible(
              child: Obx(() {
                RxList<Ground> grounds = <Ground>[].obs;
                for (Ground ground in manager.profileController.currentVenue.value!.data!.venue.grounds) {
                  if (ground.sportsId == manager.selectedGroundSportId.value) {
                    grounds.add(ground);
                  }
                }
                grounds.refresh();
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: grounds.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text(grounds[index].name ?? "N/A"),
                                subtitle: Text(grounds[index].groundSize ?? "N/A"),
                                onTap: () => Get.to(() => ManageGroundScreen(ground: grounds[index])),
                                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        );
      }),
    );
  }
}
