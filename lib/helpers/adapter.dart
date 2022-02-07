import 'package:app/models/reservation.dart';
import 'package:app/models/user.dart';
import 'package:hive/hive.dart';

class UserAdapter extends TypeAdapter<UserModel> {
  @override
  final typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    return UserModel.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.write(obj.toJson());
  }
}

class ReservationAdapter extends TypeAdapter<ReservationModel> {
  @override
  final typeId = 1;

  @override
  ReservationModel read(BinaryReader reader) {
    return ReservationModel.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, ReservationModel obj) {
    writer.write(obj.toJson());
  }
}
