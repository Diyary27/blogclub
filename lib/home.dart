import 'package:blogclub/article.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'carousel/carousel_slider.dart';
import 'data.dart';
import 'gen/assets.gen.dart';
import 'main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final stories = AppDatabase.stories;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 28, 32, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, Diyar!',
                      style: themeData.textTheme.titleMedium,
                    ),
                    Assets.img.icons.notification.image(width: 36, height: 36),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: Text(
                  "Explore today's",
                  style: themeData.textTheme.headlineMedium,
                ),
              ),
              _StoryList(stories: stories),
              SizedBox(height: 17),
              Container(
                height: 360,
                child: _CategoryList(),
              ),
              _PostList(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  final posts = AppDatabase.posts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 26, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Latest News',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'More',
                  style: TextStyle(
                    color: Color(0xff376AED),
                    fontFamily: MyApp.defaultFontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          itemCount: posts.length,
          scrollDirection: Axis.vertical,
          itemExtent: 141,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            final post = posts[index];
            return Post(post: post);
          },
        )
      ],
    );
  }
}

class Post extends StatelessWidget {
  const Post({
    super.key,
    required this.post,
  });

  final PostData post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ArticleScreen())),
      child: Container(
        margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff5282FF).withOpacity(0.06),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/img/posts/small/${post.imageFileName}',
                width: 120,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.caption,
                      style: TextStyle(
                        fontFamily: MyApp.defaultFontFamily,
                        color: Color(0xff376AED),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(post.title,
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 13),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.hand_thumbsup,
                          size: 16,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          post.likes,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 20),
                        Icon(
                          CupertinoIcons.clock,
                          size: 16,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          post.time,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              post.isBookmarked
                                  ? CupertinoIcons.bookmark_fill
                                  : CupertinoIcons.bookmark,
                              size: 16,
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categories = AppDatabase.categories;
    return CarouselSlider.builder(
      itemCount: categories.length,
      itemBuilder: (context, index, realIndex) {
        return _Category(
          category: categories[realIndex],
          left: realIndex == 0 ? 32 : 8,
          right: realIndex == categories.length - 1 ? 32 : 8,
        );
      },
      options: CarouselOptions(
        scrollDirection: Axis.horizontal,
        viewportFraction: 0.8,
        aspectRatio: 1.2,
        initialPage: 0,
        disableCenter: true,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        scrollPhysics: BouncingScrollPhysics(),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  final Category category;
  final double left;
  final double right;
  const _Category({
    required this.category,
    super.key,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: Stack(
        children: [
          Positioned.fill(
            top: 100,
            left: 65,
            right: 65,
            bottom: 18,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: 28, color: Color(0xaa0d253c)),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(32),
              ),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
              foregroundDecoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff0D253C),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'assets/img/posts/large/${category.imageFileName}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 45,
            left: 32,
            child: Text(
              category.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({
    super.key,
    required this.stories,
  });

  final List<StoryData> stories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];

          return _Story(story: story);
        },
      ),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story({
    super.key,
    required this.story,
  });

  final StoryData story;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
      child: Column(
        children: [
          Stack(
            children: [
              story.isViewed ? _profileImageViewed() : _profileImageNormal(),
              Positioned(
                bottom: -3,
                right: -3,
                child: Image.asset(
                  'assets/img/icons/${story.iconFileName}',
                  height: 30,
                  width: 30,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(story.name),
        ],
      ),
    );
  }

  Widget _profileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(19),
      child: Image.asset(
        'assets/img/stories/${story.imageFileName}',
        height: 24,
        width: 24,
      ),
    );
  }

  Widget _profileImageNormal() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            Color(0xff376AED),
            Color(0xff49B0E2),
            Color(0xff9CECFB),
          ],
        ),
      ),
      height: 68,
      width: 68,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
        ),
        margin: EdgeInsets.all(2.5),
        padding: EdgeInsets.all(1),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: _profileImage(),
        ),
      ),
    );
  }

  Widget _profileImageViewed() {
    return Container(
      height: 66,
      width: 66,
      margin: EdgeInsets.all(2),
      child: DottedBorder(
        color: Color(0xff7B8BB2),
        borderType: BorderType.RRect,
        radius: Radius.circular(24),
        strokeWidth: 2.5,
        dashPattern: [6, 3],
        child: Container(
          height: 68,
          width: 68,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(23),
          ),
          padding: EdgeInsets.all(3.5),
          child: _profileImage(),
        ),
      ),
    );
  }
}
