class MissionDetail {
  String name;
  String content;
  String description;
  List<String> exampleImageUrls;
  String submitGuide;
  int reward;
  String state;

  MissionDetail({
    required this.name,
    required this.description,
    required this.content,
    required this.submitGuide,
    required this.exampleImageUrls,
    required this.reward,
    required this.state,
  });
}