import 'package:flutter/material.dart';

//import files
import '../utils/device/devices.dart';

/// * GLOBAL VARIABLE LIST
/// ** Task **
/// '1' = belum mula
/// '2' = sedang bertugas
/// '3' = tugasan selesai'
int statusTask = 1;

/// ** UserRole **
/// '0' = unknown
/// '100' = compactor
/// '200' = pra
/// '300' = supervisor
/// '400' = eo
/// '500' = ba
/// '600' = sam
/// '700' = rom
/// '800' = mech
int userRole = 0;

/// ** User Type ID **
/// '0' = unknown
/// '1' = SWM Staff
/// '2' = SWM Contractor
/// '3' = Vehicle
int userType = 0;

/// ** User Info **
/// [0] = device id
/// [1] = access token
/// [2] = user id
/// [3] = user role
/// [4] = user name

/// ** Compactor Info **
/// [0] = device id
/// [1] = access token
/// [2] = vehicle no
/// [3] = user role
List<String> userInfo = Devices().isPhone()
    ? List.generate(5, (index) => '')
    : List.generate(4, (index) => '');

/// ** User Device Info **
String userDeviceId = '';

/// ** Current Schedule ID **
String scheduleId = '';

/// ** LoginStatus **
/// '0' = unknown
/// '1' = OK
/// '2' = Incorrect credential
/// '3' = Unauthorized/bad request/other errors
/// '4' = Connection errors
/// '5' = Incorrect device id
/// '6' = Access token empty
int loginStatus = 0;

/// ** VCStatus **
bool completedFirstVc = false;
bool completedSecondVc = false;

/// ** Schedule Verification Status **
ValueNotifier<bool> attendanceMainCard = ValueNotifier(true);
ValueNotifier<bool> vcMainCard = ValueNotifier(true);
ValueNotifier<bool> eCutiMainCard = ValueNotifier(true);
ValueNotifier<bool> rescheduleMainCard = ValueNotifier(true);

/// ** Button : show/hide **
ValueNotifier<bool> button = ValueNotifier(true);

/// ** Select All Button **
ValueNotifier<bool> allSelected = ValueNotifier(false);

/// ** Schedule & Vehicle Checklist Status **
ValueNotifier<int> scheduleVcStatus = ValueNotifier(0);
