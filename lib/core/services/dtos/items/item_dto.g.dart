// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDTO _$ItemDTOFromJson(Map<String, dynamic> json) => ItemDTO(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      imagesPaths: (json['imagesPaths'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ItemDTOToJson(ItemDTO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'price': instance.price,
      'quantity': instance.quantity,
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'imagesPaths': instance.imagesPaths,
    };
