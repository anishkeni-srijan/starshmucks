// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartDataAdapter extends TypeAdapter<CartData> {
  @override
  final int typeId = 0;

  @override
  CartData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartData()
      ..title = fields[0] as String
      ..price = fields[1] as String
      ..qty = fields[2] as int
      ..isInCart = fields[3] as bool
      ..image = fields[4] as String
      ..ttlPrice = fields[5] as double;
  }

  @override
  void write(BinaryWriter writer, CartData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.qty)
      ..writeByte(3)
      ..write(obj.isInCart)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.ttlPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
