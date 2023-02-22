import 'package:blogclub/data.dart';
import 'package:blogclub/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gen/assets.gen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final posts = AppDatabase.posts;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                elevation: 0,
                backgroundColor:
                    themeData.colorScheme.background.withOpacity(0.2),
                title: Text('Profile'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.more_horiz_rounded),
                    onPressed: () {},
                  ),
                  SizedBox(width: 16),
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(32, 0, 32, 64),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: themeData.colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          color:
                              themeData.colorScheme.onBackground.withOpacity(0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Assets.img.stories.story8
                                    .image(width: 84, height: 84),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('@joviedan'),
                                    SizedBox(height: 4),
                                    Text(
                                      'Jovie Daniel',
                                      style: themeData.textTheme.bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'UX Designer',
                                      style: themeData.textTheme.bodyLarge!
                                          .apply(
                                              color: themeData
                                                  .colorScheme.primary),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 32),
                          Text(
                            'About me',
                            style: themeData.textTheme.titleLarge,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Madison Blackstone is a director of user experience design, with experience managing global teams.',
                            style: themeData.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w200),
                          ),
                          SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 32,
                    right: 96,
                    left: 96,
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 30,
                              color: themeData.colorScheme.onBackground
                                  .withOpacity(0.8))
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 32,
                    left: 64,
                    right: 64,
                    child: Container(
                      height: 68,
                      decoration: BoxDecoration(
                        color: themeData.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0xff2151cd),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '52',
                                    style: themeData.textTheme.headlineMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Post',
                                    style: themeData.textTheme.bodyLarge!
                                        .copyWith(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '250',
                                  style: themeData.textTheme.headlineMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Follwing',
                                  style: themeData.textTheme.bodyLarge!
                                      .copyWith(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '4.5K',
                                  style: themeData.textTheme.headlineMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Followers',
                                  style: themeData.textTheme.bodyLarge!
                                      .copyWith(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: themeData.colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32),
                    topLeft: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'My Posts',
                              style: themeData.textTheme.titleLarge,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.square_grid_2x2),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.list_bullet),
                          ),
                        ],
                      ),
                    ),
                    for (int i = 0; i < posts.length; i++) Post(post: posts[i])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
