import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_course_app/constants.dart';
import 'package:online_course_app/detail_screen.dart';
import 'package:online_course_app/model/category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course App',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/0': (context) => DetailScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // MenuBar, Avatar
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset("assets/icons/menu.svg"),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/images/Jacob_avatar.png"),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Title
            Text("Hello Jacob,", style: kHeadingextStyle),
            Text("Find a course what you want", style: kSubheadingextStyle),
            // Search Container
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kBoxColor,
                borderRadius: BorderRadius.circular(40),
              ),
              // Search child
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Search for anything",
                    style: kSearch,
                  )
                ],
              ),
            ),
            // Category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Category", style: kTitleTextStyle),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See All",
                    style: kSubtitleTextSyule.copyWith(color: kBlueColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // StaggeredGridView
            // 사용법 Reference 에서 익히기
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(0),
                crossAxisCount: 2,
                itemCount: categories.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/$index');
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      // index 번호 가 짝수 일경우 높이를 다르게 표현함
                      height: index.isEven ? 200 : 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(categories[index].image),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            categories[index].name,
                            style: kTitleTextStyle,
                          ),
                          Text(
                            '${categories[index].numOfCourses} Courses',
                            style: TextStyle(
                              color: kTextColor.withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
