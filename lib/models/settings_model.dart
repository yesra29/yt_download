import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  // Download Settings
  bool autoDownloadOnWifiOnly = true;
  String defaultDownloadQuality = '720p';
  String downloadLocation = '';
  bool createFolderPerDownload = false;
  
  // Playback Settings
  bool autoPlayDownloadedVideos = false;
  bool showThumbnailInList = true;
  
  // Storage Settings
  bool deleteOriginalAfterConversion = false;
  bool autoDeleteOldDownloads = false;
  int keepDownloadsForDays = 30;
  
  // Notification Settings
  bool showDownloadNotifications = true;
  bool showCompletionNotifications = true;
  
  // Theme Settings
  bool isDarkMode = false;
  
  // Save settings to SharedPreferences
  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoDownloadOnWifiOnly', autoDownloadOnWifiOnly);
    await prefs.setString('defaultDownloadQuality', defaultDownloadQuality);
    await prefs.setString('downloadLocation', downloadLocation);
    await prefs.setBool('createFolderPerDownload', createFolderPerDownload);
    await prefs.setBool('autoPlayDownloadedVideos', autoPlayDownloadedVideos);
    await prefs.setBool('showThumbnailInList', showThumbnailInList);
    await prefs.setBool('deleteOriginalAfterConversion', deleteOriginalAfterConversion);
    await prefs.setBool('autoDeleteOldDownloads', autoDeleteOldDownloads);
    await prefs.setInt('keepDownloadsForDays', keepDownloadsForDays);
    await prefs.setBool('showDownloadNotifications', showDownloadNotifications);
    await prefs.setBool('showCompletionNotifications', showCompletionNotifications);
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  // Load settings from SharedPreferences
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    autoDownloadOnWifiOnly = prefs.getBool('autoDownloadOnWifiOnly') ?? true;
    defaultDownloadQuality = prefs.getString('defaultDownloadQuality') ?? '720p';
    downloadLocation = prefs.getString('downloadLocation') ?? '';
    createFolderPerDownload = prefs.getBool('createFolderPerDownload') ?? false;
    autoPlayDownloadedVideos = prefs.getBool('autoPlayDownloadedVideos') ?? false;
    showThumbnailInList = prefs.getBool('showThumbnailInList') ?? true;
    deleteOriginalAfterConversion = prefs.getBool('deleteOriginalAfterConversion') ?? false;
    autoDeleteOldDownloads = prefs.getBool('autoDeleteOldDownloads') ?? false;
    keepDownloadsForDays = prefs.getInt('keepDownloadsForDays') ?? 30;
    showDownloadNotifications = prefs.getBool('showDownloadNotifications') ?? true;
    showCompletionNotifications = prefs.getBool('showCompletionNotifications') ?? true;
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
  }
} 