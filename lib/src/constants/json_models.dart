import 'package:json_annotation/json_annotation.dart';

// json_models.g.dart 将在运行生成命令(dart run build_runner build)后自动生成
part 'json_models.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Person {
  /// The generated code assumes these values exist in JSON.
  final String firstName, lastName;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  final DateTime? dateOfBirth;

  //显式关联JSON字段名与Model属性的对应关系
  @JsonKey(name: 'lower_camel_case')
  final int lowerCamelCase;

  Person({
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    this.lowerCamelCase = 0,
  });

  //不同的类使用不同的mixin即可
  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
