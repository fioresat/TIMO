class SingleTaskModel {
  int colorIndex;
  bool isActive = false;
  String task;

  SingleTaskModel({
    this.colorIndex = -1,
    this.isActive = false,
    required this.task,
  });
}
