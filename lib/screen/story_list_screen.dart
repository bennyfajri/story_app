import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/widgets/error_empty_page.dart';

import '../data/models/story/story.dart';
import '../my_app.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final storyProvider = context.read<StoryProvider>();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        if (storyProvider.pageItems != null) {
          storyProvider.getStories();
        }
      }
    });
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

    Future<void> getStories([bool isRefreshing = false]) async {
      await storyProvider.getStories(isRefreshing);
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
        builder: (context, provider, child) {
          return provider.storyState.map(
            initial: (value) {
              return Container();
            },
            loading: (value) {
              return const Center(child: CircularProgressIndicator());
            },
            loaded: (value) {
              final listStory = value.data as List<Story>?;
              return listStory!.isEmpty
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
                          onRefresh: () async{
                            getStories(true);
                          },
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: listStory.length + (storyProvider.pageItems != null ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == listStory.length && storyProvider.pageItems != null) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              final story = listStory[index];
                              return StoryItem(
                                id: story.id,
                                photoUrl: story.photoUrl,
                                description: story.description,
                                createdAt: story.createdAt,
                                creatorName: story.name,
                                onItemClick: (id) async {
                                  await context
                                      .read<StoryProvider>()
                                      .getDetailStory(id);
                                  widget.onStoryClicked(story.id);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
            },
            error: (value) {
              return ErrorEmptyPage(
                title: appLocale.oops,
                message: value.message,
                messageButton: appLocale.try_again,
                onPressed: getStories,
              );
            },
          );
        },
      ),
    );
  }
}
