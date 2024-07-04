import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:story_app/data/api/story_service.dart';

import '../data/db/auth_prefs.dart';
import '../data/models/story/story.dart';

class StoryProvider extends ChangeNotifier {
  final StoryService storyService;
  final AuthPrefs authPrefs;

  StoryProvider({
    required this.storyService,
    required this.authPrefs,
  }) {
    getStories();
  }

  List<Story> _listStory = [];
  Story? _story;
  bool _isLoading = false;
  bool _isLoadingDetail = false;
  bool _isUploading = false;
  bool _isError = false;
  String _errorMessages = "";

  bool get isLoading => _isLoading;

  bool get isLoadingDetail => _isLoadingDetail;

  bool get isUploading => _isUploading;

  bool get isError => _isError;

  String get errorMessages => _errorMessages;

  List<Story> get listStory => _listStory;

  Story? get story => _story;

  Future<dynamic> getStories() async {
    try {
      _isLoading = true;
      notifyListeners();

      final loginInfo = await authPrefs.getLoginInfo();
      final serverResponse =
          await storyService.getStories(token: loginInfo?.token ?? "");
      if (serverResponse.error) {
        _isError = true;
        _errorMessages = serverResponse.message;
      } else {
        if (serverResponse.listStory!.isNotEmpty) {
          _listStory = serverResponse.listStory!;
        }
      }

      _isLoading = false;
      notifyListeners();
    } on DioException catch (e) {
      _isError = true;
      _errorMessages = e.message.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> getDetailStory(String storyId) async {
    try {
      _isLoadingDetail = true;
      notifyListeners();

      final loginInfo = await authPrefs.getLoginInfo();
      final serverResponse = await storyService.getDetailStories(
        id: storyId,
        token: loginInfo?.token ?? "",
      );
      if (serverResponse.error) {
        _isError = true;
        _errorMessages = serverResponse.message;
      } else {
        if (serverResponse.story != null) {
          _story = serverResponse.story!;
        }
      }

      _isLoadingDetail = false;
      notifyListeners();
    } on DioException catch (e) {
      _isError = true;
      _errorMessages = e.message.toString();
      _isLoadingDetail = false;
      notifyListeners();
    }
  }

  Future<dynamic> addNewStory(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    try {
      _isUploading = true;
      notifyListeners();

      final loginInfo = await authPrefs.getLoginInfo();
      final serverResponse = await storyService.addNewStory(
        bytes: bytes,
        fileName: fileName,
        token: loginInfo?.token ?? "",
        desc: description,
      );
      if (serverResponse.error) {
        _isError = true;
        _errorMessages = serverResponse.message;
      } else {
        _isError = false;
        _errorMessages = "";
      }

      _isUploading = false;
      notifyListeners();
    } on DioException catch (e) {
      _isError = true;
      _errorMessages = e.message.toString();
      _isUploading = false;
      notifyListeners();
    }
  }
}
