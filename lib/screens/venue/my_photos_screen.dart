import 'dart:developer';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/venue_media_model.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/image_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class MyPhotosScreen extends StatefulWidget {
  const MyPhotosScreen({super.key});

  @override
  State<MyPhotosScreen> createState() => _MyPhotosScreenState();
}

class _MyPhotosScreenState extends State<MyPhotosScreen> {
  late ProfileController profileController;
  VenueMediaModel? venueMedia;
  final Set<int> selectedIndices = <int>{};
  final List<String> selectedImageUrls = <String>[];

  @override
  void initState() {
    super.initState();
    profileController = Get.find<ProfileController>();
    init();
  }

  Future<void> init() async {
    venueMedia = await profileController.getVenueMedia();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 10.vh),
        child: AppbarWidget(
          title: "My Photos",
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          actionIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () async {
                profileController.loading.value = true;
                var response = await profileController.commonService.deleteMedia(selectedImageUrls, profileController.bearer);
                if (response != null && response.httpCode == 200) {
                  Constants.showSnackbar("Success", response.message);
                  venueMedia = await profileController.getVenueMedia();
                  selectedImageUrls.clear();
                  selectedIndices.clear();
                  setState(() {});
                }
                profileController.loading.value = false;
              },
              icon: Image.asset(
                "assets/icons/delete.png",
                height: 35.0,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(8.0),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            (venueMedia == null || venueMedia!.data == null || venueMedia!.data!.photos.isEmpty) && !profileController.loading.value
                ? Center(
                    child: Text("No media added"),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: venueMedia?.data?.photos.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (selectedIndices.contains(index)) {
                            selectedIndices.remove(index);
                            selectedImageUrls.remove(venueMedia?.data?.photos[index]);
                          } else {
                            selectedIndices.add(index);
                            selectedImageUrls.add(venueMedia?.data?.photos[index] ?? "");
                          }
                          log("Selection: $selectedIndices - $selectedImageUrls");
                          setState(() {});
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ImageWidget(
                                  imageurl: "${ServerUrls.mediaUrl}venue/${venueMedia?.data?.photos[index]}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            if (selectedIndices.contains(index))
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.8),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.check, color: Colors.white, size: 20),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: MyButton(
                width: double.infinity,
                text: "Add Photo",
                onPressed: () async {
                  profileController.imagesList.value = [];
                  var list = await Constants.pickImage(multiple: true);
                  if (list.isNotEmpty) {
                    profileController.loading.value = true;

                    profileController.imagesList.addAll(list);
                    await profileController.uploadMedia(
                      [],
                      profileController.imagesList.value,
                      profileController.currentVenue.value != null
                          ? "${profileController.currentVenue.value!.data?.venue.id}"
                          : "${profileController.loginDataModel.value!.data?.venueId}",
                    );

                    venueMedia = await profileController.getVenueMedia();
                    profileController.loading.value = false;
                    setState(() {});
                  }
                },
              ),
            ),
            if (profileController.loading.value) Container(child: Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }
}
