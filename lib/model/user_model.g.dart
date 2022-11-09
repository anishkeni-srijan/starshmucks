// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataAdapter extends TypeAdapter<UserData> {
  @override
  final int typeId = 0;

  @override
  UserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserData()
      ..name = fields[0] as String
      ..email = fields[1] as String
      ..phone = fields[2] as String
      ..dob = fields[3] as String
      ..password = fields[4] as String
      ..tnc = fields[5] as bool
      ..isactive = fields[6] as bool
      ..address = (fields[7] as List).cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, UserData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.dob)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.tnc)
      ..writeByte(6)
      ..write(obj.isactive)
      ..writeByte(7)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
