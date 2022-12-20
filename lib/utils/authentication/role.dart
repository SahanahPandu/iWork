//import files
import '../../config/config.dart';

class Roles {
  static const roleComp = "COMP";
  static const rolePra = "PRA";
  static const roleSv = "SV";
  static const roleEo = "EO";
  static const roleBa = "BA";
  static const roleSam = "SAM";
  static const roleRom = "ROM";
  static const roleMech = "MECH";
  static const roleContractor = "CONTRACTOR";

  static int? setRole(String roleID) {
    switch (roleID) {
      case roleComp:
        return userRole = 100;
      case rolePra:
        return userRole = 200;
      case roleSv:
        return userRole = 300;
      case roleEo:
        return userRole = 400;
      case roleBa:
        return userRole = 500;
      case roleSam:
        return userRole = 600;
      case roleRom:
        return userRole = 700;
      case roleMech:
        return userRole = 800;
      case roleContractor:
        return userRole = 1000;
      default:
        return userRole = 0;
    }
  }
}
