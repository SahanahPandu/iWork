import 'package:flutter/material.dart';

/// * GLOBAL VARIABLE LIST
/// ** Task **
/// '1' = belum dimulakan
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
ValueNotifier <bool> allSelected = ValueNotifier(false);