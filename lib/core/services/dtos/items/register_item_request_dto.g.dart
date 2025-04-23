// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_item_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterItemRequestDTO _$RegisterItemRequestDTOFromJson(
        Map<String, dynamic> json) =>
    RegisterItemRequestDTO(
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      categoriesIds: (json['categoriesIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$RegisterItemRequestDTOToJson(
        RegisterItemRequestDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'price': instance.price,
      'quantity': instance.quantity,
      'categoriesIds': instance.categoriesIds,
    };
