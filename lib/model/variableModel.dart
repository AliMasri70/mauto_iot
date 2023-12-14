// ignore: file_names
class VariableModel {
  String? variableID;
  String? vName;
  String? startingValue;
  bool? retentive;
  String? type;
  String? subTopicName;
  String? subTopicValueType;
  String? pubTopicName;
  String? pubTopicValueType;
  String? value;
  String? topicType;
  String? topicTitle;

  VariableModel({
    this.variableID,
    this.vName,
    this.startingValue,
    this.retentive,
    this.type,
    this.subTopicName,
    this.subTopicValueType,
    this.pubTopicName,
    this.pubTopicValueType,
    this.value,
    this.topicTitle,
    this.topicType,
  });

  factory VariableModel.fromJson(Map<String, dynamic> parsedJson) {
    return VariableModel(
      variableID: parsedJson['variableID'] ?? "",
      vName: parsedJson['vName'] ?? "",
      startingValue: parsedJson['startingValue'] ?? "",
      retentive: parsedJson['retentive'] ?? "",
      type: parsedJson['type'] ?? "",
      subTopicName: parsedJson['subTopicName'] ?? "",
      subTopicValueType: parsedJson['subTopicValueType'] ?? "",
      pubTopicName: parsedJson['pubTopicName'] ?? "",
      pubTopicValueType: parsedJson['pubTopicValueType'] ?? "",
      value: parsedJson['value'] ?? "",
      topicType: parsedJson['topicType'] ?? "",
      topicTitle: parsedJson['topicTitle'] ?? "",
    );
  }
}
