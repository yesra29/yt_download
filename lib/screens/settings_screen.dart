import 'package:flutter/material.dart';
import '../models/settings_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AppSettings settings = AppSettings();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    await settings.loadSettings();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            'Download Settings',
            [
              SwitchListTile(
                title: const Text('Download on Wi-Fi only'),
                subtitle: const Text('Save mobile data by downloading only on Wi-Fi'),
                value: settings.autoDownloadOnWifiOnly,
                onChanged: (value) {
                  setState(() {
                    settings.autoDownloadOnWifiOnly = value;
                    settings.saveSettings();
                  });
                },
              ),
              ListTile(
                title: const Text('Default Download Quality'),
                subtitle: Text(settings.defaultDownloadQuality),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Show quality selection dialog
                },
              ),
              SwitchListTile(
                title: const Text('Create Folder Per Download'),
                subtitle: const Text('Organize videos in separate folders'),
                value: settings.createFolderPerDownload,
                onChanged: (value) {
                  setState(() {
                    settings.createFolderPerDownload = value;
                    settings.saveSettings();
                  });
                },
              ),
            ],
          ),
          _buildSection(
            'Playback Settings',
            [
              SwitchListTile(
                title: const Text('Auto-play Downloaded Videos'),
                value: settings.autoPlayDownloadedVideos,
                onChanged: (value) {
                  setState(() {
                    settings.autoPlayDownloadedVideos = value;
                    settings.saveSettings();
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Show Thumbnails'),
                subtitle: const Text('Display video thumbnails in the list'),
                value: settings.showThumbnailInList,
                onChanged: (value) {
                  setState(() {
                    settings.showThumbnailInList = value;
                    settings.saveSettings();
                  });
                },
              ),
            ],
          ),
          _buildSection(
            'Storage Settings',
            [
              SwitchListTile(
                title: const Text('Auto-delete Old Downloads'),
                value: settings.autoDeleteOldDownloads,
                onChanged: (value) {
                  setState(() {
                    settings.autoDeleteOldDownloads = value;
                    settings.saveSettings();
                  });
                },
              ),
              ListTile(
                title: const Text('Keep Downloads For'),
                subtitle: Text('${settings.keepDownloadsForDays} days'),
                enabled: settings.autoDeleteOldDownloads,
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Show days selection dialog
                },
              ),
            ],
          ),
          _buildSection(
            'Notification Settings',
            [
              SwitchListTile(
                title: const Text('Download Notifications'),
                value: settings.showDownloadNotifications,
                onChanged: (value) {
                  setState(() {
                    settings.showDownloadNotifications = value;
                    settings.saveSettings();
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Completion Notifications'),
                value: settings.showCompletionNotifications,
                onChanged: (value) {
                  setState(() {
                    settings.showCompletionNotifications = value;
                    settings.saveSettings();
                  });
                },
              ),
            ],
          ),
          _buildSection(
            'Theme Settings',
            [
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: settings.isDarkMode,
                onChanged: (value) {
                  setState(() {
                    settings.isDarkMode = value;
                    settings.saveSettings();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }
} 