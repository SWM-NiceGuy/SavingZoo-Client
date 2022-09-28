class MissionDetail {
  String name;
  String detailImageUrl;
  String description;
  List<String> exampleImageUrls;
  int reward;
  String state;

  MissionDetail({
    required this.name,
    required this.detailImageUrl,
    required this.description,
    required this.exampleImageUrls,
    required this.reward,
    required this.state,
  });
}