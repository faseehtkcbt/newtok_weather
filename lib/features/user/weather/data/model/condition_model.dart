import 'package:newtok_weather/features/user/weather/domain/entity/condition_entity.dart';

class ConditionModel extends ConditionEntity {
  ConditionModel(
      {required super.text, required super.icon, required super.code});

  factory ConditionModel.fromJson(Map<String, dynamic> map) {
    return ConditionModel(
      text: map['text'] ?? '',
      icon: map['icon'] ?? '',
      code: map['code'] ?? 0,
    );
  }
}