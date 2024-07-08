import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:story_app/data/api/story_service.dart';
import 'package:story_app/data/models/api_state/api_state.dart';
import 'package:story_app/data/models/story/story.dart';

import '../data/db/auth_prefs.dart';

class StoryProvider extends ChangeNotifier {
  final StoryService storyService;
  final AuthPrefs authPrefs;

  StoryProvider({
    required this.storyService,
    required this.authPrefs,
  }) {
    getStories();
  }

  ApiState storyState = const ApiState.initial();
  ApiState detailStoryState = const ApiState.initial();
  ApiState uploadStoryState = const ApiState.initial();
  final List<Story> _listStory = [];

  int? pageItems = 1;
  int sizeItems = 10;

  Future<dynamic> getStories([bool isRefreshing = false]) async {
    if (isRefreshing) {
      _listStory.clear();
      pageItems = 1;
      notifyListeners();
    }
    try {
      if (pageItems == 1) {
        storyState = const ApiState.loading();
        notifyListeners();
      }

      final loginInfo = await authPrefs.getLoginInfo();
      final serverResponse = await storyService.getStories(
        token: loginInfo?.token ?? "",
        page: pageItems!,
        size: sizeItems,
      );
      if (serverResponse.error) {
        storyState = ApiState.error(serverResponse.message);
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 1500));
      } else {
        if (serverResponse.listStory!.isNotEmpty) {
          _listStory.addAll(serverResponse.listStory!);
          storyState = ApiState.loaded(_listStory);
        }
      }
      if (serverResponse.listStory!.length < sizeItems) {
        pageItems = null;
      } else {
        pageItems = pageItems! + 1;
      }

      notifyListeners();
    } on DioException catch (e) {
      storyState = ApiState.error(e.message.toString());
      notifyListeners();
    }
  }

  Future<dynamic> getDetailStory(String storyId) async {
    try {
      detailStoryState = const ApiState.loading();
      notifyListeners();

      final loginInfo = await authPrefs.getLoginInfo();
      final serverResponse = await storyService.getDetailStories(
        id: storyId,
        token: loginInfo?.token ?? "",
      );
      if (serverResponse.error) {
        detailStoryState = ApiState.error(serverResponse.message);
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 1500));
      } else {
        if (serverResponse.story != null) {
          detailStoryState = ApiState.loaded(serverResponse.story!);
        }
      }
      notifyListeners();
    } on DioException catch (e) {
      detailStoryState = ApiState.error(e.message.toString());
      notifyListeners();
    }
  }

  Future<bool> addNewStory(
    List<int> bytes,
    String fileName,
    String description,
    double? lat,
    double? lng,
  ) async {
    try {
      uploadStoryState = const ApiState.loading();
      notifyListeners();

      final loginInfo = await authPrefs.getLoginInfo();
      final serverResponse = await storyService.addNewStory(
        bytes: bytes,
        fileName: fileName,
        token: loginInfo?.token ?? "",
        desc: description,
        lat: lat,
        lng: lng,
      );
      if (serverResponse.error) {
        uploadStoryState = ApiState.error(serverResponse.message);
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 1500));
        return false;
      } else {
        uploadStoryState = const ApiState.loaded(true);
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      uploadStoryState = ApiState.error(e.message.toString());
      notifyListeners();
      return false;
    }
  }
}
