// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataModelAdapter extends TypeAdapter<UserDataModel> {
  @override
  final int typeId = 0;

  @override
  UserDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataModel()
      ..name = fields[0] as String
      ..email = fields[1] as String
      ..phone = fields[2] as String
      ..dob = fields[3] as String
      ..password = fields[4] as String
      ..tnc = fields[5] as bool
      ..isactive = fields[6] as bool
      ..address = (fields[7] as List)
          .map((dynamic e) => (e as Map).cast<dynamic, dynamic>())
          .toList()
      ..profileimage = fields[8] as File?
      ..rewards = fields[10] as double?;
  }

  @override
  void write(BinaryWriter writer, UserDataModel obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.address)
      ..writeByte(8)
      ..write(obj.profileimage)
      ..writeByte(10)
      ..write(obj.rewards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
