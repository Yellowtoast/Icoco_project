import 'package:app/models/reservation.dart';
import 'package:app/models/user.dart';
import 'package:hive/hive.dart';

var userBox = Hive.box<UserModel>('userModel');

var reservationBox = Hive.box<ReservationModel>('reservationModel');
