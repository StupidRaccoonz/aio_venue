import 'dart:developer';
import 'package:aio_sport/main.dart';
import 'package:aio_sport/models/success_response_model.dart';
import 'package:aio_sport/models/venue_media_model.dart';
import 'package:aio_sport/objecbox_models/venue_media_model_obj.dart';
import 'package:video_compress/video_compress.dart';
import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/screens/authentication/wrapper.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';
import '../venue/facilities_screen.dart';
import '../venue/venue_details.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

class UploadMediaScreen extends StatefulWidget {
  final String? venueId;
  final String? playerId;
  const UploadMediaScreen({super.key, this.venueId, this.playerId});

  @override
  State<UploadMediaScreen> createState() => _UploadMediaScreenState();
}

class _UploadMediaScreenState extends State<UploadMediaScreen> {
  final profileController = Get.find<ProfileController>();
  @override
  void initState() {
    super.initState();
    if (getStorage.read<bool>(Constants.isNewAccount) ?? false || Get.currentRoute == "/" && widget.venueId == null) {
      getStorage.write(Constants.lastPage, "UploadMediaScreen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: Constants.backgroundDecoration,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(builder: (context, constraints) {
            return Obx(() {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.0.rh),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: IconButton(onPressed: () => Get.to(() => VenueDetails(addAnotherVenue: false)), icon: Icon(Icons.arrow_back_rounded, color: CustomTheme.appColor)),
                          ),
                          SizedBox(height: 5.0.rh),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text("Upload media", style: Get.textTheme.titleLarge),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text("Upload your images in action to give glimpse of your coaching", style: Get.textTheme.displaySmall),
                          ),
                          SizedBox(height: 25.rh),
                          // upload your video
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Material(
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.br),
                                        child: Image.asset("assets/icons/add_video.png",
                                            fit: BoxFit.cover, width: constraints.maxWidth * 0.2, height: constraints.maxWidth * 0.2),
                                      ),
                                      SizedBox(
                                        height: constraints.maxWidth * 0.2,
                                        width: constraints.maxWidth * 0.2,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(50.br),
                                            onTap: () async {
                                              var video = await Constants.pickVideo();

                                              if (video != null) {
                                                int size = await video.length();

                                                log("videoSize: $size");
                                                MediaInfo? mediaInfo = await VideoCompress.compressVideo(
                                                  video.path,
                                                  quality: VideoQuality.LowQuality,
                                                  deleteOrigin: false, // It's false by default
                                                );

                                                if (mediaInfo == null || (mediaInfo.duration ?? 1000) > 10000) {
                                                  Constants.showSnackbar("Error", "video length should not be longer than 10 seconds");
                                                  return;
                                                }
                                                log("after compression videoSize: ${mediaInfo.filesize}");
                                                final thumbnail = await VideoCompress.getFileThumbnail(video.path,
                                                    quality: 50, // default(100)
                                                    position: 100 // default(-1)
                                                    );
                                                profileController.videosThumbnailList.add(thumbnail);
                                                profileController.videosList.add(video);
                                                /*                                               if (size > 20000) {
                                                  return;
                                                } */

                                                /* final thumbnail = await VideoThumbnail.thumbnailFile(
                                                  video: video.path,
                                                  imageFormat: ImageFormat.JPEG,
                                                  maxHeight: 320,
                                                  quality: 50,
                                                ); */
                                              }
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Upload your video", style: Get.textTheme.bodySmall),
                                      Text("Maximum video upload size: 10 sec", style: Get.textTheme.displaySmall),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Obx(() {
                            return SizedBox(
                              height: Constants.getheight(profileController.videosList.length, mainSize: constraints.maxWidth * 0.32),
                              child: GridView.builder(
                                itemCount: profileController.videosList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Material(
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.br),
                                          child: Image.file(
                                            profileController.videosThumbnailList[index],
                                            fit: BoxFit.cover,
                                            width: constraints.maxWidth * 0.3,
                                          ),
                                        ),
                                        SizedBox(
                                          height: constraints.maxWidth * 0.3,
                                          width: constraints.maxWidth * 0.3,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(10.br),
                                              onTap: () {},
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: IconButton(
                                            style: IconButton.styleFrom(backgroundColor: Colors.white),
                                            onPressed: () {
                                              profileController.videosList.removeAt(index);
                                              profileController.videosThumbnailList.removeAt(index);
                                            },
                                            icon: const Icon(Icons.delete_forever,size: 22,color: Colors.orange,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  mainAxisExtent: constraints.maxWidth * 0.3,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 4.0,
                                ),
                              ),
                            );
                          }),
                          // upload your image
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Material(
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.br),
                                        child: Image.asset(
                                          "assets/icons/add_image.png",
                                          fit: BoxFit.cover,
                                          width: constraints.maxWidth * 0.2,
                                          height: constraints.maxWidth * 0.2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxWidth * 0.2,
                                        width: constraints.maxWidth * 0.2,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(50.br),
                                            onTap: () async {
                                              var list = await Constants.pickImage(multiple: true);
                                              if (list.isNotEmpty) {
                                                profileController.imagesList.addAll(list);
                                              }
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Upload your image", style: Get.textTheme.bodySmall),
                                      Text("Maximum image upload size: 5mb", style: Get.textTheme.displaySmall),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Obx(() {
                            return SizedBox(
                              height: Constants.getheight(profileController.imagesList.length, mainSize: constraints.maxWidth * 0.32),
                              child: GridView.builder(
                                itemCount: profileController.imagesList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Material(
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.br),
                                          child: Image.file(
                                            profileController.imagesList[index],
                                            fit: BoxFit.cover,
                                            width: constraints.maxWidth * 0.3,
                                            height: constraints.maxWidth * 0.3,
                                          ),
                                        ),
                                        SizedBox(
                                          height: constraints.maxWidth * 0.3,
                                          width: constraints.maxWidth * 0.3,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(10.br),
                                              onTap: () {},
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: IconButton(
                                            style: IconButton.styleFrom(backgroundColor: Colors.white),
                                            onPressed: () => profileController.imagesList.removeAt(index),
                                            icon: const Icon(Icons.delete_forever,size: 22,color: Colors.orange),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  mainAxisExtent: constraints.maxWidth * 0.31,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 4.0,
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: constraints.maxHeight * 0.15)
                        ],
                      ),
                    ),
                  ),
                  profileController.loading.value
                      ? Container(
                          color: Colors.white54,
                          child: Center(child: CircularProgressIndicator(color: CustomTheme.appColor)),
                        )
                      : const SizedBox(),
                ],
              );
            });
          }),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyButton(
              text: "Next",
              onPressed: () async {
                if (profileController.videosList.isNotEmpty && profileController.imagesList.isNotEmpty) {
                  late SuccessResponseModel? response;
                  if (widget.venueId == null) {
                    response = await profileController.uploadMedia(
                      profileController.videosList,
                      profileController.imagesList,
                      profileController.currentVenue.value != null
                          ? "${profileController.currentVenue.value!.data?.venue.id}"
                          : "${profileController.loginDataModel.value!.data?.venueId}",
                    );
                  } else {
                    response = await profileController.uploadMedia(
                      profileController.videosList,
                      profileController.imagesList,
                      "${widget.venueId}",
                    );
                      // print("${widget.venueId}");
                      // print("===> vivek test");
                  }
                  profileController.loading.value = false;
                  if (response != null && response.httpCode == 200) {
                    Constants.showSnackbar("Success", response.message);
                    final data = await profileController.venueService
                        .getVenueMedia(profileController.bearer, "${profileController.venueId ?? profileController.loginDataModel.value!.data!.venueId}");

                    if (widget.venueId == null) {
                      profileController.venueMedia.value = data ?? VenueMediaModel(httpCode: 401, message: "Media not found.", data: null);
                      objectbox.venueMediaBox.put(venueMediaModelObjFromJson(venueMediaModelToJson(profileController.venueMedia.value)));
                    }
                    if ((profileController.currentVenue.value != null && profileController.currentVenue.value!.data!.venue.facilitiesVenues.isEmpty) ||
                        widget.venueId != null) {
                      Get.to(() => FacilitiesScreen(venueId: widget.venueId));
                    } else {
                      profileController.venueMedia.refresh();
                    }
                  }
                  Get.to(() => FacilitiesScreen(venueId: widget.venueId));
                } else {
                  Constants.showSnackbar("Error", "at least 1 image and 1 video is required");
                }
              },
              height: 25.rh,
            ),
          ),
        ),
      ),
    );
  }
}
