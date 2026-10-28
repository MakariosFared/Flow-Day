import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsState {
  const SettingsState({
    this.themeMode = ThemeMode.light,
    this.userName = 'عمر السيد',
    this.dailyHoursCap = '6h / day',
    this.availableTime = '09:00 — 17:00',
    this.breakPreference = '15m / 90m',
    this.language = 'ar',
    this.isOfflineReady = true,
  });

  final ThemeMode themeMode;
  final String userName;
  final String dailyHoursCap;
  final String availableTime;
  final String breakPreference;
  final String language; // 'ar' or 'en'
  final bool isOfflineReady;

  SettingsState copyWith({
    ThemeMode? themeMode,
    String? userName,
    String? dailyHoursCap,
    String? availableTime,
    String? breakPreference,
    String? language,
    bool? isOfflineReady,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      userName: userName ?? this.userName,
      dailyHoursCap: dailyHoursCap ?? this.dailyHoursCap,
      availableTime: availableTime ?? this.availableTime,
      breakPreference: breakPreference ?? this.breakPreference,
      language: language ?? this.language,
      isOfflineReady: isOfflineReady ?? this.isOfflineReady,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState());

  void toggleTheme() {
    final next = state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    state = state.copyWith(themeMode: next);
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void setLanguage(String lang) {
    state = state.copyWith(language: lang);
  }

  void updateProfile({String? name, String? availableTime}) {
    state = state.copyWith(
      userName: name ?? state.userName,
      availableTime: availableTime ?? state.availableTime,
    );
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
