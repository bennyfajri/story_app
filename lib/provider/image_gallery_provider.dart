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
  List<AssetEntity> _images = [];
  List<AssetPathEntity> _pathList = [];

  int pageItems = 0;
  int sizeItems = 50;

  ImageGalleryProvider({required this.takeImgProvider}) {
    _init();
  }

  void _init() async {
    await PhotoManager.requestPermissionExtend();
    _pathList = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: false,
    );

    paths = DataState.loaded(_pathList);
    notifyListeners();

    List<AssetEntity> allImages = [];
    for (var path in _pathList) {
      final imagesPerPath = await path.getAssetListPaged(page: pageItems, size: sizeItems);
      allImages.addAll(imagesPerPath);
    }

    if(allImages.isNotEmpty) {
      final firstAssetFile = await allImages.first.file;
      pageItems = pageItems + 1;
      _images.addAll(allImages);
      images = DataState.loaded(_images);
      takeImgProvider.setImageFile(await assetEntityToXFile(firstAssetFile));
      takeImgProvider.setImagePath(firstAssetFile?.path);
    } else {
      images = const DataState.empty();
    }
    notifyListeners();
  }

  void loadMore() async {
    if(filterPath != null) {
      final imagesPerPath = await filterPath!.getAssetListPaged(page: pageItems, size: sizeItems);
      _images.addAll(imagesPerPath);
    } else {
      for (var path in _pathList) {
        final imagesPerPath = await path.getAssetListPaged(page: pageItems, size: sizeItems);
        _images.addAll(imagesPerPath);
      }
    }

    if(_images.isNotEmpty) {
      final firstAssetFile = await _images.first.file;
      takeImgProvider.setImageFile(await assetEntityToXFile(firstAssetFile));
      takeImgProvider.setImagePath(firstAssetFile?.path);
      pageItems = pageItems + 1;
      images = DataState.loaded(_images);
    } else {
      images = const DataState.empty();
    }
    notifyListeners();
  }

  void setFilterPath(AssetPathEntity? value) async {
    filterPath = value;
    pageItems = 0;
    _images.clear();
    notifyListeners();

    if (filterPath != null) {
      images = const DataState.loading();
      notifyListeners();

      final imagesPerPath =
      await filterPath!.getAssetListPaged(page: pageItems, size: sizeItems);
      if(imagesPerPath.isNotEmpty) {
        final firstAssetFile = await imagesPerPath.first.file;

        takeImgProvider.setImageFile(await assetEntityToXFile(firstAssetFile));
        takeImgProvider.setImagePath(firstAssetFile?.path);
        pageItems = pageItems + 1;
        _images.addAll(imagesPerPath);
        images = DataState.loaded(_images);
      } else {
        images = const DataState.empty();
      }
      notifyListeners();
    } else {
      images = const DataState.empty();
      notifyListeners();
    }
  }
}
