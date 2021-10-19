# online_course_app - Flutter Template

![Kapture 2021-10-19 at 15 12 10](https://user-images.githubusercontent.com/28912774/137853693-0cb3a4c2-12c8-4e32-812d-d4c2768ffc1e.gif)

![test](https://drive.google.com/uc?export=view&id=1-NAnw5TTfao67R57a2B1rQQhBLuCVOCY)

## Packages

```yaml
# in analysis_options.yaml
  rules:
    prefer_const_constructors: false


# in pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_svg: ^0.20.0-nullsafety.3
  flutter_staggered_grid_view: ^0.4.1

  assets:
    - assets/icons/
    - assets/images/

  fonts:
    - family: Nunito
      fonts:
        - asset: assets/fonts/Nunito/Nunito-Regular.ttf
        - asset: assets/fonts/Nunito/Nunito-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Nunito/Nunito-Bold.ttf
          weight: 700
```

## Check point

### 1.StaggeredGridView

> (Staggered GridView in Flutter)[https://medium.com/flutterdevs/staggered-gridview-in-flutter-661f6667595d]

```dart
// 사용법 잘 익혀 놓을것!!
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
```

### 2.Category data import

- map 함수를 사용해서 json 형식의 data 를 리스트로 가져와서 widget 에 재사용 코드 활용

```dart
// in category.dart

class Category {
  final String name;
  final int numOfCourses;
  final String image;

  // Constructor 생성
  Category(this.name, this.numOfCourses, this.image);
}

// map 함수 사용시 null- safty 로 인해서 item['name'] as String 처럼 String 타입을 alias 로 정확히 지정해주고 사용하는것이 좋다
List<Category> categories = categoriesData
    .map((item) => Category(item['name'] as String, item['courses'] as int,
        item['image'] as String))
    .toList();

var categoriesData = [
  {"name": "Marketing", 'courses': 17, 'image': "assets/images/marketing.png"},
  {"name": "UX Design", 'courses': 25, 'image': "assets/images/ux_design.png"},
  {
    "name": "Photography",
    'courses': 13,
    'image': "assets/images/photography.png"
  },
  {"name": "Business", 'courses': 17, 'image': "assets/images/business.png"},
];
```

### 3.Constants.dart 활용

- 자주 쓰이는 Color 코드 및 textStyle 을 변수화 해서 재사용이 용이하게끔 미리 설정

```dart
// iin constants.dart

import 'package:flutter/material.dart';

// Colors
const kTextColor = Color(0xFF0D1333);
const kBlueColor = Color(0xFF6E8AFA);
const kBestSellerColor = Color(0xFFFFD073);
const kGreenColor = Color(0xFF49CC96);
const kBoxColor = Color(0xFFF5F5F7);
const kDetailBox = Color(0xFFF5F4EF);

// My Text Styles
const kHeadingextStyle = TextStyle(
  fontSize: 28,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);
const kSubheadingextStyle = TextStyle(
  fontSize: 24,
  color: Color(0xFF61688B),
  height: 2,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kSubtitleTextSyule = TextStyle(
  fontSize: 18,
  color: kTextColor,
  // fontWeight: FontWeight.bold,
);

const kSearch = TextStyle(
  fontSize: 18,
  color: Color(0xFFA0A5BD),
  // fontWeight: FontWeight.bold,
);

```

### 4.ClipPath 를 통해 모형 만들기

- 모형을 변환해서 디자인 할 수 있는 path 설정하는법

> [ClipRRect & ClipPath In Flutter](https://medium.com/flutterdevs/cliprrect-clippath-in-flutter-4c41abe4e8)

```dart
ClipPath(
  clipper: BestSellorClipper(),
  child: Container(
    color: kBestSellerColor,
    padding: EdgeInsets.only(
        left: 10, top: 5, right: 20, bottom: 5),
    child: Text(
      "BestSeller".toUpperCase(),
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
),

class BestSellorClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}

```

## reference

The Flutter Way - [https://youtu.be/8abMF1Y2Xnk](https://youtu.be/8abMF1Y2Xnk)

Staggered GridView in Flutter - [https://medium.com/flutterdevs/staggered-gridview-in-flutter-661f6667595d](https://medium.com/flutterdevs/staggered-gridview-in-flutter-661f6667595d)

ClipRRect & ClipPath In Flutter - [https://medium.com/flutterdevs/cliprrect-clippath-in-flutter-4c41abe4e8](https://medium.com/flutterdevs/cliprrect-clippath-in-flutter-4c41abe4e8)
