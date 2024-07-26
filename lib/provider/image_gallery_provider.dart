import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:story_app/data/models/loading_state/loading_state.dart';
import 'package:story_app/util/constant.dart';

import 'take_image_provider.dart';

class ImageGalleryProvider with ChangeNotifier {
  DataState<List<AssetEntity>> images = const DataState.loading();
  DataState<List<AssetPathEntity>> paths = const DataState.loading();
  AssetPathEntity? filterPath;
  TakeImageProvider takeImgProvider;

  ImageGalleryProvider({required this.takeImgProvider}) {
    _init();
  }

  void _init() async {
    await PhotoManager.requestPermissionExtend();
    final pathList = await PhotoManager.getAssetPathList();

    paths = DataState.loaded(pathList);
    notifyListeners();

    List<AssetEntity> allImages = [];
    for (var path in pathList) {
      final imagesPerPath = await path.getAssetListPaged(page: 0, size: 80);
      allImages.addAll(imagesPerPath);
    }

    final firstAssetFile = await allImages.first.file;
    images = DataState.loaded(allImages);
    takeImgProvider.setImageFile(await assetEntityToXFile(firstAssetFile));
    takeImgProvider.setImagePath(firstAssetFile?.path);
    notifyListeners();
  }

  void setFilterPath(AssetPathEntity? value) async {
    filterPath = value;
    notifyListeners();

    if (filterPath != null) {
      images = const DataState.loading();
      notifyListeners();

      final imagesPerPath =
          await filterPath!.getAssetListPaged(page: 0, size: 80);
      final firstAssetFile = await imagesPerPath.first.file;

      takeImgProvider.setImageFile(await assetEntityToXFile(firstAssetFile));
      takeImgProvider.setImagePath(firstAssetFile?.path);
      images = DataState.loaded(imagesPerPath);
    } else {
      images = const DataState.loaded([]);
    }
    notifyListeners();
  }
}
