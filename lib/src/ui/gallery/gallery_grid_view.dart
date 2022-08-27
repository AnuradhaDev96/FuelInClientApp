import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/assets.dart';
import '../../models/gallery/gallery.dart';

class GalleryGridView extends StatelessWidget {
  GalleryGridView({Key? key}) : super(key: key);
  final List<Gallery> galleryList = [
    Gallery(
      category: "Accommodation",
      imgPath: Assets.accommodation1,
    ),
    Gallery(
      category: "Accommodation",
      imgPath: Assets.accommodation2,
    ),
    Gallery(
      category: "Accommodation",
      imgPath: Assets.accommodation3,
    )
  ];

  @override
  Widget build(BuildContext context) {
    List<Gallery> accommodationPhotoList = galleryList.where((element) => element.category == "Accommodation").toList();

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Accommodation",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Container(color: AppColors.indigoMaroon,height: 2.0,),
            ],
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: accommodationPhotoList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                final photoElement = accommodationPhotoList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: Colors.white,
                    child: Image.asset(photoElement.imgPath, fit: BoxFit.fitHeight,),
                  ),
                );
              }
            )
          ),
          Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: accommodationPhotoList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    final photoElement = accommodationPhotoList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 20.0,
                        width: 80.0,
                        color: Colors.blue,
                        child: Image.asset(photoElement.imgPath),
                      ),
                    );
                  }
              )
          ),
        ],
      ),
    );
  }
}
