import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//import files
import '../utils/device/devices.dart';

/// * GLOBAL VARIABLE LIST
/// ** Schedule & Vehicle Checklist Status
/// '0' = null (undone VC, undone start/stop work)
/// '1' = done vc before
/// '2' = done vc before, done start work
/// '3' = done vc before, done start work, done stop work
/// '4' = done vc before, done start work, done stop work, done vc after
ValueNotifier<int> scheduleVcStatus = ValueNotifier(0);

/// ** Schedule Verification Status **
ValueNotifier<bool> attendanceMainCard = ValueNotifier(true);
ValueNotifier<bool> vcMainCard = ValueNotifier(true);
ValueNotifier<bool> eCutiMainCard = ValueNotifier(true);
ValueNotifier<bool> rescheduleMainCard = ValueNotifier(true);

/// ** Button : show/hide **
ValueNotifier<bool> button = ValueNotifier(true);

/// ** Select All Button **
ValueNotifier<bool> allSelected = ValueNotifier(false);

/// ** Refresh Main page of App Variable ***
ValueNotifier<bool> refresh = ValueNotifier(false);

/// ** Refresh Report List from Issued Schedule Variable ***
ValueNotifier<bool> refreshReportList = ValueNotifier(false);

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
/// [2] = user login id
/// [3] = user role
/// [4] = user name
/// [5] = user id

/// ** Compactor Info **
/// [0] = device id
/// [1] = access token
/// [2] = vehicle no
/// [3] = user role
List<String> userInfo = Devices().isPhone()
    ? List.generate(6, (index) => '')
    : List.generate(4, (index) => '');

/// ** User Device Info **
String userDeviceId = '';

/// ** Current Schedule ID **
String scheduleId = '';

/// ** The Server IP Adress ***
// String theBase = "http://103.26.46.187:81/api";
String theBase = "http://iworkapi.swmsb.com/api";

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

/// ** Schedule Listing Condition **
bool isTaskDataFetched = false;
bool isTaskExist = false;
bool onGoingTask = false;
bool otherDate = false;
int listLength = 0;
int vcStatus = 0;
List<int> cpSchedule = List.generate(listLength, (index) => 0);
List<String> routeNames = List.generate(listLength, (index) => '');
String selectedNewDate = "";
ValueNotifier<bool> reachedBottom = ValueNotifier(false);

/// ** Dio Error Types **
/// '0' = No error
/// '1' = No internet connection
/// '2' = Connect timeout
/// '3' = Receive timeout
/// '4' = 400 - Bad Request
/// '5' = 401 - Token expired/invalid/unauthenticated
/// '6' = 404 - Not found/URL is not recognized
/// '7' = 405 - Method not found
/// '8' = 500 - Internal Server Error
/// '9' = 502 - Bad Getaway
/// '10' = Server is offline
/// '11' = Backend returns null value/Unable to map into modal
ValueNotifier<int> dioError = ValueNotifier(0);

bool isLoading = true;
bool hasMore = true;
String nextPageUrl = "";

/// Geo Location
String? currentAddress;
Position? currentPosition;

/// Selected worker from attendance list
var tickedWorker = [];

/// Selected worker from request worker list
var tickedRequestedWorker = [];

/// Approval worker from request worker list
var approvalRequestedWorker = [];
