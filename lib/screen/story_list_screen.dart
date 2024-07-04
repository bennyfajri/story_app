import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/main.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/widgets/error_empty_page.dart';

import '../widgets/story_item.dart';

class StoryListScreen extends StatefulWidget {
  const StoryListScreen({
    super.key,
    required this.onAddStory,
    required this.onStoryClicked,
  });

  final Function() onAddStory;
  final Function(String) onStoryClicked;

  @override
  State<StoryListScreen> createState() => _StoryListScreenState();
}

class _StoryListScreenState extends State<StoryListScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storyProvider = context.watch<StoryProvider>();
    final screenWidth = MediaQuery.of(context).size.width;

    Future<void> getStories() async {
      await storyProvider.getStories();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocale.app_name,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.onAddStory();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Consumer<StoryProvider>(
        builder: (context, value, child) {
          return storyProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : storyProvider.isError
              ? ErrorEmptyPage(
            title: appLocale.oops,
            message: storyProvider.errorMessages,
            messageButton: appLocale.try_again,
            onPressed: getStories,
          )
              : storyProvider.listStory.isEmpty
              ? ErrorEmptyPage(
            title: appLocale.oops,
            message: appLocale.no_data,
            messageButton: appLocale.try_again,
            onPressed: getStories,
          )
              : Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: screenWidth > 600 ? 600 : screenWidth),
              child: RefreshIndicator(
                onRefresh: getStories,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: storyProvider.listStory.length,
                  itemBuilder: (context, index) {
                    final story = storyProvider.listStory[index];
                    return StoryItem(
                      id: story.id,
                      photoUrl: story.photoUrl,
                      description: story.description,
                      createdAt: story.createdAt,
                      creatorName: story.name,
                      onItemClick: (id) {
                        context.read<StoryProvider>().getDetailStory(id);
                        if(storyProvider.story != null) {
                          widget.onStoryClicked(story.id);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
