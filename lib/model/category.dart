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
